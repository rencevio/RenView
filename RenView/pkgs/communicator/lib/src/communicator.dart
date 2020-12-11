import 'dart:convert';
import 'dart:io' as io show HttpHeaders;

import 'package:meta/meta.dart';
import 'package:plain_optional/plain_optional.dart';

import '../communicator.dart';
import 'http_client.dart';
import 'models.dart';
import 'request_builder.dart';

class Communicator {
  Communicator({
    @required Optional<String> Function() getSessionToken,
  })  : requestBuilder = RequestBuilder(getSessionToken: getSessionToken),
        httpClient = HttpClient();

  Future<void> login({
    @required String email,
    @required String password,
    @required void Function({User user, String token}) onSuccess,
    @required void Function(LoginFailureReason) onError,
  }) async {
    final request = requestBuilder.build(
      endpoint: 'auth',
      authorized: false,
      customHeaders: {io.HttpHeaders.authorizationHeader: 'Basic ${_encodeCredentials(email, password)}'},
    );

    try {
      final response = await httpClient.request('POST', request);

      final token = response.body['token'] as String;
      final user = User.fromJson(response.body as Map<String, dynamic>);

      onSuccess(token: token, user: user);
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
      authorized: false,
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

  Future<void> fetchRestaurants({
    @required void Function(Restaurants) onSuccess,
    @required void Function() onError,
    String ownerId,
  }) async {
    final request = requestBuilder.build(
      endpoint: 'restaurants',
      authorized: true,
      customQueryParameters: {
        if (ownerId != null) 'owner': ownerId,
      },
    );

    try {
      final response = await httpClient.request('GET', request);
      final restaurants = Restaurants.fromJson(response.body as List<dynamic>);

      onSuccess(restaurants);
    } on Exception {
      onError();
    }
  }

  final RequestBuilder requestBuilder;
  final HttpClient httpClient;
}

String _encodeCredentials(String email, String password) => base64.encode(utf8.encode('$email:$password'));
