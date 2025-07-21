import 'package:code_task/bloc/weather/weather_event.dart';
import 'package:code_task/bloc/weather/weather_state.dart';
import 'package:code_task/repository/weather_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository repository;

  WeatherBloc(this.repository) : super(WeatherInitial())
  {
    on<FetchWeather>(onFetchWeather);
    on<FetchWeatherByLocation>(onFetchWeatherByLocation);
  }

  Future<void> onFetchWeather(FetchWeather event, Emitter<WeatherState> emit) async {
    emit(WeatherLoading());
    try
    {
      final weather = await repository.getWeather(event.city);
      emit(WeatherLoaded(weather));
    } catch (e)
    {
      emit(WeatherError('City is not found'));
    }
  }

  Future<void> onFetchWeatherByLocation(FetchWeatherByLocation event, Emitter<WeatherState> emit) async {
    emit(WeatherLoading());
    try {
      final pos = await repository.api.getCurrentLocation();
      final weather = await repository.getWeatherByLatLong(pos.latitude, pos.longitude);
      emit(WeatherLoaded(weather));
    } catch (e) {
      emit(WeatherError('Failed to load weather by location: ${e.toString()}'));
    }
  }
}
