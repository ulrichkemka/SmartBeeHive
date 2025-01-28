import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_bee_hive/main.dart';
import 'package:smart_bee_hive/model/context.dart';
import 'package:smart_bee_hive/model/date.dart';
import 'package:smart_bee_hive/screen/modifiedRuche.dart';
import 'package:smart_bee_hive/screen/welcome.dart';
import 'package:smart_bee_hive/widget/menuDeroulantDate.dart';
import 'package:smart_bee_hive/model/ruches.dart';
import 'package:smart_bee_hive/widget/menuDeroulantMesures.dart';
import 'package:smart_bee_hive/widget/menu.dart';
import 'package:smart_bee_hive/widget/buttons.dart';
import 'package:smart_bee_hive/model/etat.dart';
import 'package:smart_bee_hive/model/weatherData.dart';
import 'package:smart_bee_hive/widget/modalConfirmation.dart';
import 'package:smart_bee_hive/widget/tableauValeurs.dart';


Etat etat = Etat();
DateToShare dateToShare = DateToShare();
List<WeatherData> weatherData = [];

class RuchePage extends StatefulWidget {
  final Context contextApp;
  const RuchePage({
    required this.contextApp,
});

  @override
  State<RuchePage> createState() => _RuchePageState();

}

class _RuchePageState extends State<RuchePage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const List<String> dropdownValues = ['Mesures Journalières', 'Mesures Hebdomadaires', 'Mesures Mensuelles'];
    List<String> dropdownValuesDays = dateToShare.getAllDays(); // Données à recupérer avec l'api
    List<String> dropdownValuesMonths = dateToShare.getAllMois(); // // Données à recuperer avec l'api
    const List<String> dropdownValuesYears = ['2022','2023']; // // Données à recuperer avec l'api

    RuchesData rucheData = RuchesData();

    return Scaffold(
      body: ChangeNotifierProvider.value(
        value: etat,
        child: Consumer<Etat>(
        builder: (context, etatMesure, _)
        {
         return  Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/Image1.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: FutureBuilder<Map<String, String>>(
              future: rucheData.getInfoRuche(widget.contextApp),
              builder: (BuildContext context, AsyncSnapshot<Map<String, String>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return const Text('Erreur : Sorry!');
                  } else {
                    String labelTemperature = rucheData.getTemperature(snapshot.data!);
                    String labelNom = rucheData.getNom(snapshot.data!);
                    String labelHumidite = rucheData.getHumidite(snapshot.data!);
                    String labelCouvercle = rucheData.getCouvercle(snapshot.data!);
                    String labelDescription = rucheData.getDescrition(snapshot.data!);
                    String notification = rucheData.getNotification(snapshot.data!);
                    bool isNotificationOn=true;
                    if (notification=="0"){
                      isNotificationOn=false;
                    }

                    return Column(
                children: [
                  Container(
                    height: 20,
                    decoration: const  BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/Image1.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Row(
                      children: const [],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Container(
                      height: 50,
                      decoration: const  BoxDecoration(
                        image: DecorationImage(
                        image: AssetImage('assets/images/Image1.png'),
                        fit: BoxFit.cover,
                        ),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back),
                            color: const Color.fromRGBO(255, 255, 255, 1),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                          child: Text(
                            labelNom,
                            style: const TextStyle(
                              color: Color.fromRGBO(255, 255, 255, 1),
                              fontSize: 26,
                            ),
                          ),),),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child:  SingleChildScrollView(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(15, 15, 15, 30),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          width: 125,
                                          height: 125,
                                          decoration: BoxDecoration(
                                            boxShadow: const [
                                              BoxShadow(
                                                color: Color.fromRGBO(0, 0, 0, 0.25),
                                                offset: Offset(0, 4),
                                                blurRadius: 4,
                                              ),
                                            ],
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(10.0),
                                          ),
                                          child: Column(
                                            children: [
                                              SizedBox(height: 10),
                                              const Text(
                                                'Température',
                                                style: TextStyle(
                                                  color: Color.fromRGBO(4, 97, 147, 1),
                                                  fontFamily: 'Roboto',
                                                  fontSize: 20,
                                                ),
                                              ),
                                              const SizedBox(height: 17),
                                              Text(
                                                labelTemperature+"°",
                                                style: const TextStyle(
                                                  color: Color.fromRGBO(4, 97, 147, 1),
                                                  fontFamily: 'Roboto',
                                                  fontSize: 40,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Container(
                                          width: 125,
                                          height: 125,
                                          decoration: BoxDecoration(
                                            boxShadow: const [
                                              BoxShadow(
                                                color: Color.fromRGBO(0, 0, 0, 0.25),
                                                offset: Offset(0, 4),
                                                blurRadius: 4,
                                              ),
                                            ],
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(10.0),
                                          ),
                                          child: Column(
                                            children:  [
                                              SizedBox(height: 10),
                                              const Text(
                                                'Humidité',
                                                style: TextStyle(
                                                  color: Color.fromRGBO(4, 97, 147, 1),
                                                  fontFamily: 'Roboto',
                                                  fontSize: 20,
                                                ),
                                              ),
                                              SizedBox(height: 17),
                                              Text(
                                                labelHumidite+"%",
                                                style: const TextStyle(
                                                  color: Color.fromRGBO(4, 97, 147, 1),
                                                  fontFamily: 'Roboto',
                                                  fontSize: 40,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(15, 15, 15, 30),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          width: 125,
                                          height: 125,
                                          decoration: BoxDecoration(
                                            boxShadow: const [
                                              BoxShadow(
                                                color: Color.fromRGBO(0, 0, 0, 0.25),
                                                offset: Offset(0, 4),
                                                blurRadius: 4,
                                              ),
                                            ],
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(10.0),
                                          ),
                                          child: Column(
                                            children: [
                                              SizedBox(height: 10),
                                              const Text(
                                                'Couvercle',
                                                style: TextStyle(
                                                  color: Color.fromRGBO(4, 97, 147, 1),
                                                  fontFamily: 'Roboto',
                                                  fontSize: 20,
                                                ),
                                              ),
                                              SizedBox(height: 17),
                                              Text(
                                                labelCouvercle,
                                                style: const TextStyle(
                                                  color: Color.fromRGBO(4, 97, 147, 1),
                                                  fontFamily: 'Roboto',
                                                  fontSize: 40,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(15, 15, 15, 30),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          width: 125,
                                          height: 125,
                                          decoration: BoxDecoration(
                                            boxShadow: const [
                                              BoxShadow(
                                                color: Color.fromRGBO(0, 0, 0, 0.25),
                                                offset: Offset(0, 4),
                                                blurRadius: 4,
                                              ),
                                            ],
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(10.0),
                                          ),
                                          child: Column(
                                            children: [
                                              SizedBox(height: 10),
                                              const Text(
                                                'Description',
                                                style: TextStyle(
                                                  color: Color.fromRGBO(4, 97, 147, 1),
                                                  fontFamily: 'Roboto',
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(height: 17),
                                              Text(
                                                labelDescription,
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                  color: Color.fromRGBO(4, 97, 147, 1),
                                                  fontFamily: 'Roboto',
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                 GroupButtons(first: "Modifier", last: "Supprimer",
                                  onFirstButtonPressed: () {
                                    print("modified");
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ModifiedRuche(myContextApp: widget.contextApp), // Remplacez "SecondPage" par le nom de votre page de destination
                                      ),
                                    );
                                  },
                                  onLastButtonPressed: () async {
                                    bool shouldDelete = await showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return ConfirmationDialog(
                                          onConfirm: () {
                                            Navigator.pop(context, true);
                                          },
                                        );
                                      },
                                    );

                                    if (shouldDelete == true) {
                                      try {
                                        print("suppression en cours");
                                        rucheData.deleteRuche(widget.contextApp);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => WelcomePage(myContextApp: widget.contextApp)
                                          ),
                                        );
                                        print("supprimé");
                                      } catch (e) {

                                      }
                                    }

                                  },
                                 ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                  Expanded(
                                  child: Container(
                                              child: Align(
                                                child: SizedBox(
                                                  width: 40,
                                                  height: 40,
                                                  child: Ink(
                                                    decoration: const BoxDecoration(
                                                      color: Color.fromRGBO(255, 255, 255, 1),
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: IconButton(
                                                      onPressed: (){
                                                        RuchesData rucheToSave = RuchesData();
                                                        if (isNotificationOn){
                                                          notification="0";
                                                          rucheToSave.modifyRuche(contextApp, labelNom, labelDescription, notification);
                                                          etat.onChangeEtat(etat.etat);
                                                        } else{
                                                          notification="1";
                                                          rucheToSave.modifyRuche(contextApp, labelNom, labelDescription, notification);
                                                          etat.onChangeEtat(etat.etat);
                                                        }
                                                      },
                                                      icon: CircleAvatar(
                                                        backgroundColor: Colors.white,
                                                        child: Icon(
                                                          isNotificationOn ? Icons.notifications_on : Icons.notifications_off, // Changer l'icône en fonction de l'état
                                                          size: 20,
                                                          color: const Color.fromRGBO(4, 97, 147, 1),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                        ),),]
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(10, 30, 10, 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          width: 100,
                                          height: 3,
                                          decoration: const BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                color: Color.fromRGBO(0, 0, 0, 0.25),
                                              ),
                                            ],
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.all(10),
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: DropdownButtonMesure(
                                      dropdownValues: dropdownValues,
                                      dropdownHeight: 50.0,
                                      etat: etatMesure,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.all(10),
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: DropdownButtonDate(
                                      dropdownValuesDays: dropdownValuesDays,
                                      dropdownValuesMonths: dropdownValuesMonths,
                                      dropdownValuesYears: dropdownValuesYears,
                                      dropdownHeight: 50.0,
                                      etat: etatMesure,
                                      dateToShare: dateToShare,
                                    ),
                                  ),
                                ),
                                DataTableValeur(dateToShare: dateToShare, myContextApp: widget.contextApp),
                              ],
                            ),
                          ),
                    ),
                  Menu(myContextApp: widget.contextApp), // Menu en bas de la page
                ],
              );
                  }
                  },

            ),

         );
        }
        ),
      ),
    );

  }
}

Widget _buildRucheContainer(String label) {
  return Container(
    width: 310,
    height: 60,
    decoration: BoxDecoration(
      boxShadow: const [
        BoxShadow(
          color: Color.fromRGBO(0, 0, 0, 0.25),
          offset: Offset(0, 4),
          blurRadius: 4,
        ),
      ],
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Row(
      children: [
        const SizedBox(width: 17),
        Container(
          width: 40,
          height: 40,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/Image1.png'),
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          label,
          style: const TextStyle(
            color: Color.fromRGBO(4, 97, 147, 1),
            fontFamily: 'Roboto',
            fontSize: 15,
          ),
        ),
      ],
    ),
  );
}

Future<WeatherData?> getlastWeatherDataByRuche() async{
  QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('sensor_data').get();

  for (var doc in snapshot.docs) {
    if (doc.data() is Map<String, dynamic>) {
      dynamic rucheId = (doc.data() as Map<String, dynamic>)['rucheId'];
      if (rucheId.toString() == "R0001") {
        dynamic temperature = (doc.data() as Map<String, dynamic>)['temperature'];
        dynamic humidite = (doc.data() as Map<String, dynamic>)['humidity'];
        dynamic date = (doc.data() as Map<String, dynamic>)['date'];
        dynamic heure = (doc.data() as Map<String, dynamic>)['heure'];
        dynamic couvercle = (doc.data() as Map<String, dynamic>)['couvercle'];

        WeatherData weatherData = WeatherData(
          temperature: temperature.toString(),
          humidite: humidite.toString(),
          date : date.toString(),
          heure: heure.toString(),
          couvercle: couvercle.toString(),
        );
        return weatherData;
      }
    }
  }

  return null;
}