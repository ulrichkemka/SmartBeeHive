import 'package:flutter/material.dart';
import 'package:smart_bee_hive/model/context.dart';
import 'package:smart_bee_hive/model/etat.dart';
import 'package:smart_bee_hive/screen/modifiedRucher.dart';
import 'package:smart_bee_hive/widget/modalConfirmation.dart';
import 'createRuche.dart';
import 'createRucher.dart';
import 'ruche.dart';
import '../widget/menuDeroulantRuchers.dart';
import '../widget/menu.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/ruchers.dart';
import '../model/ruches.dart';
import '../widget/buttons.dart';

Etat etat = Etat();

class WelcomePage extends StatefulWidget {
  final Context myContextApp;

  const WelcomePage({
    Key? key,
    required this.myContextApp,
  }): super(key: key);

  @override
  State<WelcomePage> createState() => WelcomePageState();
}

class WelcomePageState extends State<WelcomePage> {
  late Future<List<Map<String, String>>> _myFuture;
  List<Map<String, String>> ruchersList =[];
  RuchersData ruchersData = RuchersData(adresse: "", description: "", nom: "");

  Future<void> _initialize() async{
    _myFuture = ruchersData.getRucherByApiculteur(widget.myContextApp);
    await _myFuture;
  }


  Future<List<Map<String, String>>> getRucherList(){
    return _myFuture;
  }

    @override
    void initState() {
    super.initState();
    _initialize();
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder<List<Map<String, String>>>(
      future: getRucherList(),
       builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return const Text('Une erreur s\'est produite');
        } else {
          return Scaffold(
            body: ChangeNotifierProvider.value(
              value: etat,
              child: Consumer<Etat>(
                builder: (context, etatMesure, _) {
                  final rucherList = snapshot.data ?? [];
                  final dropdownValues = ruchersData.getLabelRuchersByApiculteur(snapshot.data ?? []);
                  final _description = ruchersData.getLabelDescriptionRucher(snapshot.data ?? [], widget.myContextApp);
                  final _adresse = ruchersData.getLabelAdresseRucher(snapshot.data ?? [], widget.myContextApp);
                  if(rucherList.isNotEmpty){
                    return Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/Image1.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Column(
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
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Image.asset(
                                      'assets/images/Logoog1.png',
                                      width: 50,
                                      height: 50,
                                    ),
                                  ),
                                  const Expanded(
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        "Smart Bee Hive",
                                        style: TextStyle(
                                          color: Color.fromRGBO(0, 0, 0, 1),
                                          fontSize: 18,
                                          fontFamily: 'Road_Rage',
                                        ),
                                      ),),),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Container(
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
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) => CreateRucher(myContextApp: widget.myContextApp), // Remplacez "SecondPage" par le nom de votre page de destination
                                                            ),
                                                          );
                                                        },
                                                        icon: const CircleAvatar(
                                                          backgroundColor: Colors.white,
                                                          child: Icon(
                                                            Icons.add,
                                                            size: 20,
                                                            color: Color.fromRGBO(4, 97, 147, 1),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                child: const Text(
                                                  'Rûcher',
                                                  style: TextStyle(
                                                      color: Color.fromRGBO(255, 255, 255, 1),
                                                      fontFamily: 'Road Rage',
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.bold
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.all(0),
                                          child:  Align(
                                            alignment: Alignment.centerRight,
                                            child: DropdownButtonRucher(
                                              dropdownValues: dropdownValues,
                                              dropdownHeight: 50.0,
                                              etat: etatMesure,
                                              context: widget.myContextApp,
                                              rucherList: rucherList,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(15, 15, 15, 20),
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
                                              children:  [
                                                SizedBox(height: 10),
                                                const Text(
                                                  'Description',
                                                  style: TextStyle(
                                                    color: Color.fromRGBO(4, 97, 147, 1),
                                                    fontFamily: 'Roboto',
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                SizedBox(height: 5),
                                                Text(
                                                  _description,
                                                  textAlign: TextAlign.center,
                                                  style:  const TextStyle(
                                                    color: Color.fromRGBO(4, 97, 147, 1),
                                                    fontFamily: 'Roboto',
                                                    fontSize: 12,
                                                  ),
                                                ),
                                                SizedBox(height: 10),
                                                const Text(
                                                  'Adresse',
                                                  style: TextStyle(
                                                    color: Color.fromRGBO(4, 97, 147, 1),
                                                    fontFamily: 'Roboto',
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                SizedBox(height: 5),
                                                Text(
                                                  _adresse,
                                                  textAlign: TextAlign.center,
                                                  style:  const TextStyle(
                                                    color: Color.fromRGBO(4, 97, 147, 1),
                                                    fontFamily: 'Roboto',
                                                    fontSize: 12,
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
                                    padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
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
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) => CreateRuche(myContextApp: widget.myContextApp, rucherList: snapshot.data ?? [] ), // Remplacez "SecondPage" par le nom de votre page de destination
                                                      ),
                                                    );
                                                  },
                                                  icon: const CircleAvatar(
                                                    backgroundColor: Colors.white,
                                                    child: Icon(
                                                      Icons.add,
                                                      size: 20,
                                                      color: Color.fromRGBO(4, 97, 147, 1),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          child: const Text(
                                            'Rûche',
                                            style: TextStyle(
                                                color: Color.fromRGBO(255, 255, 255, 1),
                                                fontFamily: 'Road Rage',
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  getRuches(context, widget.myContextApp,etatMesure.etat),
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
                                  GroupButtons(first: "Modifier", last: "Supprimer",
                                    onFirstButtonPressed: () {
                                      print("modified");
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ModifiedRucher(ruchersList: rucherList,myContextApp: widget.myContextApp), // Remplacez "SecondPage" par le nom de votre page de destination
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
                                          ruchersData.deleteRucher(widget.myContextApp);
                                          widget.myContextApp.onchangeContext(rucher: "");
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => WelcomePage(myContextApp: widget.myContextApp),
                                            ),
                                          );
                                          print("supprimé");
                                        } catch (e) {

                                        }
                                      }

                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Menu(myContextApp: widget.myContextApp),
                        ],
                      ),
                    );
                  }
                  else {
                    return Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/Image1.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Column(
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
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: Image.asset(
                                        'assets/images/Logoog1.png',
                                        width: 50,
                                        height: 50,
                                      ),
                                    ),
                                    const Expanded(
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          "Smart Bee Hive",
                                          style: TextStyle(
                                            color: Color.fromRGBO(0, 0, 0, 1),
                                            fontSize: 18,
                                            fontFamily: 'Road_Rage',
                                          ),
                                        ),),),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
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
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => CreateRucher(myContextApp: widget.myContextApp), // Remplacez "SecondPage" par le nom de votre page de destination
                                                ),
                                              );
                                            },
                                            icon: const CircleAvatar(
                                              backgroundColor: Colors.white,
                                              child: Icon(
                                                Icons.add,
                                                size: 20,
                                                color: Color.fromRGBO(4, 97, 147, 1),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: const Text(
                                      'Ajouter Rûcher',
                                      style: TextStyle(
                                          color: Color.fromRGBO(255, 255, 255, 1),
                                          fontFamily: 'Road Rage',
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ]));
                  }
                },
              ),
            ),
          );
        }
      },
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
              image: AssetImage('assets/images/ruche.png'),
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

Widget getRuches(BuildContext context, Context myContextApp,int etat) {
  RuchesData ruchesData = RuchesData();
  return FutureBuilder<List<String>>(
    future: ruchesData.getLabelRuches(myContextApp), // A Remplacer avec le nom du rucher selectionné sur le dropdownbutton
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return CircularProgressIndicator();
      } else if (snapshot.hasError) {
        return Text('Une erreur s\'est produite');
      } else {
        final labelRuches = snapshot.data ?? [];

        return Column(
          children: [
            for (String label in labelRuches)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: InkWell(
                  onTap: ()  async {
                    myContextApp.onchangeContext(ruche: await ruchesData.getIdRucheByNomRuche(myContextApp, label));
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RuchePage(contextApp: myContextApp), // Avec Parametre pour la redirection vers la page de la ruche
                      ),
                    );
                  },
                  child: _buildRucheContainer(label),
                ),
              ),
          ],
        );
      }
    },
  );
}




