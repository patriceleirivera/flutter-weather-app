

class Weather {
  final String? cityName;
  final String? weatherCondition;
  final double? temperature;
  final int? humidity;
  final double? windSpeed;

  Weather({
    required this.cityName,
    required this.weatherCondition,
    required this.temperature,
    required this.humidity,
    required this.windSpeed,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'] ?? '',
      weatherCondition: (json['weather'] != null && json['weather'].isNotEmpty)
          ? json['weather'][0]['main']
          : '',
      temperature: (json['main']['temp'] ?? 0).toDouble(),
      humidity: json['main']['humidity'] ?? 0,
      windSpeed: (json['wind']['speed'] ?? 0).toDouble(),
    );
  }
}