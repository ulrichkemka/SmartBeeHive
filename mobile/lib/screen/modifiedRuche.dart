import 'package:flutter/material.dart';
import 'package:smart_bee_hive/model/ruchers.dart';
import 'package:smart_bee_hive/model/ruches.dart';
import 'package:smart_bee_hive/screen/ruche.dart';
import 'welcome.dart';
import '../model/context.dart';

class ModifiedRuche extends StatefulWidget {
  final Context myContextApp;

  const ModifiedRuche({
    Key? key,
    required this.myContextApp,
  }): super(key: key);


  @override
  ModifiedRucheState createState() => ModifiedRucheState();
}

class ModifiedRucheState extends State<ModifiedRuche> {
  TextEditingController _nomRuche = TextEditingController();
  TextEditingController _description = TextEditingController();

  @override
  Widget build(BuildContext context) {
    RuchesData rucheData = RuchesData();
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
        child: FutureBuilder<Map<String, String>>(
          future: rucheData.getInfoRuche(widget.myContextApp),
          builder: (BuildContext context, AsyncSnapshot<Map<String, String>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return const Text('Erreur : Sorry!');
            } else {
              String labelNom = rucheData.getNom(snapshot.data!);
              String labelDescription = rucheData.getDescrition(snapshot.data!);
              String notification = rucheData.getNotification(snapshot.data!);
              return Column(
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
                          labelNom,
                          style:  const TextStyle(
                            color:  Color.fromRGBO(255, 255, 255, 1),
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
                            'Modification de la rûche',
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
                                decoration: InputDecoration(
                                  hintText: labelNom,
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
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                controller: _description,
                                maxLines: null,
                                decoration: InputDecoration(
                                    hintText: labelDescription,
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
                                String nomRucheText = ((_nomRuche.text).isEmpty) ? labelNom : _nomRuche.text;
                                String descriptionText = ((_description.text).isEmpty) ? labelDescription : _description.text;

                                RuchesData rucheToSave = RuchesData();
                                try{
                                  rucheToSave.modifyRuche(widget.myContextApp, nomRucheText, descriptionText,notification);

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => RuchePage(contextApp: widget.myContextApp), // Remplacez "SecondPage" par le nom de votre page de destination
                                    ),
                                  );
                                }
                                catch(e){
                                }
                              },
                              child: const Text(
                                'Modifier',
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
        );}},),
      ),
    );
  }
}
