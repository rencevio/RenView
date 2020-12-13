import 'dart:convert';
import 'dart:io' as io show HttpHeaders;

import 'package:meta/meta.dart';
import 'package:plain_optional/plain_optional.dart';
import 'package:utils/utils.dart';

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

  Future<void> editRestaurant({
    @required String id,
    String name,
    String address,
  }) async {
    final request = requestBuilder.build(
      endpoint: 'restaurants/$id',
      authorized: true,
      body: <String, dynamic>{
        if (name != null) 'name': name,
        if (address != null) 'address': address,
      },
    );

    await httpClient.request('PUT', request);
  }

  Future<void> deleteRestaurant({
    @required String id,
  }) async {
    final request = requestBuilder.build(
      endpoint: 'restaurants/$id',
      authorized: true,
    );

    await httpClient.request('DELETE', request);
  }

  Future<Reviews> fetchReviewsForRestaurant(String restaurantId) async {
    final request = requestBuilder.build(
      endpoint: 'reviews',
      authorized: false,
      customQueryParameters: {
        'restaurant': restaurantId,
      },
    );

    final response = await httpClient.request('GET', request);

    return Reviews.fromJson(response.body as List<dynamic>);
  }

  Future<Review> createReview({
    @required String restaurantId,
    @required int rating,
    @required DateTime visitDate,
    String comment,
  }) async {
    final request = requestBuilder.build(
      endpoint: 'reviews',
      authorized: true,
      body: <String, dynamic>{
        'restaurant': restaurantId,
        'rating': rating.toString(),
        'visitDate': visitDate.yearMonthDay,
        if (comment != null && comment.isNotEmpty) 'comment': comment,
      },
    );

    final response = await httpClient.request('POST', request);

    return Review.fromJson(response.body as Map<String, dynamic>);
  }

  Future<void> editReview({
    @required String reviewId,
    @required int rating,
    @required DateTime visitDate,
    String comment,
  }) async {
    final request = requestBuilder.build(
      endpoint: 'reviews/$reviewId',
      authorized: true,
      body: <String, dynamic>{
        'rating': rating.toString(),
        'visitDate': visitDate.yearMonthDay,
        if (comment != null && comment.isNotEmpty) 'comment': comment,
      },
    );

    await httpClient.request('PUT', request);
  }

  Future<void> replyToReview({@required String reviewId, @required String reply}) async {
    final request = requestBuilder.build(
      endpoint: 'reviews/$reviewId/reply',
      authorized: true,
      body: <String, dynamic>{
        'reply': reply,
      },
    );

    await httpClient.request('POST', request);
  }

  Future<Reviews> fetchPendingReviews() async {
    final request = requestBuilder.build(
      endpoint: 'reviews/pending',
      authorized: true,
    );

    final response = await httpClient.request('GET', request);

    return Reviews.fromJson(response.body as List<dynamic>);
  }

  final RequestBuilder requestBuilder;
  final HttpClient httpClient;
}

String _encodeCredentials(String email, String password) => base64.encode(utf8.encode('$email:$password'));
