import 'package:code_task/bloc/weather/weather_bloc.dart';
import 'package:code_task/bloc/weather/weather_event.dart';
import 'package:code_task/bloc/weather/weather_state.dart';
import 'package:code_task/config/common_function.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
        backgroundColor: Colors.indigoAccent,
        centerTitle: true,
        title: const Text('Weather Condition',
            style: TextStyle(fontSize: 22, color:Colors.white,fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            BlocBuilder<WeatherBloc, WeatherState>(
            builder: (context, state) {
              if (state is WeatherLoaded)
              {
                return _buildWeatherHintBox(state.weather);
              }
              else if(state is WeatherError)
                {
                  return _buildErrorHintBox(state.message);

                }
              return const SizedBox(); // empty if not loaded
            },
          ),
            const SizedBox(height: 12),
            _buildSearchBar(context),
            const SizedBox(height: 24),
            BlocBuilder<WeatherBloc, WeatherState>(
                builder: (context, state) {
                if (state is WeatherLoaded)
                  {
                    return Expanded(child: _buildWeatherDisplay());

                  }
                else if(state is WeatherError)
                  {
                   return _buildErrorHintBox(state.message);
                  }
                return const SizedBox(); // empty if not loaded

                }
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 16),
                hintText: 'Search city...',
                border: InputBorder.none,
              ),
              onSubmitted: (city) {
                context.read<WeatherBloc>().add(FetchWeather(city));
              },
            ),
          ),
          IconButton(
            onPressed: () {
              context.read<WeatherBloc>().add(FetchWeatherByLocation());
            },
            icon: const Icon(FontAwesomeIcons.locationCrosshairs,
                color: Colors.indigo),
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherDisplay() {
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        if (state is WeatherInitial) {
          return const Center(child: Text('Enter a city to begin'));
        } else if (state is WeatherLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is WeatherLoaded) {
          final w = state.weather;
          return Center(
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              elevation: 8,
              child: Container(
                padding: const EdgeInsets.all(24),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    colors: [Colors.indigoAccent, Colors.lightBlueAccent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(w.city,
                        style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                    const SizedBox(height: 12),
                    Icon(
                      getWeatherIcon(w.weatherCode, w.isDay == 1),
                      size: 64,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 12),
                    Text('${w.temperature}°C',
                        style: const TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.w300,
                            color: Colors.white)),
                  ],
                ),
              ),
            ),
          );
        } else if (state is WeatherError) {
          return Center(
            child: Text(
              state.message,
              style: const TextStyle(color: Colors.red, fontSize: 16),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
  Widget _buildWeatherHintBox(weather) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Current Weather in ${weather.city}',
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.indigo),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(
                getWeatherIcon(weather.weatherCode, weather.isDay == 1),
                color: Colors.indigo,
                size: 28,
              ),
              const SizedBox(width: 12),
              Text(
                '${weather.temperature}°C',
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            'Condition: ${getWeatherConditionName(weather.weatherCode)}',
            style: const TextStyle(color: Colors.grey),
          ),

          const SizedBox(height: 4),
          Text(
            'Time of Day: ${getTimeOfDayLabel()}',
            style: const TextStyle(color: Colors.grey),
          ),

        ],
      ),
    );
  }
  Widget _buildErrorHintBox(String message) {
    return Center(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 8,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: [Colors.indigoAccent, Colors.lightBlueAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.location_off,
                size: 60,
                color: Colors.white,
              ),
              const SizedBox(height: 16),
              const Text(
                'City Not Found',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ),
      ),
    );  }


}
