import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:sailor/sailor.dart';
import 'package:weather_forecast/common/configs/application.dart';
import 'package:weather_forecast/common/configs/routes.dart';
import 'package:weather_forecast/pages/splash/splash_page.dart';
import 'package:weather_forecast/common/stores/navigation/navigation_store.dart';

import 'pages/home/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp() {
    final sailor = Sailor();
    Routes.configureRoutes(sailor);
    Application.sailor = sailor;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      navigatorKey: Application.sailor.navigatorKey,
      onGenerateRoute: Application.sailor.generator(),

      home: Provider(
        create: (_) => NavigationStore(),
        child: SplashPage(), //HomePage(title: 'Weather app'),
      ), //HomePage(title: 'Weather app'),
    );
  }
}
