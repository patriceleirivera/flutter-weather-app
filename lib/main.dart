import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/constants/locations.dart';
import 'package:weather_app/provider/weather_provider.dart';
import 'package:weather_app/widget/bottom_modal_sheet.dart';
import 'package:weather_app/widget/select_city_prompt.dart';
import 'package:weather_app/widget/selected_city_page.dart';

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Weather App'),
    );
  }
}

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final weatherState = ref.watch(weatherProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showCityBottomSheet(context, ref);
        },
        backgroundColor: Colors.white,
        child: const Icon(Icons.menu),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(child: Text("Cities")),
            ...location.map(
              (cityData) => ListTile(
                title: Text(cityData["city"] ?? ''),
                subtitle: Text(cityData["country"] ?? ''),
                onTap: () {
                  Navigator.pop(context);
                  ref
                      .read(weatherProvider.notifier)
                      .fetchWeather(cityData["city"]!);
                },
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: weatherState.when(
          data: (weather) {
            if (weather == null) {
              return SelectCityPrompt();
            }
            return SelectedCityPage(weather: weather);
          },
          loading: () => const CircularProgressIndicator(),
          error: (e, _) => Text("Error: $e"),
        ),
      ),
    );
  }
}
