import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:weather_forecast/common/constants/enums.dart';
import 'package:weather_forecast/common/mobx/flutter_mobx.dart';
import 'package:weather_forecast/common/widgets/app_bar_widget.dart';
import 'package:weather_forecast/common/widgets/grid_widget.dart';
import 'package:weather_forecast/common/widgets/main_menu_widget.dart';
import 'package:weather_forecast/common/stores/weather/weather_store.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  List<ReactionDisposer> _reactionDisposersList;

  //Text widgets titles
  final String idleTextTitle = 'Listening to your thoughts...';
  final String listeningTextTitle = 'Nothing happening...';

  //to check if user is typing or not debounce timer is used
  Timer _debounceTimer;

  //Mobx store for weather
  WeatherStore _weatherStore;

  //City name text field controller
  var _cityNameTextEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
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
    _weatherStore ??= Provider.of<WeatherStore>(context);
    _reactionDisposersList ??= [
      reaction((_) => _weatherStore.error, (String message) {
        _scaffoldKey.currentState.showSnackBar(
          SnackBar(
            content: Text(message),
          ),
        );
      }),
    ];
  }

  Size screenSize;

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    _weatherStore = Provider.of<WeatherStore>(context);
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              stops: [
            -0.7,
            1.7,
          ],
              colors: [
            Colors.yellow,
            Colors.red,
          ])),
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.transparent,
        appBar: AppBarWidget(scaffoldKey: _scaffoldKey),
        extendBodyBehindAppBar: true,
        drawer: MainMenuWidget(scaffoldKey: _scaffoldKey),
        body: Container(
          width: screenSize.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
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
                  return checkWeatherState();
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _onCityNameChanged() {
    if (_debounceTimer?.isActive ?? false) _debounceTimer.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      _weatherStore.getWeather(_cityNameTextEditingController.text);
    });
  }

  Widget checkWeatherState() {
    switch (_weatherStore.state) {
      case StoreState.initial:
        return Text(idleTextTitle, textAlign: TextAlign.center);
      case StoreState.service_called:
        return Text(idleTextTitle, textAlign: TextAlign.center);
      case StoreState.data_received:
        return GridWidget(
          weatherResponseModel: _weatherStore.response,
        );
      case StoreState.error:
        return Text(idleTextTitle, textAlign: TextAlign.center);
      default:
        return Text(listeningTextTitle, textAlign: TextAlign.center);
    }
  }
}
