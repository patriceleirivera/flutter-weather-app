import 'package:flutter/material.dart';
import 'package:weather_app/clipper/image_clipper.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/widget/weather_data_item.dart';

class SelectedCityPage extends StatelessWidget {
  const SelectedCityPage({super.key, required this.weather});
  final Weather weather;

  static const List<Map<String, String>> _designByWeather = [
    {"condition": "Clear", "image": "assets/images/clear.png"},
    {"condition": "Clouds", "image": "assets/images/clouds.png"},
    {"condition": "Rain", "image": "assets/images/rain.png"},
    {"condition": "Snow", "image": "assets/images/snow.png"},
    {"condition": "Thunderstorm", "image": "assets/images/thunder.png"},
  ];

  Map<String, String> _getWeatherDesign(String condition) {
    return _designByWeather.firstWhere(
      (item) => item["condition"]!.toLowerCase() == condition.toLowerCase(),
      orElse: () => {
        "condition": "Default",
        "image": "assets/images/clouds.png",
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    final design = _getWeatherDesign(weather.weatherCondition ?? "Clear");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          clipBehavior: Clip.none,
          children: [
            SizedBox(
              height: height / 1.6,
              child: ClipPath(
                clipper: ImageClipper(),
                child: Image.asset(
                  'assets/images/${weather.cityName?.toLowerCase()}.jpg',
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            (design["image"] != null)
                ? Positioned(
                    left: 20,
                    top: height / 1.9,
                    child: Image.asset(
                      design["image"]!,
                      fit: BoxFit.cover,
                      height: 150,
                    ),
                  )
                : SizedBox(),
          ],
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "${weather.cityName}",
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        "${weather.description}",
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 40),
            SizedBox(
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  WeatherDataItem(
                    label: 'Temperature',
                    value: '${weather.temperature} °C',
                  ),
                  VerticalDivider(thickness: 1, width: 20, color: Colors.grey),
                  WeatherDataItem(
                    label: 'Humidity',
                    value: '${weather.humidity}%',
                  ),
                  VerticalDivider(thickness: 1, width: 20, color: Colors.grey),
                  WeatherDataItem(
                    label: 'Wind',
                    value: '${weather.windSpeed} m/s',
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
