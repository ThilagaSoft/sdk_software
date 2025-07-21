import 'package:code_task/model/weather_model.dart';
import 'package:code_task/service/weather_api_service.dart';

class WeatherRepository
{
  final WeatherApi api;
  WeatherRepository({required this.api});
  Future<Weather> getWeather(String city) async
  {
    final loc = await api.geocode(city);
    final current = await api.fetchCurrent(loc['latitude'], loc['longitude']);
    return Weather(
      city: loc['name'],
      temperature: (current['temperature'] as num).toDouble(),
      weatherCode: current['weathercode'] as int,
      isDay: current['is_day'] as int,
    );
  }
  Future<Weather> getWeatherByLatLong(double lat, double lon) async
  {

    final current = await api.fetchCurrent(lat, lon);
    final cityName = await api.reverseGeocode(lat, lon);
    return Weather(
      city:cityName,
      temperature: (current['temperature'] as num).toDouble(),
      weatherCode: current['weathercode'] as int,
      isDay: current['is_day'] as int,
    );

  }
}
