import 'package:flutter/material.dart';

class GroupButtons extends StatelessWidget {
  final String first;
  final String last;
  final VoidCallback onFirstButtonPressed; // Fonction liée au premier bouton
  final VoidCallback onLastButtonPressed; // Fonction liée au dernier bouton

  const GroupButtons({
    Key? key,
    required this.first,
    required this.last,
    required this.onFirstButtonPressed,
    required this.onLastButtonPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 10, 1),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            GestureDetector(
              onTap: onFirstButtonPressed, // Appeler la fonction lors du clic sur le premier bouton
              child: Container(
                width: 90,
                height: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.25),
                      offset: Offset(0, 4),
                      blurRadius: 4,
                    ),
                  ],
                  color: const Color.fromRGBO(163, 212, 212, 1),
                ),
                child: Center(
                  child: Text(
                    first,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color.fromRGBO(29, 131, 33, 1),
                      fontFamily: 'Roboto',
                      fontSize: 11,
                      letterSpacing: 0,
                      fontWeight: FontWeight.normal,
                      height: 1,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 15,),
            GestureDetector(
              onTap: onLastButtonPressed, // Appeler la fonction lors du clic sur le dernier bouton
              child: Container(
                width: 90,
                height: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.25),
                      offset: Offset(0, 4),
                      blurRadius: 4,
                    ),
                  ],
                  color: const Color.fromRGBO(228, 113, 113, 1),
                ),
                child: Center(
                  child: Text(
                    last,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 1),
                      fontFamily: 'Roboto',
                      fontSize: 11,
                      letterSpacing: 0,
                      fontWeight: FontWeight.normal,
                      height: 1,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
