import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/provider/weather_provider.dart';

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
  final List<String> cities = const [
    "Manila",
    "London",
    "Paris",
    "Tokyo",
    "Sydney",
  ];

  final List<Map<String, dynamic>> designByWeather = [
    {
      "condition": "Clear",
      "icon": Icons.wb_sunny,
      "image": "assets/images/clear.png",
    },
    {
      "condition": "Clouds",
      "icon": Icons.cloud,
      "image": "assets/images/clouds.png",
    },
    {
      "condition": "Rain",
      "icon": Icons.beach_access,
      "image": "assets/images/rain.png",
    },
    {
      "condition": "Snow",
      "icon": Icons.ac_unit,
      "image": "assets/images/snow.png",
    },
    {
      "condition": "Thunderstorm",
      "icon": Icons.flash_on,
      "image": "assets/images/thunder.png",
    },
  ];

  Map<String, dynamic>? getWeatherDesign(String condition) {
    return designByWeather.firstWhere(
      (item) => item["condition"].toLowerCase() == condition.toLowerCase(),
      orElse: () => {
        "condition": "Default",
        "icon": Icons.help,
        "image": "assets/images/default.png",
        "color": Colors.grey,
      },
    );
  }

  void _showMyBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return ListView(
          children: [
            ListTile(title: Text('Choose a city')),
            ...cities.map(
              (city) => ListTile(
                title: Text(city),
                onTap: () {
                  Navigator.pop(context);
                  ref.read(weatherProvider.notifier).fetchWeather(city);
                },
              ),
            ),
          ],
        );
      },
    );
  }

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
          _showMyBottomSheet(context);
        },
        backgroundColor: Colors.white,
        child: const Icon(Icons.menu),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(child: Text("Cities")),
            ...cities.map(
              (city) => ListTile(
                title: Text(city),
                onTap: () {
                  Navigator.pop(context);
                  ref.read(weatherProvider.notifier).fetchWeather(city);
                },
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: weatherState.when(
          data: (weather) {
            final design = getWeatherDesign(
              weather?.weatherCondition ?? "Clear",
            );
            if (weather == null) {
              return const Text("Select a city to check weather.");
            }
            return Stack(
              alignment: Alignment.topCenter,
              clipBehavior: Clip.none,
              children: [
                Transform.translate(
                  offset: const Offset(-10, -250),
                  child: Transform.rotate(
                    angle: 20 * 3.1415926535 / 180,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(150),
                      child: Container(
                        width: 450,
                        height: 450,
                        color: Colors.white,
                        child: Transform.rotate(
                          angle: -20 * 3.1415926535 / 180,
                          child: Image.asset(
                            '/images/${weather.cityName?.toLowerCase()}.jpg',
                            height: 450,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 150.0, top: 100),
                  child: (design?["image"] != null)
                      ? Image.asset(
                          design?["image"],
                          fit: BoxFit.cover,
                          height: 100,
                        )
                      : SizedBox(),
                ),
                Padding(
                  padding: EdgeInsetsGeometry.only(top: 250),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "${weather.cityName}",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "${weather.weatherCondition}",
                        style: TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 50),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              const Text('Temperature'),
                              Text(
                                '${weather.temperature} °C',
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              const Text('Humidity'),
                              Text(
                                '${weather.humidity}%',
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              const Text('Wind'),
                              Text(
                                '${weather.windSpeed} m/s',
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
          loading: () => const CircularProgressIndicator(),
          error: (e, _) => Text("Error: $e"),
        ),
      ),
    );
  }
}
