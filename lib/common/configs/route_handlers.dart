import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sailor/sailor.dart';
import 'package:weather_forecast/pages/home/home_page.dart';
import 'package:weather_forecast/pages/splash/splash_page.dart';
import 'package:weather_forecast/common/stores/drawer/drawer_store.dart';
import 'package:weather_forecast/common/stores/navigation/navigation_store.dart';
import 'package:weather_forecast/common/stores/weather/weather_store.dart';

Widget splashRouteHandler(
    BuildContext context, BaseArguments arguments, ParamMap paramMap) {
  return SplashPage();
}

Widget homeRouteHandler(
    BuildContext context, BaseArguments arguments, ParamMap paramMap) {
  return Provider(
      create: (_) => NavigationStore(),
      child: Provider(
          create: (_) => DrawerStore(),
          child: Provider(create: (_) => WeatherStore(), child: HomePage())));
}
