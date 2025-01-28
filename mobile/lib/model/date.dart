import 'package:flutter/foundation.dart';

class DateToShare extends ChangeNotifier{
  int jour = 1;
  int mois = 1;
  int annee = 2023;
  int semaine = 1;

  void onChangeDateToDisplay(int j, int m, int a,int s){
    this.jour=j;
    this.mois=m;
    this.annee=a;
    this.semaine=s;
    notifyListeners();
  }

  String dateToSearch(int day, int month, int year){
    String d = (day < 10) ? "0" + day.toString() : day.toString();
    String m = (day < 10) ? "0" + month.toString() : month.toString();
    String y = year.toString();

    return "$y-$m-$d";
  }

  int getNumeroMois(String labelMois) {
    List<String> mois = [
      "", // Index 0, aucune correspondance
      "janvier", // Index 1
      "fevrier", // Index 2
      "mars", // Index 3
      "avril", // Index 4
      "mai", // Index 5
      "juin", // Index 6
      "juillet", // Index 7
      "aout", // Index 8
      "septembre", // Index 9
      "octobre", // Index 10
      "novembre", // Index 11
      "decembre" // Index 12
    ];

    int index = mois.indexOf(labelMois.toLowerCase());
    return index;
  }

  String getLabelMois(int numeroMois) {
    List<String> mois = [
      "", // Index 0, aucune correspondance
      "janvier", // Index 1
      "fevrier", // Index 2
      "mars", // Index 3
      "avril", // Index 4
      "mai", // Index 5
      "juin", // Index 6
      "juillet", // Index 7
      "aout", // Index 8
      "septembre", // Index 9
      "octobre", // Index 10
      "novembre", // Index 11
      "decembre" // Index 12
    ];

    if (numeroMois >= 1 && numeroMois <= 12) {
      return mois[numeroMois];
    } else {
      return "";
    }
  }

  List<String> getAllMois(){
    List<String> mois = [
      "janvier",
      "fevrier",
      "mars",
      "avril",
      "mai",
      "juin",
      "juillet",
      "aout",
      "septembre",
      "octobre",
      "novembre",
      "decembre"
    ];

    return mois;
  }

  List<String> getAllDays(){
    List<String> jours=[];
    for(int i=1; i<=31 ; i++){
      jours.add(i.toString());
    }
    return jours;
  }

}