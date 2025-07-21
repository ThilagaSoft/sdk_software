import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiClient {
  final http.Client httpClient;

  ApiClient({http.Client? httpClient}) : httpClient = httpClient ?? http.Client();

  Future<dynamic> get(String url) async {
    print(url);
    final uri = Uri.parse(url);
    final response = await httpClient.get(uri);
   print(response.body);
    if (response.statusCode >= 200 && response.statusCode < 300)
    {
      return json.decode(response.body);
    }
    else
    {
      throw ApiException(
        message: 'Failed to fetch data',
        statusCode: response.statusCode,
        body: response.body,
      );
    }
  }
}

class ApiException implements Exception {
  final String message;
  final int? statusCode;
  final String? body;

  ApiException({required this.message, this.statusCode, this.body});

  @override
  String toString() {
    return 'ApiException: $message (Status: $statusCode)';
  }
}
