import 'package:flutter/foundation.dart';



class Etat extends ChangeNotifier {
  int etat = 0;

  Future<void> onChangeEtat(int e) async {
    this.etat=e;
    notifyListeners();
  }
}