import 'dart:convert';
import 'dart:io' as io show HttpHeaders;

import 'package:meta/meta.dart';
import 'package:plain_optional/plain_optional.dart';

import '../communicator.dart';
import 'http_client.dart';
import 'request_builder.dart';

class Communicator {
  Communicator({
    @required Optional<String> Function() getSessionToken,
  })  : requestBuilder = RequestBuilder(getSessionToken: getSessionToken),
        httpClient = HttpClient();

  Future<void> login({
    @required String email,
    @required String password,
    @required void Function(String token) onSuccess,
    @required void Function(LoginFailureReason) onError,
  }) async {
    final request = requestBuilder.build(endpoint: 'auth');

    final basicAuthenticationHeader =
        MapEntry(io.HttpHeaders.authorizationHeader, 'Basic ${_encodeCredentials(email, password)}');

    try {
      final response = await httpClient.request(
        'POST',
        request.copyWith(
          headers: request.headers..addEntries([basicAuthenticationHeader]),
        ),
      );

      final token = response.body['token'] as String;

      onSuccess(token);
    } on InvalidResponseException catch (e) {
      if (e.response.statusCode == 401) {
        onError(LoginFailureReason.wrongCredentials);
      } else {
        onError(LoginFailureReason.unknown);
      }
    } on Exception {
      onError(LoginFailureReason.unknown);
    }
  }

  Future<void> register({
    @required String name,
    @required bool isOwner,
    @required String email,
    @required String password,
    @required void Function() onSuccess,
    @required void Function() onError,
  }) async {
    final request = requestBuilder.build(
      endpoint: 'users',
      body: <String, dynamic>{
        'email': email,
        'name': name,
        'password': password,
        'role': isOwner ? 'owner' : 'user',
      },
    );

    try {
      await httpClient.request('POST', request);
      onSuccess();
    } on Exception {
      onError();
    }
  }

  final RequestBuilder requestBuilder;
  final HttpClient httpClient;
}

String _encodeCredentials(String email, String password) => base64.encode(utf8.encode('$email:$password'));
