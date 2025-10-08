import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/clipper/modal_clipper.dart';
import 'package:weather_app/constants/locations.dart';
import 'package:weather_app/provider/weather_provider.dart';

void showCityBottomSheet(BuildContext context, WidgetRef ref) {
  double height = MediaQuery.of(context).size.height;
  showModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: context,
    builder: (BuildContext bc) {
      return ClipPath(
        clipper: ModalClipper(),
        child: Container(
          height: height / 2,
          padding: const EdgeInsets.only(top: 30),
          color: Colors.white,
          child: ListView(
            children: [
              const ListTile(
                title: Padding(
                  padding: EdgeInsets.only(left: 5, top: 5),
                  child: Text(
                    'Choose a city',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                  ),
                ),
              ),
              ...location.map(
                (cityData) => ListTile(
                  title: Column(
                    children: [
                      Text(
                        cityData["city"] ?? '',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        cityData["country"] ?? '',
                        style: TextStyle(fontSize: 12),
                      ),
                      SizedBox(width: 70, child: Divider(thickness: 1)),
                    ],
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    if (cityData["city"] == null) throw 'no city';
                    ref
                        .read(weatherProvider.notifier)
                        .fetchWeather(cityData["city"]!);
                  },
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
