import 'package:flutter/material.dart';
import 'package:smart_bee_hive/model/apiculteur.dart';
import 'welcome.dart';
import '../model/context.dart';

class ModifiedApiculteur extends StatefulWidget {
  final Context myContextApp;

  const ModifiedApiculteur({
    Key? key,
    required this.myContextApp,
  }): super(key: key);


  @override
  ModifiedApiculteurState createState() => ModifiedApiculteurState();
}

class ModifiedApiculteurState extends State<ModifiedApiculteur> {
  TextEditingController _nomApiculteur = TextEditingController();
  TextEditingController _prenomApiculteur = TextEditingController();
  TextEditingController _adresseApiculteur = TextEditingController();
  TextEditingController _emailApiculteur = TextEditingController();
  TextEditingController _passwordApiculteur = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ApiculteursData apiculteurData = ApiculteursData(id: "");
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
          future: apiculteurData.getInfoApiculteur(widget.myContextApp),
          builder: (BuildContext context, AsyncSnapshot<Map<String, String>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return const Text('Erreur : Sorry!');
            } else {
              String labelNom = apiculteurData.getNom(snapshot.data!);
              String labelPrenom = apiculteurData.getPrenom(snapshot.data!);
              String labelAdresse = apiculteurData.getAdresse(snapshot.data!);
              String labelPassword = apiculteurData.getPassword(snapshot.data!);
              String labelEmail = apiculteurData.getEmail(snapshot.data!);
              String labelId = apiculteurData.getId(snapshot.data!);
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
                                  'Modification des informations',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Roboto',
                                    fontSize: 20,
                                  ),
                                ),
                                const SizedBox(height: 30),
                                const Text(
                                  'Nom apiculteur',
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
                                      controller: _nomApiculteur,
                                      decoration: InputDecoration(
                                        hintText: labelNom,
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 15),
                                const Text(
                                  'Prénom apiculteur',
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
                                      controller: _prenomApiculteur,
                                      decoration: InputDecoration(
                                        hintText: labelPrenom,
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 15),
                                const Text(
                                  'Adresse apiculteur',
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
                                      controller: _adresseApiculteur,
                                      decoration: InputDecoration(
                                        hintText: labelAdresse,
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 15),
                                const Text(
                                  'Email apiculteur',
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
                                      enabled: false,
                                      controller: _emailApiculteur,
                                      decoration: InputDecoration(
                                        hintText: labelEmail,
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 15),
                                const Text(
                                  'Password',
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
                                      controller: _passwordApiculteur,
                                      obscureText: true,
                                      decoration: const InputDecoration(
                                        hintText: ".......",
                                        border: InputBorder.none,
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
                                      String nomApiculteurText = ((_nomApiculteur.text).isEmpty) ? labelNom : _nomApiculteur.text;
                                      String prenomApiculteurText = ((_prenomApiculteur.text).isEmpty) ? labelPrenom : _prenomApiculteur.text;
                                      String adresseApiculteurText = ((_adresseApiculteur.text).isEmpty) ? labelAdresse : _adresseApiculteur.text;
                                      String emailApiculteurText = labelEmail;
                                      String passwordApiculteurText = ((_passwordApiculteur.text).isEmpty) ? labelPassword : _passwordApiculteur.text;
                                      String idApiculteurText = labelId;
                                      ApiculteursData apiculteurToSave = ApiculteursData(id:"");
                                      try{
                                        apiculteurToSave.modifyApiculteur(widget.myContextApp, nomApiculteurText, prenomApiculteurText,
                                        adresseApiculteurText,
                                        emailApiculteurText,passwordApiculteurText);

                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => WelcomePage(myContextApp: widget.myContextApp),// Remplacez "SecondPage" par le nom de votre page de destination
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
