import 'package:code_task/config/api_base.dart';
import 'package:code_task/repository/api_client.dart';
import 'package:geolocator/geolocator.dart';

class WeatherApi {
  final ApiClient _apiClient = ApiClient();

  Future<Map<String, dynamic>> geocode(String city) async
  {
    final url = '${ApiBaseUrl.baseOpenMeteoUrl}?name=$city&count=1';
    final data = await _apiClient.get(url);
    if ((data['results'] as List).isEmpty) throw Exception('City not found');
    return data['results'][0];
  }

  Future<Map<String, dynamic>> fetchCurrent(double lat, double lon) async
  {
    final url = '${ApiBaseUrl.baseGeocodingUrl}?latitude=$lat&longitude=$lon&current_weather=true';
    final data = await _apiClient.get(url);
    return data['current_weather'];
  }

  Future<Position> getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) throw Exception('Location services are disabled.');

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permissions are permanently denied.');
    }

    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  Future<String> reverseGeocode(double lat, double lon) async {
    final url =
        '${ApiBaseUrl.baseReverseUrl}?lat=$lat&lon=$lon&format=json';
    final data = await _apiClient.get(url);
    if (data['address'] != null && data['address'].isNotEmpty) {
      return data['address']['suburb'] ?? 'Unknown location';
    } else {
      return 'Unknown location';
    }
  }
}
