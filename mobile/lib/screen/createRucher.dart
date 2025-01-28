import 'package:flutter/material.dart';
import 'package:smart_bee_hive/model/ruchers.dart';
import 'welcome.dart';
import '../model/context.dart';

class CreateRucher extends StatefulWidget {
  final Context myContextApp;

  const CreateRucher({
    Key? key,
    required this.myContextApp,
  }): super(key: key);


  @override
  CreateRucherState createState() => CreateRucherState();
}

class CreateRucherState extends State<CreateRucher> {
  TextEditingController _nomRucher = TextEditingController();
  TextEditingController _adresse = TextEditingController();
  TextEditingController _description = TextEditingController();

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
                    const Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "Nouveau rûcher",
                          style:  TextStyle(
                            color: Color.fromRGBO(255, 255, 255, 1),
                            fontSize: 26,
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
                                'Créer rûcher',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Roboto',
                                    fontSize: 20,
                                ),
                                ),
                                const SizedBox(height: 30),
                                const Text(
                                    'Nom rucher',
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
                                      controller: _nomRucher,
                                      decoration: const InputDecoration(
                                          hintText: 'Entrer le nom du rûcher',
                                          border: InputBorder.none,
                                      ),
                                    ),
                                ),
                                ),
                                const SizedBox(height: 15),
                                const Text(
                                    'Adresse',
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
                                      controller: _adresse,
                                      decoration: const InputDecoration(
                                          hintText: 'Entrer l\'adresse',
                                          border: InputBorder.none,
                                      ),
                                    ),
                                ),
                                ),
                                const SizedBox(height: 15),
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
                                          String nomRucheText = _nomRucher.text;
                                          String adresseText = _adresse.text;
                                          String descriptionText = _description.text;

                                          RuchersData rucherToSave = RuchersData(adresse: "", description: "", nom: "");
                                          try{
                                            rucherToSave.addRucher(widget.myContextApp, nomRucheText, adresseText, descriptionText);

                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => WelcomePage(myContextApp: widget.myContextApp), // Remplacez "SecondPage" par le nom de votre page de destination
                                              ),
                                            );
                                          }
                                          catch(e){
                                          }
                                        },
                                        child: const Text(
                                        'Créer le rûcher',
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
