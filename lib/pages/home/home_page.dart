import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:weather_forecast/common/constants/enums.dart';
import 'package:weather_forecast/common/models/weather/weather_response_model.dart';
import 'package:weather_forecast/common/widgets/app_bar_widget.dart';
import 'package:weather_forecast/common/widgets/grid_widget.dart';
import 'package:weather_forecast/common/widgets/main_menu_widget.dart';
import 'package:weather_forecast/common/stores/weather/weather_store.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  late List<ReactionDisposer> _reactionDisposersList;

  //Text widgets titles
  final String idleTextTitle = 'Listening to your thoughts...';
  final String listeningTextTitle = 'Nothing happening...';

  //to check if user is typing or not debounce timer is used
  late Timer _debounceTimer;

  //Mobx store for weather
  late WeatherStore _weatherStore;

  //City name text field controller
  final _cityNameTextEditingController = TextEditingController();

  late Size screenSize;

  WeatherResponseModel? response;

  @override
  void initState() {
    super.initState();
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      _weatherStore.getWeather(_cityNameTextEditingController.text);
    });
    _debounceTimer.cancel();
    _cityNameTextEditingController.addListener(_onCityNameChanged);
  }

  @override
  void dispose() {
    super.dispose();
    _cityNameTextEditingController.dispose();
    _reactionDisposersList.forEach((element) => element());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _weatherStore = Provider.of<WeatherStore>(context);
    _reactionDisposersList = [
      reaction((_) => _weatherStore.error, (message) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message.toString()),
          ),
        );
      }),
    ];
  }

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    _weatherStore = Provider.of<WeatherStore>(context);
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topRight, end: Alignment.bottomLeft, stops: [
        -0.7,
        1.7,
      ], colors: [
        Colors.yellow,
        Colors.red,
      ])),
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.transparent,
        appBar: AppBarWidget(scaffoldKey: _scaffoldKey),
        extendBodyBehindAppBar: true,
        drawer: MainMenuWidget(scaffoldKey: _scaffoldKey),
        body:
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(height: 10,),
                  Text(
                    'City name',
                    textAlign: TextAlign.center,
                  ),
                  Container(
                    width: screenSize.width * 70 / 100,
                    child: TextField(
                      controller: _cityNameTextEditingController,
                    ),
                  ),
                   SingleChildScrollView(
                      child: Observer(builder: (context) {
                        response = _weatherStore.response;
                        return checkWeatherState(response);
                      }),
                    ),

                ],
              ),
      ),
    );
  }

  void _onCityNameChanged() {
    if (_debounceTimer.isActive) _debounceTimer.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      await _weatherStore.getWeather(_cityNameTextEditingController.text);
    });
  }

  Widget checkWeatherState(WeatherResponseModel? response) {
    switch (_weatherStore.state) {
      case StoreState.initial:
        return Text(idleTextTitle, textAlign: TextAlign.center);
      case StoreState.service_called:
        return Text(idleTextTitle, textAlign: TextAlign.center);
      case StoreState.data_received:
        return  GridWidget(
          weatherResponseModel: response,
        );
      case StoreState.error:
        return Text(idleTextTitle, textAlign: TextAlign.center);
      default:
        return Text(listeningTextTitle, textAlign: TextAlign.center);
    }
  }
}
