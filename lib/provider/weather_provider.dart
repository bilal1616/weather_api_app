import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather_api_app/constants/apikey.dart';
import 'dart:convert';
import 'package:weather_api_app/models/weather.dart';

class WeatherProvider with ChangeNotifier {
  Weather? _weather;

  Weather? get weather => _weather;

  Future<void> fetchWeather(String city) async {
    // Türkçe karakterleri değiştir
    final normalizedCity = _normalizeTurkishChars(city);

    final apiKey = apikey; // OpenWeather API key
    final apiUrl =
        'http://api.openweathermap.org/data/2.5/weather?q=$normalizedCity&appid=$apiKey';
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        if (jsonData['cod'] == 200) {
          _weather = Weather.fromJson(jsonData);
          notifyListeners();
        } else {
          throw Exception('API yanıtı alınamadı: ${jsonData['message']}');
        }
      } else {
        throw Exception('API yanıtı alınamadı: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Hata oluştu: $error');
    }
  }

  void clearWeatherData() {
    _weather = null;
    notifyListeners();
  }

  // Türkçe karakterleri değiştiren yardımcı fonksiyon
  String _normalizeTurkishChars(String input) {
    input = input.replaceAll('ı', 'i');
    input = input.replaceAll('ö', 'o');
    input = input.replaceAll('ü', 'u');
    input = input.replaceAll('ç', 'c');
    input = input.replaceAll('ğ', 'g');
    input = input.replaceAll('ş', 's');
    input = input.replaceAll('İ', 'I');
    input = input.replaceAll('Ö', 'O');
    input = input.replaceAll('Ü', 'U');
    input = input.replaceAll('Ç', 'C');
    input = input.replaceAll('Ğ', 'G');
    input = input.replaceAll('Ş', 'S');
    return input;
  }
}
