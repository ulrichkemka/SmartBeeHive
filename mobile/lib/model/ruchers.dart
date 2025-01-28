import 'dart:convert';
import 'package:smart_bee_hive/model/context.dart';
import 'package:http/http.dart' as http;

class RuchersData {
  final String adresse;
  final String description;
  final String nom;

  RuchersData({required this.adresse, required this.description, required this.nom});

  String adressIp = "http://20.115.59.151:8080";

  Future<void> addRucher(Context context, String nomRucher, String adresse, String description) async {
    final url = Uri.parse('$adressIp/user/rucher/${context.idApiculteur}');
    final data = {
      "nom" : nomRucher,
      "description": description,
      "adresse": adresse
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

  Future<void> modifyRucher(Context context, String nomRucher, String adresse, String description) async {
    final url = Uri.parse('$adressIp/user/rucher/${context.idApiculteur}/${context.idRucher}');
    final data = {
      "id"  : context.idRucher,
      "nom" : nomRucher,
      "description": description,
      "adresse": adresse
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

  Future<void> deleteRucher(Context context) async {
    final response = await http.delete(Uri.parse('$adressIp/user/rucher/${context.idApiculteur}/${context.idRucher}'));

    if (response.statusCode == 200) {

    } else {

    }
  }

  Future<List<Map<String, String>>> getRucherByApiculteur(Context context) async {

    final response = await http.get(Uri.parse('$adressIp/user/rucher/${context.idApiculteur}'));
    List<Map<String, String>> ruchersList = [];
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      for (var rucher in data) {
        ruchersList.add({'id' : rucher['id'].toString(),'nom' : rucher['nom'].toString(),
          'adresse' : rucher['adresse'].toString(),  'description' : rucher['description'].toString()
        });
      }
    } else {
      throw Exception('Erreur lors de la récupération des données de l\'API');
    }
    if ((ruchersList.isNotEmpty) && (context.idRucher == "")){
      context.onchangeContext(rucher: ruchersList[0]['id'].toString());
    }
    return ruchersList;
  }


  List<String> getLabelRuchersByApiculteur(List<Map<String, String>> mapList) {
    List<String> idList = mapList.map((map) => map['nom']!).toList();
    return idList;
  }

  String getLabelNomRucher(List<Map<String, String>> mapList, Context context){
    String desiredId = context.idRucher;
    String desiredName="";
    for (Map<String, String> map in mapList) {
      if (map['id'] == desiredId) {
        desiredName = map['nom']!;
        break;
      }
    }
    return desiredName;
  }

  String getLabelDescriptionRucher(List<Map<String, String>> mapList,Context context) {
    String desiredId = context.idRucher;
    String desiredDescription="";
    for (Map<String, String> map in mapList) {
      if (map['id'] == desiredId) {
        desiredDescription = map['description']!;
        break;
      }
    }
    return desiredDescription;
  }

  String getLabelAdresseRucher(List<Map<String, String>> mapList,Context context) {
    String desiredId = context.idRucher;
    String desiredAdresse="";
    for (Map<String, String> map in mapList) {
      if (map['id'] == desiredId) {
        desiredAdresse = map['adresse']!;
        break;
      }
    }
    return desiredAdresse;
  }

  Future<String> getIdRucherByNomRucher(List<Map<String, String>> mapList, String nomRucher) async {
    List<String> idList = [];

    for (var map in mapList) {
      if (map['nom'] == nomRucher) {
        idList.add(map['id']!);
      }
    }
    return idList.first;
  }

}