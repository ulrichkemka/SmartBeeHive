import 'package:flutter/material.dart';
import '../model/etat.dart';



class DropdownButtonMesure extends StatefulWidget {
  final List<String> dropdownValues;
  final double dropdownHeight;
  final Etat etat;

  const DropdownButtonMesure({
    Key? key,
    required this.dropdownValues,
    required this.dropdownHeight,
    required this.etat,
  }) : super(key: key);

  @override
  State<DropdownButtonMesure> createState() => _DropdownButtonMesureState();
}

class _DropdownButtonMesureState extends State<DropdownButtonMesure> {
  String dropdownValue = '';

  @override
  void initState() {
    super.initState();
    dropdownValue = widget.dropdownValues.first;
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        // Define the background color
        canvasColor: Colors.white,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: Colors.white,
            width: 2.0,
          ),
        ),
        child: DropdownButtonHideUnderline(
          child : DropdownButton<String>(
          itemHeight: widget.dropdownHeight,
          value: dropdownValue,
          isDense: true,
          style: const TextStyle(color: const Color(0xFF0F5378)),
          onChanged: (String? value) {
            if (value != null) {
              setState(() {
                dropdownValue = value;
              });

              // Perform actions based on the selected value
              if (value == widget.dropdownValues[0]) {
                // Selected 'Mesures Journalières'
                widget.etat.onChangeEtat(5);
              } else if (value == widget.dropdownValues[1]) {
                // Selected 'Mesures Hebdomadaires'
                widget.etat.onChangeEtat(10);
              } else if (value == widget.dropdownValues[2]) {
                // Selected 'Mesures Mensuelles'
                widget.etat.onChangeEtat(15);
              }
            }
          },
          items: widget.dropdownValues.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),),
      ),
    );
  }
}


