import 'package:flutter/material.dart';
import 'package:smart_bee_hive/screen/ruche.dart';
import '../model/etat.dart';
import '../model/date.dart';

class DropdownButtonDate extends StatefulWidget {
  final List<String> dropdownValuesDays;
  final List<String> dropdownValuesMonths;
  final List<String> dropdownValuesYears;
  final double dropdownHeight;
  final DateToShare dateToShare;
  final Etat etat;

  const DropdownButtonDate({
    Key? key,
    required this.dropdownValuesDays,
    required this.dropdownValuesMonths,
    required this.dropdownValuesYears,
    required this.dropdownHeight,
    required this.etat,
    required this.dateToShare,
  }) : super(key: key);

  @override
  State<DropdownButtonDate> createState() => _DropdownButtonDateState();
}

class _DropdownButtonDateState extends State<DropdownButtonDate> {
  String dropdownValueDay = '';
  String dropdownValueMonth = '';
  String dropdownValueYear = '';

  @override
  void initState() {
    super.initState();
    dropdownValueDay = dateToShare.jour.toString();
    dropdownValueMonth = dateToShare.getLabelMois(dateToShare.mois);
    dropdownValueYear = dateToShare.annee.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:MainAxisAlignment.end,
      children: [
        Container(
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
            value: dropdownValueDay,
            isDense: true,
            style: const TextStyle(color: Color(0xFF0F5378)),
            onChanged: (String? value) {
              if (value != null) {
                setState(() {
                  dropdownValueDay = value;
                });
                widget.dateToShare.onChangeDateToDisplay(int.parse(dropdownValueDay),
                    widget.dateToShare.mois, widget.dateToShare.annee, widget.dateToShare.semaine);

                widget.etat.onChangeEtat(widget.etat.etat);
              }
            },
            items: widget.dropdownValuesDays.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),),
        ),
        const SizedBox(width: 10),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: Colors.white,
              width: 2.0,
            ),
          ),
          child: DropdownButtonHideUnderline(
            child :DropdownButton<String>(
            itemHeight: widget.dropdownHeight,
            value: dropdownValueMonth,
            isDense: true,
            style: const TextStyle(color: Color(0xFF0F5378)),
            onChanged: (String? value) {
              if (value != null) {
                setState(() {
                  dropdownValueMonth = value;
                });
                widget.dateToShare.onChangeDateToDisplay(widget.dateToShare.jour,
                    dateToShare.getNumeroMois(dropdownValueMonth), widget.dateToShare.annee, widget.dateToShare.semaine);

                widget.etat.onChangeEtat(widget.etat.etat);
              }
            },
            items: widget.dropdownValuesMonths.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),),
        ),
        const SizedBox(width: 10),
        Container(
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
            value: dropdownValueYear,
            isDense: true,
            style: const TextStyle(color: Color(0xFF0F5378)),
            onChanged: (String? value) {
              if (value != null) {
                setState(() {
                  dropdownValueYear = value;
                });
                widget.dateToShare.onChangeDateToDisplay(widget.dateToShare.jour,
                    widget.dateToShare.mois, int.parse(dropdownValueYear), widget.dateToShare.semaine);

                widget.etat.onChangeEtat(widget.etat.etat);
              }
            },
            items: widget.dropdownValuesYears.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),),
        ),
      ],
    );
  }
}



