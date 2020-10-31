import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:weather_forecast/common/constants/enums.dart';
import 'package:weather_forecast/common/mobx/flutter_mobx.dart';
import 'package:weather_forecast/common/stores/weather/weather_store.dart';

class MainMenuWidget extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const MainMenuWidget({Key key, this.scaffoldKey}) : super(key: key);

  @override
  _MainMenuWidgetState createState() => _MainMenuWidgetState();
}

class _MainMenuWidgetState extends State<MainMenuWidget> {
  Completer<GoogleMapController> _controller = Completer();

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  MarkerId selectedMarker;
  Marker marker;

  var mapType;

  //Mobx store for weather
  WeatherStore _weatherStore;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    final String markerIdVal = '';
    final MarkerId markerId = MarkerId(markerIdVal);

    markers.clear();
    marker = Marker(
      markerId: markerId,
      position: LatLng(0.0, 0.0),
      infoWindow: InfoWindow(title: markerIdVal, snippet: ''),
      onTap: () {},
    );
    markers[markerId] = marker;
    mapType = MapType.normal;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _weatherStore = Provider.of<WeatherStore>(context);
  }

  @override
  Widget build(BuildContext context) {
    var pageWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      width: pageWidth,
      child: Drawer(
        child: Observer(builder: (context) {
          if (_weatherStore.state == StoreState.data_received) {
            String markerIdVal = '';
            MarkerId markerId = MarkerId(markerIdVal);
            markers.clear();
            marker = Marker(
              markerId: markerId,
              position: LatLng(_weatherStore.response.coord.lat,
                  _weatherStore.response.coord.lon),
              infoWindow: InfoWindow(title: markerIdVal, snippet: ''),
              onTap: () {},
            );
            markers[markerId] = marker;

            CameraPosition _kGooglePlex = CameraPosition(
              target: LatLng(_weatherStore.response.coord.lat,
                  _weatherStore.response.coord.lon),
              zoom: 7,
            );
            return Scaffold(
              body: GoogleMap(
                  myLocationEnabled: true,
                  mapType: MapType.normal,
                  markers: Set<Marker>.of(markers.values),
                  initialCameraPosition: _kGooglePlex,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  }),
              floatingActionButton: FloatingActionButton(
                foregroundColor: Colors.white,
                backgroundColor: Colors.deepOrangeAccent,
                onPressed: () {
                  widget.scaffoldKey.currentState.openEndDrawer();
                },
                child: Icon(Icons.arrow_forward_ios),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
            );
          }
          return Scaffold(
            body: Center(
                child: Text('Search and find a city to show it on the map')),
            floatingActionButton: FloatingActionButton(
              foregroundColor: Colors.white,
              backgroundColor: Colors.deepOrangeAccent,
              onPressed: () {
                widget.scaffoldKey.currentState.openEndDrawer();
              },
              child: Icon(Icons.arrow_forward_ios),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
        }),
      ),
    );
  }
}
