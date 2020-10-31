// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drawer_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$DrawerStore on _DrawerStore, Store {
  final _$drawerStoreStateAtom = Atom(name: '_DrawerStore.drawerStoreState');

  @override
  DrawerStoreState get drawerStoreState {
    _$drawerStoreStateAtom.reportRead();
    return super.drawerStoreState;
  }

  @override
  set drawerStoreState(DrawerStoreState value) {
    _$drawerStoreStateAtom.reportWrite(value, super.drawerStoreState, () {
      super.drawerStoreState = value;
    });
  }

  final _$_DrawerStoreActionController = ActionController(name: '_DrawerStore');

  @override
  void setMapCoordinates(double latitude, double longitude) {
    final _$actionInfo = _$_DrawerStoreActionController.startAction(
        name: '_DrawerStore.setMapCoordinates');
    try {
      return super.setMapCoordinates(latitude, longitude);
    } finally {
      _$_DrawerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
drawerStoreState: ${drawerStoreState}
    ''';
  }
}
