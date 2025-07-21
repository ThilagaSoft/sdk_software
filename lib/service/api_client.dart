import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class ApiClient {
  final Map<String, String> _defaultHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'User-Agent': 'YourAppName/1.0 (your_email@example.com)', // Required by Nominatim
  };

  Future<dynamic> get(String url, {Map<String, String>? headers}) async {
    try {
      final uri = Uri.parse(url);
      final response = await http.get(uri, headers: headers ?? _defaultHeaders);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return jsonDecode(response.body);
      } else {
        throw HttpException(
          'Request failed with status: ${response.statusCode}',
          uri: uri,
        );
      }
    } on SocketException {
      throw Exception('No internet connection');
    } on FormatException {
      throw Exception('Invalid response format');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}
