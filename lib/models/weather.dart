class Weather {
  final String cityName;
  final double temperature;
  final double maxTemperature;
  final double minTemperature;
  final int pressure;
  final int humidity;
  final double windSpeed;
  final DateTime sunrise;
  final DateTime sunset;
  final List<WeatherDescription> weather;

  Weather({
    required this.cityName,
    required this.temperature,
    required this.maxTemperature,
    required this.minTemperature,
    required this.pressure,
    required this.humidity,
    required this.windSpeed,
    required this.sunrise,
    required this.sunset,
    required this.weather,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'],
      temperature: (json['main']['temp'] - 273.15), // Kelvin to Celsius conversion
      maxTemperature: (json['main']['temp_max'] - 273.15), // Kelvin to Celsius conversion
      minTemperature: (json['main']['temp_min'] - 273.15), // Kelvin to Celsius conversion
      pressure: json['main']['pressure'],
      humidity: json['main']['humidity'],
      windSpeed: json['wind']['speed'].toDouble(), // Convert wind speed to double
      sunrise: DateTime.fromMillisecondsSinceEpoch(json['sys']['sunrise'] * 1000),
      sunset: DateTime.fromMillisecondsSinceEpoch(json['sys']['sunset'] * 1000),
      weather: List<WeatherDescription>.from(json['weather'].map((x) => WeatherDescription.fromJson(x))),
    );
  }
}

class WeatherDescription {
  final String main;
  final String description;

  WeatherDescription({
    required this.main,
    required this.description,
  });

  factory WeatherDescription.fromJson(Map<String, dynamic> json) {
    return WeatherDescription(
      main: json['main'],
      description: json['description'],
    );
  }

  String getTurkishDescription() {
    switch (main.toLowerCase()) {
      case 'thunderstorm':
        return 'Gök Gürültülü Fırtına';
      case 'drizzle':
        return 'Çiseleyen Yağmur';
      case 'rain':
        return 'Yağmurlu';
      case 'snow':
        return 'Karlı';
      case 'mist':
        return 'Sisli';
      case 'smoke':
        return 'Dumanlı';
      case 'haze':
        return 'Puslu';
      case 'dust':
        return 'Tozlu';
      case 'fog':
        return 'Sisli';
      case 'sand':
        return 'Kum Fırtınası';
      case 'ash':
        return 'Kül Fırtınası';
      case 'squall':
        return 'Şiddetli Fırtına';
      case 'tornado':
        return 'Kasırga';
      case 'clear':
        return 'Güneşli';
      case 'clouds':
        return 'Bulutlu';
      default:
        return main;
    }
  }
}
