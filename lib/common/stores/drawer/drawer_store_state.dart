
import 'package:equatable/equatable.dart';

abstract class DrawerStoreState extends Equatable{
  @override
  List<Object> get props =>[];
}

class NewLocationOnMapState extends DrawerStoreState {
  final double latitude;
  final double longitude;

  NewLocationOnMapState({required this.latitude, required this.longitude});

  @override
  List<Object> get props => [latitude, longitude];
}