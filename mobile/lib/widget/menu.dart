import 'package:flutter/material.dart';
import 'package:smart_bee_hive/screen/welcome.dart';
import '../model/context.dart';
import '../screen/login.dart';
import '../screen/modifiedApiculteur.dart';


class Menu extends StatefulWidget {
  final Context myContextApp;

  const Menu({
    Key? key,
    required this.myContextApp,
  }): super(key: key);


  @override
  MenuState createState() => MenuState();
}

class MenuState extends State<Menu> {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      color: const Color.fromRGBO(252, 255, 255, 1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 10,
            height: 10,
            // Placeholder ou contenu de l'image
          ),
          const SizedBox(width: 17),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ModifiedApiculteur(myContextApp: widget.myContextApp)),
                    );
                  },
                  child: Container(
                    width: 25,
                    height: 25,
                    // Placeholder ou contenu de l'image
                    child: Image.asset('assets/images/avatar.png'),
                  ),
                ),
                const Text(
                  'Mon compte',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color.fromRGBO(4, 97, 147, 1),
                    fontFamily: 'Roboto',
                    fontSize: 15,
                    letterSpacing: 0,
                    fontWeight: FontWeight.normal,
                    height: 1,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => WelcomePage(myContextApp: widget.myContextApp)),
                    );
                  },
                  child: Container(
                    width: 25,
                    height: 25,
                    // Placeholder ou contenu de l'image
                    child: Image.asset('assets/images/home.png'),
                  ),
                ),
                const Text(
                  'Home',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color.fromRGBO(4, 97, 147, 1),
                    fontFamily: 'Roboto',
                    fontSize: 15,
                    letterSpacing: 0,
                    fontWeight: FontWeight.normal,
                    height: 1,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage(myContextApp: widget.myContextApp)),
                    );
                  },
                  child: Container(
                    width: 25,
                    height: 25,
                    // Placeholder ou contenu de l'image
                    child: Image.asset('assets/images/logout.png'),
                  ),
                ),
                const Text(
                  'Déconnexion',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Color.fromRGBO(4, 97, 147, 1),
                    fontFamily: 'Roboto',
                    fontSize: 15,
                    letterSpacing: 0,
                    fontWeight: FontWeight.normal,
                    height: 1,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
