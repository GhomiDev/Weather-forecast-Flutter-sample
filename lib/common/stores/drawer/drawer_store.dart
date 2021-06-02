import 'package:mobx/mobx.dart';

import 'package:weather_forecast/common/stores/drawer/drawer.dart';

part 'drawer_store.g.dart';

class DrawerStore extends _DrawerStore with _$DrawerStore {}

abstract class _DrawerStore with Store {
  @observable
  late DrawerStoreState drawerStoreState;

  @action
  void setMapCoordinates(double latitude, double longitude){
    drawerStoreState = NewLocationOnMapState(
        latitude: latitude, longitude: longitude);
  }
}
