import 'package:flutter/material.dart';

class WeatherTile extends StatelessWidget {
  WeatherTile(
      {this.foregroundColor,
        this.backgroundColor,
        this.iconData,
        this.title,
        this.description});

  final Color foregroundColor;
  final Color backgroundColor;
  final IconData iconData;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return new Card(
      color: backgroundColor,
      child: new InkWell(
        onTap: () {},
        child: Column(
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.all(15.0),
                child: Icon(
                  iconData,
                  color: Colors.white,
                ),
              ),
            ),
            Wrap(
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    title,
                    style: TextStyle(color: foregroundColor),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    description,
                    style: TextStyle(color: foregroundColor),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}