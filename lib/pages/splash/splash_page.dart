import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_forecast/common/configs/routes.dart';
import 'dart:math' as math;

import 'package:weather_forecast/common/stores/navigation/navigation_store.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Timer timer;

  NavigationStore _navigationStore;

  startTime() async {
    timer = new Timer(Duration(seconds: 5), navigationPage);
  }

  void navigationPage() {
    timer.cancel();
    _navigationStore.navigateToRoute(Routes.home);
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..repeat();

    startTime();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _navigationStore = Provider.of<NavigationStore>(context);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  bool isOnLeft(double rotation) => math.cos(rotation) > 0;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    final numberOfTexts = 8;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox.expand(
        child: Stack(
          children: [
            Positioned(
                left: screenSize.width / 2 - 35,
                bottom: screenSize.height * 5 / 100,
                child: Text(
                  'version 0.1',
                  style: TextStyle(color: Colors.white),
                )),
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: List.generate(
                  numberOfTexts,
                  (index) {
                    return AnimatedBuilder(
                      animation: _animationController,
                      child: LinearText(),
                      builder: (context, child) {
                        final animationRotationValue =
                            _animationController.value *
                                2 *
                                math.pi /
                                numberOfTexts;
                        double rotation = 2 * math.pi * index / numberOfTexts +
                            math.pi / 2 +
                            animationRotationValue;
                        if (isOnLeft(rotation)) {
                          rotation = -rotation +
                              2 * animationRotationValue -
                              math.pi * 2 / numberOfTexts;
                        }
                        return Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.identity()
                            ..setEntry(3, 2, 0.001)
                            ..rotateY(rotation)
                            ..translate(-120.0),
                          child: LinearText(),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LinearText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: 3,
      child: Container(
        child: Text(
          'Weather',
          style: TextStyle(
            color: getRandomColor(0.4),
            fontSize: 150,
          ),
        ),
        foregroundDecoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.transparent,
              getRandomColor(0.3),
              Colors.transparent
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            stops: [0.0, 0.9, 0.8],
          ),
        ),
      ),
    );
  }

  var random = new Random();

  Color getRandomColor(double opacityParam) {
    switch (random.nextInt(4)) {
      case 0:
        return Colors.lightBlueAccent.withOpacity(opacityParam);
      case 1:
        return Colors.blue.withOpacity(opacityParam);
      case 2:
        return Colors.red.withOpacity(opacityParam);
      case 3:
        return Colors.redAccent.withOpacity(opacityParam);
      default:
        return Colors.white.withOpacity(opacityParam);
    }
  }
}
