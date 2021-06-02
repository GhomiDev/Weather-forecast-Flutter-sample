import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_forecast/common/stores/drawer/drawer_store.dart';
import 'package:weather_forecast/common/stores/navigation/navigation_store.dart';
import 'package:weather_forecast/common/stores/weather/weather_store.dart';
import 'package:weather_forecast/pages/home/home_page.dart';
import 'package:weather_forecast/pages/splash/splash_page.dart';

class PagesLocation extends BeamLocation {
  PagesLocation() : super() {
    addListener(_listener);
  }

  final NavigationStore _navigationStore = NavigationStore();

  void _listener() {
    if (state.pathBlueprintSegments.isEmpty) return;
  }

  @override
  Widget builder(BuildContext context, Widget navigator) {
    return Provider.value(
      value: _navigationStore,
      child: navigator,
    );
  }

  @override
  List<String> get pathBlueprints => ['/home'];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) => [
        BeamPage(
          key: ValueKey('splash'),
          title: 'Splash',
          child: Provider(
            create: (_) => NavigationStore(),
            child: SplashPage(), //HomePage(title: 'Weather app'),
          ),
        ),
        if (state.uri.pathSegments.contains('home'))
          BeamPage(
            key: ValueKey('home'),
            title: 'Home',
            child: Provider(
              create: (_) => NavigationStore(),
              child: Provider(
                create: (_) => DrawerStore(),
                child: Provider(
                  create: (_) => WeatherStore(),
                  child: HomePage(),
                ),
              ),
            ),
          ),
      ];
}
