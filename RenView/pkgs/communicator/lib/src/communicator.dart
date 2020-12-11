import 'dart:convert';
import 'dart:io' as io show HttpHeaders;

import 'package:meta/meta.dart';
import 'package:plain_optional/plain_optional.dart';

import 'api_call_results.dart';
import 'http_client.dart';
import 'models.dart';
import 'request_builder.dart';

class Communicator {
  Communicator({
    @required Optional<String> Function() getSessionToken,
  })  : requestBuilder = RequestBuilder(getSessionToken: getSessionToken),
        httpClient = HttpClient();

  Future<LoginResponse> login({
    @required String email,
    @required String password,
  }) async {
    final request = requestBuilder.build(
      endpoint: 'auth',
      authorized: false,
      customHeaders: {io.HttpHeaders.authorizationHeader: 'Basic ${_encodeCredentials(email, password)}'},
    );

    try {
      final response = await httpClient.request('POST', request);

      final token = response.body['token'] as String;
      final user = User.fromJson(response.body['user'] as Map<String, dynamic>);

      return LoginResponse(token: token, user: user);
    } on InvalidResponseException catch (e) {
      if (e.response.statusCode == 401) {
        throw LoginException(reason: LoginFailureReason.wrongCredentials);
      } else {
        throw LoginException(reason: LoginFailureReason.unknown);
      }
    } on Exception {
      throw LoginException(reason: LoginFailureReason.unknown);
    }
  }

  Future<void> register({
    @required String name,
    @required bool isOwner,
    @required String email,
    @required String password,
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

    await httpClient.request('POST', request);
  }

  Future<Restaurants> fetchRestaurants({
    String ownerId,
  }) async {
    final request = requestBuilder.build(
      endpoint: 'restaurants',
      authorized: true,
      customQueryParameters: {
        if (ownerId != null) 'owner': ownerId,
      },
    );

    final response = await httpClient.request('GET', request);

    return Restaurants.fromJson(response.body as List<dynamic>);
  }

  Future<Restaurant> createRestaurant({
    @required String name,
    @required String address,
  }) async {
    final request = requestBuilder.build(
     endpoint: 'restaurants',
     authorized: true,
     body: <String, dynamic>{
       'name': name,
       'address': address,
     },
    );

    final response = await httpClient.request('POST', request);

    return Restaurant.fromJson(response.body as Map<String, dynamic>);
  }

  final RequestBuilder requestBuilder;
  final HttpClient httpClient;
}

String _encodeCredentials(String email, String password) => base64.encode(utf8.encode('$email:$password'));
