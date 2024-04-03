import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weather_api_app/provider/weather_provider.dart';

class WeatherScreen extends StatelessWidget {
  final TextEditingController _cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final weatherProvider = Provider.of<WeatherProvider>(context);

        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus(); // Klavyeyi gizle
          },
          child: Center(
            child: SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize:
                      MainAxisSize.min, // Yeniden boyutlandırılabilir sütun
                  children: [
                    Text(
                      'HAVA DURUMU',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.008),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Text(
                            DateFormat('dd.MM.yyyy').format(DateTime.now()),
                            style: TextStyle(fontSize: 17, color: Colors.white),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Text(
                            DateFormat('HH:mm').format(DateTime.now()),
                            style: TextStyle(fontSize: 17, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.010),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset('assets/clouds.gif',
                            width: MediaQuery.of(context).size.width * 0.133,
                            height: MediaQuery.of(context).size.height * 0.133),
                        Image.asset('assets/sun.gif',
                            width: MediaQuery.of(context).size.width * 0.133,
                            height: MediaQuery.of(context).size.height * 0.133),
                        Image.asset('assets/humidity.gif',
                            width: MediaQuery.of(context).size.width * 0.133,
                            height: MediaQuery.of(context).size.height * 0.133),
                        Image.asset('assets/temperature.gif',
                            width: MediaQuery.of(context).size.width * 0.133,
                            height: MediaQuery.of(context).size.height * 0.133),
                        Image.asset('assets/foggy.gif',
                            width: MediaQuery.of(context).size.width * 0.133,
                            height: MediaQuery.of(context).size.height * 0.133),
                        Image.asset('assets/cloudy.gif',
                            width: MediaQuery.of(context).size.width * 0.133,
                            height: MediaQuery.of(context).size.height * 0.133),
                      ],
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.010),
                    TextField(
                      controller: _cityController,
                      decoration: InputDecoration(
                        labelText: 'Şehir adı giriniz..',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        prefixIcon: Icon(Icons.search), // Arama simgesi ekle
                      ),
                      onSubmitted: (value) {
                        _submitCity(context, weatherProvider);
                        _cityController
                            .clear(); // Arama yapıldığında alanı temizle
                      },
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.010),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            _submitCity(context, weatherProvider);
                            _cityController.clear();
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green),
                          child: Text(
                            'Ara',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            weatherProvider.clearWeatherData();
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red),
                          child: Text(
                            'Sil',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.010),
                    Consumer<WeatherProvider>(
                      builder: (context, provider, child) {
                        final weather = provider.weather;
                        if (weather != null) {
                          return Column(
                            children: [
                              Text(
                                '${weather.cityName}',
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color:
                                        Color.fromARGB(255, 32, 55, 182)),
                              ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.010),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.thermostat),
                                  Text(
                                    '${weather.temperature.toStringAsFixed(1)}°C - ${weather.weather.first.getTurkishDescription()}',
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.arrow_drop_up),
                                  Text(
                                    'En yüksek sıcaklık: ${weather.maxTemperature.toStringAsFixed(1)}°C',
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.arrow_drop_down),
                                  Text(
                                    'En düşük sıcaklık: ${weather.minTemperature.toStringAsFixed(1)}°C',
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.air),
                                  Text(
                                    'Basınç: ${weather.pressure} hPa',
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.water_damage),
                                  Text(
                                    'Nem: ${weather.humidity}%',
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.waves),
                                  Text(
                                    'Rüzgar hızı: ${(weather.windSpeed * 3.6).toStringAsFixed(1)} km/s',
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.wb_sunny),
                                  Text(
                                    'Gün Doğumu: ${DateFormat('HH:mm').format(weather.sunrise)}',
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.nights_stay),
                                  Text(
                                    'Gün Batımı: ${DateFormat('HH:mm').format(weather.sunset)}',
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                            ],
                          );
                        } else {
                          return SizedBox();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _submitCity(BuildContext context, WeatherProvider weatherProvider) {
    final city = _cityController.text.trim();
    if (city.isNotEmpty) {
      weatherProvider.fetchWeather(city);
      FocusScope.of(context).unfocus(); // Klavyeyi gizle
    }
  }
}
