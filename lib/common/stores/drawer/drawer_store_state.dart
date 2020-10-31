
import 'package:equatable/equatable.dart';

abstract class DrawerStoreState extends Equatable{
  List<Object> get props =>[];
}

class NewLocationOnMapState extends DrawerStoreState {
  final double latitude;
  final double longitude;

  NewLocationOnMapState({this.latitude, this.longitude});

  List<Object> get props => [latitude, longitude];
}