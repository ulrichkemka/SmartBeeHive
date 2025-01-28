import 'package:flutter/material.dart';
import 'package:smart_bee_hive/screen/ruche.dart';
import '../model/date.dart';
import '../model/weatherData.dart';
import '../model/context.dart';


class DataTableValeur extends StatelessWidget {
  final DateToShare dateToShare;
  final Context myContextApp;

  DataTableValeur({super.key, required this.dateToShare,required this.myContextApp});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<DataRow>>(
        future: getRows(myContextApp),
        builder: (BuildContext context, AsyncSnapshot<List<DataRow>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return const Text('Erreur : Sorry!');
          } else {
            return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        decoration: const BoxDecoration(
          color: Color.fromRGBO(255, 255, 255, 1),
        ),
        columns: [
          DataColumn(
            label: Flexible(
              child: Container(
                child: const Text(
                  'Température',
                  style: TextStyle(fontSize: 10),
                ),
              ),
            ),
          ),
          DataColumn(
            label: Flexible(
              child: Container(
                child: const Text(
                  'Humidité',
                  style: TextStyle(fontSize: 10),
                ),
              ),
            ),
          ),
          DataColumn(
            label: Flexible(
              child: Container(
                child: const Text(
                  'Date',
                  style: TextStyle(fontSize: 10),
                ),
              ),
            ),
          ),
          DataColumn(
            label: Flexible(
              child: Container(
                child: const Text(
                  'Heure',
                  style: TextStyle(fontSize: 10),
                ),
              ),
            ),
          ),
          DataColumn(
            label: Flexible(
              child: Container(
                child: const Text(
                  'Couvercle',
                  style: TextStyle(fontSize: 10),
                ),
              ),
            ),
          ),
        ],
        rows: snapshot.data ?? [],
      ),
    );
          }});
  }
}

Future<List<DataRow>> getRows(Context context) async {
  List<DataRow> rows = [];
  int day = dateToShare.jour;
  int month = dateToShare.mois;
  int year = dateToShare.annee;
  int week = dateToShare.semaine;

  String date = dateToShare.dateToSearch(day, month, year);

  WeatherData weatherData = WeatherData(temperature: "", humidite: "", date: "", heure: "", couvercle: "");
  List<WeatherData> weatherDataList = await weatherData.getWeatherDataByDate(context,date);

  if (weatherDataList.isEmpty) {
    rows = const [DataRow(
        cells: [
        DataCell(Text("Données non disponible",
                style: TextStyle(fontSize:10))),
          DataCell(Text("-",
              style: TextStyle(fontSize: 10))),
          DataCell(Text("-",
              style: TextStyle(fontSize: 10))),
          DataCell(Text("-",
              style: TextStyle(fontSize: 10))),
          DataCell(Text("-",
              style: TextStyle(fontSize: 10))),
        ])];
  }
  else {
    rows = [
      for(int i = 0; i < weatherDataList.length; i++)
        DataRow(
          cells: [
            DataCell(Text("${weatherDataList[i].temperature.toString()}°C",
                style: TextStyle(fontSize: 10))),
            DataCell(Text("${weatherDataList[i].humidite.toString()}%",
                style: TextStyle(fontSize: 10))),
            DataCell(Text("${weatherDataList[i].date.toString()}",
                style: TextStyle(fontSize: 10))),
            DataCell(Text("${weatherDataList[i].heure.toString()}",
                style: TextStyle(fontSize: 10))),
            DataCell(Text("${weatherDataList[i].couvercle.toString()}",
                style: TextStyle(fontSize: 10))),
          ],
        ),
    ];
  }

  return rows;
}


