import 'package:flutter/material.dart';
import 'package:smart_bee_hive/screen/createRucher.dart';
import 'createRuche.dart';
import 'welcome.dart';
import '../model/context.dart';
import '../model/apiculteur.dart';

class LoginPage extends StatefulWidget {
  final Context myContextApp;

  const LoginPage({
    Key? key,
     required this.myContextApp,
  }): super(key: key);


  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();

    void _showToast(BuildContext context, String message) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          duration: Duration(seconds: 2),
        ),
      );
    }

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
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                            ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.asset(
                                'assets/images/Logoog1.png',
                                width: 50,
                                height: 50,
                            ),
                            ),
                          const SizedBox(width: 10),
                          const Expanded(
                            child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                    'Smart Bee Hive',
                                    style: TextStyle(
                                        color: Color.fromRGBO(6, 0, 0, 1),
                                        fontFamily: 'Road_Rage',
                                        fontSize: 25,
                                    ),
                                ),
                            ),
                        ),
                    ],
                ),
            ),
            Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 30),
                      const Text(
                        'Bienvenue',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Roboto',
                            fontSize: 20,
                        ),
                        ),
                      const SizedBox(height: 30),
                      const Text(
                            'Identifiant de connexion',
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
                            color: Color.fromRGBO(4, 97, 147, 1),
                            width: 1,
                            ),
                        ),
                        child:  Padding(
                            padding: EdgeInsets.all(8.0),
                            child: TextField(
                              controller: email,
                              decoration: const InputDecoration(
                                  hintText: 'Entrer votre identifiant de connexion',
                                  border: InputBorder.none,
                              ),
                            ),
                        ),
                        ),
                      const SizedBox(height: 15),
                      const Text(
                            'Mot de passe',
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
                            color: Color.fromRGBO(4, 97, 147, 1),
                            width: 1,
                            ),
                        ),
                        child:  Padding(
                            padding: EdgeInsets.all(8.0),
                            child: TextField(
                              controller: password,
                              obscureText: true,
                              decoration: const InputDecoration(
                                  hintText: 'Entrer votre mot de passe',
                                  border: InputBorder.none,
                              ),
                            ),
                        ),
                        ),
                      const SizedBox(height: 30),
                        Container(
                            width: 150,
                            height: 50,
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(30),
                            ),
                            child: TextButton(
                                onPressed: () async {
                                // Action à effectuer lors de la connexion
                                  // A completer avec un appel API Spring
                                  try{
                                    ApiculteursData apiculteur = ApiculteursData(id: "");
                                    String token = await apiculteur.getConnect(email.text, password.text);
                                    if (token != ""){
                                      String idApi = apiculteur.getIdApiculteur(token);
                                      widget.myContextApp.onchangeContext(apiculteur: idApi);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => WelcomePage(myContextApp: widget.myContextApp), // Redirection vers ma page principale
                                        ),
                                      );
                                    } else{
                                      _showToast(context, "Connexion refusée : email ou mot de passe incorrect");
                                    }

                                  } catch(e){

                                  }

                                },
                                child: const Text(
                                'Se connecter',
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
    );
  }
}
