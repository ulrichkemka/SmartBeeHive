import 'package:flutter/material.dart';
import 'package:smart_bee_hive/model/ruchers.dart';
import '../model/ruches.dart';
import 'welcome.dart';
import '../model/context.dart';

class CreateRuche extends StatefulWidget {
  final Context myContextApp;
  final List<Map<String, String>> rucherList;
  const CreateRuche({
    Key? key,
    required this.myContextApp,
    required this.rucherList,
  }): super(key: key);
  
  @override
  CreateRucheState createState() => CreateRucheState();
}

class CreateRucheState extends State<CreateRuche> {
  TextEditingController _nomRuche = TextEditingController();
  TextEditingController _description = TextEditingController();
  TextEditingController _adresseMac = TextEditingController();
  RuchesData rucheToSave = RuchesData();
  RuchersData rucher = RuchersData(adresse: "", description: "", nom: "");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/Image1.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
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
                          "${rucher.getLabelNomRucher(widget.rucherList, widget.myContextApp)}",
                          style:  const TextStyle(
                            color: Color.fromRGBO(255, 255, 255, 1),
                            fontSize: 20,
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 30),
                          const Text(
                            'Créer rûche',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Roboto',
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(height: 30),
                          const Text(
                            'Nom ruche',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Roboto',
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Container(
                            width: 310,
                            height: 45,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              border: Border.all(
                                color: const Color.fromRGBO(4, 97, 147, 1),
                                width: 1,
                              ),
                            ),
                            child:  Padding(
                              padding: EdgeInsets.all(8.0),
                              child: TextField(
                                controller: _nomRuche,
                                decoration: const InputDecoration(
                                  hintText: 'Entrer le nom de la rûche',
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                          const Text(
                            'Adresse mac',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Roboto',
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Container(
                            width: 310,
                            height: 45,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              border: Border.all(
                                color: const Color.fromRGBO(4, 97, 147, 1),
                                width: 1,
                              ),
                            ),
                            child:  Padding(
                              padding: EdgeInsets.all(8.0),
                              child: TextField(
                                controller: _adresseMac,
                                decoration: const InputDecoration(
                                  hintText: 'Entrer l\'adresse mac de l\'appareil',
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                          const Text(
                            'Description',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Roboto',
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Container(
                            width: 310,
                            height: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              border: Border.all(
                                color: const Color.fromRGBO(4, 97, 147, 1),
                                width: 1,
                              ),
                            ),
                            child:  Padding(
                              padding: EdgeInsets.all(8.0),
                              child: TextField(
                                controller: _description,
                                maxLines: null,
                                decoration: const InputDecoration(
                                    hintText: 'Entrer la descrition',
                                    border: InputBorder.none
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          Container(
                            width: 150,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: TextButton(
                              onPressed: () {
                                // Action à effectuer lors de la connexion
                                String nomRucheText = _nomRuche.text;
                                String descriptionText = _description.text;
                                String adresseMacText = _adresseMac.text;
                                rucheToSave.addRuche(widget.myContextApp,nomRucheText, descriptionText, adresseMacText);

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => WelcomePage(myContextApp: widget.myContextApp), // Remplacez "SecondPage" par le nom de votre page de destination
                                  ),
                                );
                              },
                              child: const Text(
                                'Créer la rûche',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
