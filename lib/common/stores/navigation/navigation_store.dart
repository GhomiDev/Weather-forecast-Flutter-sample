import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
part 'navigation_store.g.dart';

class NavigationStore extends _NavigationStore with _$NavigationStore {}

abstract class _NavigationStore with Store {
  @observable
  late String currentPage= '';

  @action
  void navigateToRoute(BuildContext context, String route) {
    if (route.compareTo('splash') == 0) {
      Beamer.of(context).beamToNamed('splash');
      currentPage = 'splash';
    } else if (route.compareTo('home') == 0) {
      Beamer.of(context).beamToNamed('home');
      currentPage = 'home';
    }
  }
}
