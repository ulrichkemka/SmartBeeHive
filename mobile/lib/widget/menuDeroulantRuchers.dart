import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smart_bee_hive/model/context.dart';
import '../model/etat.dart';
import '../model/ruchers.dart';

List<String> liste =[];

class DropdownButtonRucher extends StatefulWidget {
  final List<String> dropdownValues;
  final double dropdownHeight;
  final Etat etat;
  final Context context;
  final List<Map<String, String>> rucherList;

  const DropdownButtonRucher({
    Key? key,
    required this.dropdownValues,
    required this.dropdownHeight,
    required this.etat,
    required this.context,
    required this.rucherList,
  }) : super(key: key);

  @override
  State<DropdownButtonRucher> createState() => _DropdownButtonRucherState();
}

class _DropdownButtonRucherState extends State<DropdownButtonRucher> {
  late String dropdownValue;
  RuchersData ruchersData = RuchersData(adresse: "", description: "", nom: "");
  @override
  void initState() {
    super.initState();
    if(widget.context.idRucher == ""){
      dropdownValue = widget.dropdownValues.first;
    }
    else{
      dropdownValue = ruchersData.getLabelNomRucher(widget.rucherList, widget.context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
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
          onChanged: (String? value) async {
            if (value != null) {
              widget.context.onchangeContext(rucher: await ruchersData.getIdRucherByNomRucher(widget.rucherList, value));
              setState(()  {
                dropdownValue = value;
              });
              widget.etat.onChangeEtat(1);
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
