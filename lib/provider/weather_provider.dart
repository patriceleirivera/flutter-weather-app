import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/models/weather.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class WeatherNotifier extends AsyncNotifier<Weather?> {
  @override
  Future<Weather?> build() async => null;

  Future<void> fetchWeather(String city) async {
    state = const AsyncLoading();
    const key = String.fromEnvironment('API_KEY');

    final url = Uri.https(
      'api.openweathermap.org',
      '/data/2.5/weather',
      {'q': city, 'appid': key, 'units': 'metric'},
    );

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {

        final jsonResponse =
            convert.jsonDecode(response.body) as Map<String, dynamic>;

        state = AsyncData(Weather.fromJson(jsonResponse));

      } else {
        state = AsyncError("Error: ${response.statusCode}", StackTrace.current);
      }
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}

final weatherProvider =
    AsyncNotifierProvider<WeatherNotifier, Weather?>(() => WeatherNotifier());