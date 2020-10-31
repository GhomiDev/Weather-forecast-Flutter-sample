
import 'package:mobx/mobx.dart';
import 'package:weather_forecast/common/api_functions/weather/get_current_weather_data_api.dart';
import 'package:weather_forecast/common/constants/enums.dart';
import 'package:weather_forecast/common/models/weather/weather_request_model.dart';
import 'package:weather_forecast/common/models/weather/weather_response_model.dart';

part 'weather_store.g.dart';

class WeatherStore extends _WeatherStore with _$WeatherStore {
}

abstract class _WeatherStore with Store {

  @observable
  ObservableFuture<WeatherResponseModel> _responseFuture;
  @observable
  WeatherResponseModel response;

  @observable
  String error;

  @computed
  StoreState get state {
    if (_responseFuture == null ||
        _responseFuture.status == FutureStatus.rejected) {
      return StoreState.initial;
    }
    return _responseFuture.status == FutureStatus.pending
        ? StoreState.service_called
        :  response==null? StoreState.error :  StoreState.data_received;
  }

  @action
  Future getWeather(String cityName) async {
    try {
      error = null;
      _responseFuture =
          ObservableFuture( getCurrentWeatherDataApi(new WeatherRequestModel(cityName: cityName)));
      response = await _responseFuture;
    } on Exception {
      error = "Fault in fetching weather data, Check network your phone connection";
    }
  }
}