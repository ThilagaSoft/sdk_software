import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

String getWeatherConditionName(int code) {
  switch (code) {
    case 0:
      return 'Clear sky';
    case 1:
    case 2:
      return 'Partly cloudy';
    case 3:
      return 'Overcast';
    case 45:
    case 48:
      return 'Fog';
    case 51:
    case 53:
    case 55:
      return 'Drizzle';
    case 61:
    case 63:
    case 65:
      return 'Rain';
    case 66:
    case 67:
      return 'Freezing Rain';
    case 71:
    case 73:
    case 75:
      return 'Snowfall';
    case 80:
    case 81:
    case 82:
      return 'Rain showers';
    case 95:
      return 'Thunderstorm';
    case 96:
    case 99:
      return 'Thunderstorm with hail';
    default:
      return 'Unknown';
  }
}
IconData getWeatherIcon(int code, bool isDay) {
  switch (code) {
    case 0:
      return isDay ? FontAwesomeIcons.solidSun : FontAwesomeIcons.moon;
    case 1:
    case 2:
      return isDay ? FontAwesomeIcons.cloudSun : FontAwesomeIcons.cloudMoon;
    case 3:
      return FontAwesomeIcons.cloud; // Overcast or cloudy
    case 45:
    case 48:
      return FontAwesomeIcons.smog; // Fog or mist
    case 51:
    case 53:
    case 55:
    case 61:
    case 63:
    case 65:
      return FontAwesomeIcons.cloudRain; // Rain
    case 66:
    case 67:
      return FontAwesomeIcons.cloudShowersHeavy; // Freezing rain
    case 71:
    case 73:
    case 75:
      return FontAwesomeIcons.snowflake; // Snow
    case 80:
    case 81:
    case 82:
      return FontAwesomeIcons.cloudShowersHeavy; // Heavy rain showers
    case 95:
    case 96:
    case 99:
      return FontAwesomeIcons.bolt; // Thunderstorms
    default:
      return FontAwesomeIcons.circleQuestion; // Unknown
  }
}
String getTimeOfDayLabel() {
  final now = DateTime.now().hour;

  if (now >= 5 && now < 12) return '🌅 Morning';
  if (now >= 12 && now < 17) return '☀️ Afternoon';
  if (now >= 17 && now < 20) return '🌇 Evening';
  return '🌙 Night';
}
