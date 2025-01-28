import 'dart:convert';
import 'context.dart';
import 'package:http/http.dart' as http;

class RuchesData {

  RuchesData();

  String adressIp = "http://20.115.59.151:8080";

  Future<void> addRuche(Context context,String nomRuche, String description, String adresseMac) async {
    final url = Uri.parse('$adressIp/user/rucher/ruche/${context.idApiculteur}/${context.idRucher}');

    final data = {
      "nom" : nomRuche,
      "description": description,
      "adresseMac": adresseMac,
      "email": "0",
    };

    try {
      final response = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(data)
      );
      if (response.statusCode == 200) {
        print('Requête POST réussie');
      } else {
        // La requête a échoué
        print('Erreur lors de la requête POST : ${response.statusCode}');
      }
    } catch (e) {
      // code d'erreur
    }
  }

  Future<void> modifyRuche(Context context, String nomRuche, String description, String notification) async {
    final url = Uri.parse('$adressIp/user/rucher/ruche/${context.idApiculteur}/${context.idRucher}/${context.idRuche}');
    final data = {
      "id"  : context.idRuche,
      "nom" : nomRuche,
      "description": description,
      "email": notification
    };
    try {
      final response = await http.put(url,
          headers: {'Content-Type': 'application/json'},
          body: json.encode(data)
      );
      if (response.statusCode == 200) {
        print('Requête PUT réussie');
      } else {
        // La requête a échoué
        print('Erreur lors de la requête PUT : ${response.statusCode}');
      }
    } catch (e) {
      // code d'erreur
      print("ERROR");
    }
  }

  Future<void> deleteRuche(Context context) async {
    final response = await http.delete(Uri.parse('$adressIp/user/rucher/ruche/${context.idApiculteur}/${context.idRucher}/${context.idRuche}'));

    if (response.statusCode == 200) {

    } else {

    }
  }

  Future<List<Map<String, String>>> getRucheByRucher(Context context) async {
    final response = await http.get(Uri.parse('$adressIp/user/rucher/ruche/${context.idApiculteur}/${context.idRucher}'));
    List<Map<String, String>> ruchesList = [];
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      for (var ruche in data) {
        ruchesList.add({'nom' : ruche['nom'].toString(),
          'description' : ruche['description'].toString(),
          'id' : ruche['id'].toString(), 'notification' : ruche['email'].toString()
        });
      }
    } else {
      throw Exception('Erreur lors de la récupération des données de l\'API');
    }
    return ruchesList;
  }

  Future<List<String>> getLabelRuches(Context context) async {
    List<Map<String, String>> mapList = await getRucheByRucher(context);
    List<String> ruchesList = [];
    for (var ruche in mapList) {
      String nom = ruche['nom']!;
      ruchesList.add(nom);
    }
    return ruchesList;
  }

  Future<String> getIdRucheByNomRuche(Context context, String nomRucher) async {
    List<Map<String, String>> mapList = await getRucheByRucher(context);
    List<String> idList = [];

    for (var map in mapList) {
      if (map['nom'] == nomRucher) {
        idList.add(map['id']!);
      }
    }
    return idList.first;
  }

  Future<Map<String, String>> getInfoRuche(Context context) async {
    final response_inf = await http.get(Uri.parse('$adressIp/user/rucher/ruche/${context.idApiculteur}/${context.idRucher}/${context.idRuche}'));
    final response_data = await http.get(Uri.parse('$adressIp/sensor_data/${context.idApiculteur}/${context.idRucher}/${context.idRuche}'));

    String _nom ="";
    String _description="";
    String _temperature="";
    String _humidite="";
    String _couvercle="";
    String _notification="";
    Map<String, String> infoRuche= {};

    if (response_inf.statusCode == 200) {
      var inf = json.decode(response_inf.body);
        _nom = inf['nom'].toString();
        _description = inf['description'].toString();
        _notification = inf['email'].toString();
    } else {
      throw Exception('Erreur lors de la récupération des données de l\'API');
    }

    if (response_data.statusCode == 200) {
        var data = json.decode(response_data.body);

        if (data.isNotEmpty) {
          Map<String, dynamic> recentTuple = data.first;
          _couvercle = recentTuple['couvercle'].toString();
          _humidite = recentTuple['humidite'].toString();
          _temperature = recentTuple['temperature'].toString();
        } else{
          _couvercle = "error";
          _humidite = "error";
          _temperature = "error";
        }
    } else {
      _couvercle = "error";
      _humidite = "error";
      _temperature = "error";
    }
    infoRuche = { '_nom'         : _nom.toString(),
      '_description' : _description.toString(),
      '_temperature' : _temperature.toString(),
      '_humidite'    : _humidite.toString(),
      '_couvercle'    : _couvercle.toString(),
      '_notification' : _notification.toString(),
    };

  return infoRuche;
  }

  String getTemperature (Map<String, String> infoRuche){
    try {
      return infoRuche['_temperature']!;
    } catch (e) {
      return '';
    }
  }

  String getHumidite (Map<String, String> infoRuche){
    try {
      return infoRuche['_humidite']!;
    } catch (e) {
      return  '';
    }
  }

  String getNotification (Map<String, String> infoRuche){
    try {
      return infoRuche['_notification']!;
    } catch (e) {
      return  '';
    }
  }

  String getCouvercle(Map<String, String> infoRuche) {
    try {
      return infoRuche['_couvercle']!;
    } catch (e) {
      return '';
    }
  }

  String getDescrition (Map<String, String> infoRuche){
    try {
      return infoRuche['_description']!;
    } catch (e) {
      return '';
    }
  }

  String getNom (Map<String, String> infoRuche){
    try {
      return infoRuche['_nom']!;
    } catch (e) {
      return '';
    }
  }
}