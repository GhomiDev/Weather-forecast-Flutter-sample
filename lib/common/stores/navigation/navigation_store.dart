import 'package:mobx/mobx.dart';
import 'package:sailor/sailor.dart';
import 'package:weather_forecast/common/configs/application.dart';
import 'package:weather_forecast/common/configs/routes.dart';

part 'navigation_store.g.dart';

class NavigationStore extends _NavigationStore with _$NavigationStore {}

abstract class _NavigationStore with Store {
  @observable
  String currentPage;

  @action
  void navigateToRoute(String route) {
    if (route.compareTo(Routes.splash) == 0) {
      Application.sailor.navigate(Routes.splash,
          navigationType: NavigationType.pushReplace,
          transitionDuration: Duration(seconds: 1));
      this.currentPage = Routes.splash;
    } else if (route.compareTo(Routes.home) == 0) {
      Application.sailor.navigate(Routes.home,
          navigationType: NavigationType.pushReplace,
          transitions: [SailorTransition.fade_in],
          transitionDuration: Duration(seconds: 2));
      this.currentPage = Routes.home;
    }
  }
}
