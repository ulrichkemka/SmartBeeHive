import 'dart:convert';
import 'context.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decode/jwt_decode.dart';

class ApiculteursData {
  final String id;

  ApiculteursData({required this.id});

  String adressIp = "http://20.115.59.151:8080";

  Future<String> getConnect(String email, String password) async {
    final url = Uri.parse('$adressIp/auth/signIn/$email/$password');
    String token="";
    try {
      final response = await http.post(url);
      print(url);
      if (response.statusCode == 200) {
        var inf = json.decode(response.body);
        token = inf['idToken'].toString();
        return token;
      }
      else {
        return token;
      }
    }catch(e){
      return token;
    }
  }

  String getIdApiculteur(String token){
    Map<String, dynamic> decodedToken = Jwt.parseJwt(token);
    if (decodedToken != null) {
      String idApi = decodedToken['user_id'];
      return idApi;
    } else {

      return "";
    }
  }

  Future<Map<String, String>> getInfoApiculteur(Context context) async {
    final response_inf = await http.get(Uri.parse('$adressIp/user/${context.idApiculteur}'));

    String _nom ="";
    String _prenom="";
    String _adresse="";
    String _email="";
    String _password="";
    String _id="";
    Map<String, String> infoApiculteur= {};

    if (response_inf.statusCode == 200) {
      var inf = json.decode(response_inf.body);
      _nom = inf['nom'].toString();
      _prenom = inf['prenom'].toString();
      _adresse = inf['adresse'].toString();
      _password = inf['password'].toString();
      _email = inf['email'].toString();
      _id = inf['id'].toString();
    } else {
      throw Exception('Erreur lors de la récupération des données de l\'API');
    }

    infoApiculteur = { '_nom'         : _nom.toString(),
      '_prenom' : _prenom.toString(),
      '_adresse' : _adresse.toString(),
      '_password'    : _password.toString(),
      '_email'    : _email.toString(),
      '_id' : _id.toString(),
    };

    return infoApiculteur;
  }

  Future<void> modifyApiculteur(Context context, String nom, String prenom, String adresse,
      String email, String password) async {
    final url = Uri.parse('$adressIp/user/${context.idApiculteur}/apiculteur');
    final data = {
      "id"  : context.idApiculteur,
      "nom" : nom,
      "prenom": prenom,
      "email": email,
      "adresse" : adresse,
      "password": password,
      "role": "apiculteur",
      "username":nom+prenom,
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

  String getNom (Map<String, String> infoApiculteur){
    try {
      return infoApiculteur['_nom']!;
    } catch (e) {
      return  '';
    }
  }

  String getEmail (Map<String, String> infoApiculteur){
    try {
      return infoApiculteur['_email']!;
    } catch (e) {
      return  '';
    }
  }

  String getPrenom (Map<String, String> infoApiculteur){
    try {
      return infoApiculteur['_prenom']!;
    } catch (e) {
      return  '';
    }
  }

  String getAdresse (Map<String, String> infoApiculteur){
    try {
      return infoApiculteur['_adresse']!;
    } catch (e) {
      return  '';
    }
  }

  String getPassword (Map<String, String> infoApiculteur){
    try {
      return infoApiculteur['_password']!;
    } catch (e) {
      return  '';
    }
  }

  String getId (Map<String, String> infoApiculteur){
    try {
      return infoApiculteur['_id']!;
    } catch (e) {
      return  '';
    }
  }



}