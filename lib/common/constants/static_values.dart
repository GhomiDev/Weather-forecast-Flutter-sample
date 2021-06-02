
class StaticValues{

  static const String openWeatherApiKey = 'OpenWeather_API_KEY';

  static const String apiProductionBaseAddress = 'api.openweathermap.org';

  static const String apiCurrentWeatherDataAddress =
      '/data/2.5/weather';

  static String getCurrentWeatherDataAddress() {
    return apiProductionBaseAddress + apiCurrentWeatherDataAddress;
  }

}

