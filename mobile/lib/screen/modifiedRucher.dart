import 'package:flutter/material.dart';
import 'package:smart_bee_hive/model/ruchers.dart';
import 'package:smart_bee_hive/model/ruches.dart';
import 'package:smart_bee_hive/screen/ruche.dart';
import 'welcome.dart';
import '../model/context.dart';

class ModifiedRucher extends StatefulWidget {
  final Context myContextApp;
  final List<Map<String, String>> ruchersList;

  const ModifiedRucher({
    Key? key,
    required this.myContextApp,
    required this.ruchersList,
  }): super(key: key);


  @override
  ModifiedRucherState createState() => ModifiedRucherState();
}

class ModifiedRucherState extends State<ModifiedRucher> {
  TextEditingController _nomRucher = TextEditingController();
  TextEditingController _description = TextEditingController();
  TextEditingController _adresse = TextEditingController();
  @override
  Widget build(BuildContext context) {
    RuchersData rucherData = RuchersData(adresse: "", description: "", nom: "");
    String _labelDescription = rucherData.getLabelDescriptionRucher(widget.ruchersList, widget.myContextApp);
    String _labelNomRuche = rucherData.getLabelNomRucher(widget.ruchersList, widget.myContextApp);
    String _labelAdresseRuche = rucherData.getLabelAdresseRucher(widget.ruchersList, widget.myContextApp);
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
                                _labelNomRuche,
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
                                  'Modification du rûcher',
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
                                      decoration: InputDecoration(
                                        hintText: _labelNomRuche,
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
                                      decoration: InputDecoration(
                                        hintText: _labelAdresseRuche,
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
                                      decoration: InputDecoration(
                                          hintText: _labelDescription,
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
                                      String nomRucheText = ((_nomRucher.text).isEmpty) ? _labelNomRuche : _nomRucher.text;
                                      String descriptionText = ((_description.text).isEmpty) ? _labelDescription : _description.text;
                                      String adresseText = ((_adresse.text).isEmpty) ? _labelAdresseRuche : _adresse.text;
                                      RuchersData rucherToSave = RuchersData(adresse: "", description: "", nom: "");
                                      try{
                                        rucherToSave.modifyRucher(widget.myContextApp, nomRucheText, adresseText, descriptionText);

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
              ),
      ),
    );
  }
}
