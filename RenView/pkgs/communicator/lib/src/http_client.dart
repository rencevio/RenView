import 'dart:async';
import 'dart:convert';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

import 'request_builder.dart';

class InvalidResponseException implements Exception {
  const InvalidResponseException({@required this.response});

  @override
  String toString() => 'Invalid response to url ${response.requestURL}, status code: ${response.statusCode}';

  final HttpResponse response;
}

class HttpResponse {
  HttpResponse({
    @required this.requestURL,
    @required this.body,
    @required this.statusCode,
  });

  final Uri requestURL;
  final dynamic body;
  final int statusCode;
}

class HttpClient {
  HttpClient() : _client = http.Client();

  Future<HttpResponse> request(
    String method,
    Request request,
  ) async {
    final httpResponse = await http.Response.fromStream(await _client.send(request.asHttpRequest(method)));

    final dynamic body =
        httpResponse.body != null && httpResponse.body.isNotEmpty ? json.decode(httpResponse.body) : null;

    final response = HttpResponse(
      requestURL: request.url,
      body: body,
      statusCode: httpResponse.statusCode,
    );

    print('HTTP: request: $request');
    print('HTTP: response: ${response.statusCode}, ${response.body}');

    return _validateResponse(response);
  }

  HttpResponse _validateResponse(HttpResponse response) {
    if (!(response.statusCode >= 200 && response.statusCode < 300)) {
      throw InvalidResponseException(response: response);
    }

    return response;
  }

  void close() => _client.close();

  final http.Client _client;
}
