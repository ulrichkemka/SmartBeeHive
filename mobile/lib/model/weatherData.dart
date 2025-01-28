import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smart_bee_hive/model/context.dart';

class WeatherData {
  final String temperature;
  final String humidite;
  final String date;
  final String heure;
  final String couvercle;

  WeatherData({required this.temperature, required this.humidite,
    required this.date, required this.heure, required this.couvercle});

  String adressIp = "http://20.115.59.151:8080";

  Future<List<WeatherData>> getWeatherDataByDate(Context context, String date) async {

    final response = await http.get(Uri.parse('$adressIp/sensor_data/${context.idApiculteur}/${context.idRucher}/${context.idRuche}'));

    List<WeatherData> weatherDataList = [];

    if (response.statusCode == 200) {
      var datas = json.decode(response.body);
      for (var data in datas) {
        if (data['date'].toString() == date){
          WeatherData weatherData = WeatherData(
            temperature: data['temperature'].toString(),
            humidite: data['humidite'].toString(),
            date : data['date'].toString(),
            heure: data['heure'].toString(),
            couvercle: data['couvercle'].toString(),
          );
          weatherDataList.add(weatherData);
        }
      }
    }
    return weatherDataList;
  }



}