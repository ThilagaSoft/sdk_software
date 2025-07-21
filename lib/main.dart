import 'package:code_task/bloc/weather/weather_bloc.dart';
import 'package:code_task/repository/weather_repository.dart';
import 'package:code_task/screen/weather_screen.dart';
import 'package:code_task/service/weather_api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final repo = WeatherRepository(api: WeatherApi());

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter MVVM+BLoC Weather',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: RepositoryProvider.value(
        value: repo,
        child: BlocProvider(
          create: (context) => WeatherBloc(repo),
          child: WeatherPage(),
        ),
      ),
    );
  }
}
