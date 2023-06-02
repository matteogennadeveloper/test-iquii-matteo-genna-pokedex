import 'package:flutter/material.dart';

import '../screens/pokemon_details_screen.dart';

class DetailButton extends StatelessWidget {
  VoidCallback action;
  bool selected;
  Color primaryColor;
  SelectedDetails detail;

  DetailButton(
      {required this.selected,
      required this.primaryColor,
      required this.detail,
      required this.action});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: selected ? 2 : 1,
      child: AnimatedScale(
        duration: Duration(milliseconds: 300),
        scale: selected ? 1 : 0.8,
        curve: Curves.easeIn,
        child: OutlinedButton(
          onPressed: action,
          child: Text(
            detail.getLabel(),
            style: TextStyle(
                color:
                    selected ? primaryColor : Colors.black),
          ),
          style: ButtonStyle(
              elevation: MaterialStateProperty.all(selected ? 10 : 1),
              backgroundColor: MaterialStateProperty.all(
                  selected ? Colors.white : Colors.grey)),
        ),
      ),
    );
  }
}
