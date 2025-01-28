import 'package:smart_bee_hive/model/ruchers.dart';

class Context {
  String idRuche = "";
  String idRucher = "";
  String idApiculteur = "";

  List<RuchersData> allRuchers = [];

  void onchangeContext({String? rucher,String? ruche,String? apiculteur}){
    idRucher = rucher ?? idRucher;
    idRuche = ruche ?? idRuche;
    idApiculteur = apiculteur ?? idApiculteur;
  }

}

