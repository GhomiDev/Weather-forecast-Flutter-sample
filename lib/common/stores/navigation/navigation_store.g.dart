// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'navigation_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$NavigationStore on _NavigationStore, Store {
  final _$currentPageAtom = Atom(name: '_NavigationStore.currentPage');

  @override
  String get currentPage {
    _$currentPageAtom.reportRead();
    return super.currentPage;
  }

  @override
  set currentPage(String value) {
    _$currentPageAtom.reportWrite(value, super.currentPage, () {
      super.currentPage = value;
    });
  }

  final _$_NavigationStoreActionController =
      ActionController(name: '_NavigationStore');

  @override
  void navigateToRoute(BuildContext context, String route) {
    final _$actionInfo = _$_NavigationStoreActionController.startAction(
        name: '_NavigationStore.navigateToRoute');
    try {
      return super.navigateToRoute(context, route);
    } finally {
      _$_NavigationStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentPage: ${currentPage}
    ''';
  }
}
