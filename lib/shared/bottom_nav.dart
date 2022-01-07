import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class IconBottomButton extends StatelessWidget {
  final IconData icon;
  final bool selected;
  final Function() onPressed;
  const IconBottomButton(
      {required this.icon,
      required this.selected,
      required this.onPressed,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: 27.0,
      icon: Icon(icon,
          color: selected ? const Color(0xFF84C879) : const Color(0xFFC5D0DB)),
      onPressed: onPressed,
    );
  }
}

      // onPressed: () {
      //   Navigator.pushNamed(context, '/');
      // },
