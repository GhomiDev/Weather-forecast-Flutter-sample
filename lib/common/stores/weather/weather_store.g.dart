// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$WeatherStore on _WeatherStore, Store {
  Computed<StoreState> _$stateComputed;

  @override
  StoreState get state => (_$stateComputed ??=
          Computed<StoreState>(() => super.state, name: '_WeatherStore.state'))
      .value;

  final _$_responseFutureAtom = Atom(name: '_WeatherStore._responseFuture');

  @override
  ObservableFuture<WeatherResponseModel> get _responseFuture {
    _$_responseFutureAtom.reportRead();
    return super._responseFuture;
  }

  @override
  set _responseFuture(ObservableFuture<WeatherResponseModel> value) {
    _$_responseFutureAtom.reportWrite(value, super._responseFuture, () {
      super._responseFuture = value;
    });
  }

  final _$responseAtom = Atom(name: '_WeatherStore.response');

  @override
  WeatherResponseModel get response {
    _$responseAtom.reportRead();
    return super.response;
  }

  @override
  set response(WeatherResponseModel value) {
    _$responseAtom.reportWrite(value, super.response, () {
      super.response = value;
    });
  }

  final _$errorAtom = Atom(name: '_WeatherStore.error');

  @override
  String get error {
    _$errorAtom.reportRead();
    return super.error;
  }

  @override
  set error(String value) {
    _$errorAtom.reportWrite(value, super.error, () {
      super.error = value;
    });
  }

  final _$getWeatherAsyncAction = AsyncAction('_WeatherStore.getWeather');

  @override
  Future<dynamic> getWeather(String cityName) {
    return _$getWeatherAsyncAction.run(() => super.getWeather(cityName));
  }

  @override
  String toString() {
    return '''
response: ${response},
error: ${error},
state: ${state}
    ''';
  }
}
