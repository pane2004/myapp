import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const AutomaticNotchedShape(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          StadiumBorder()),
      notchMargin: 5,
      color: Colors.white,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          const SizedBox(
            width: 70.0,
          ),
          IconButton(
            iconSize: 27.0,
            icon: const Icon(
              Icons.home,
              color: Color(0xFFC5D0DB),
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/about');
            },
          ),
          const SizedBox(
            width: 150.0,
          ),
          IconButton(
            iconSize: 27.0,
            icon: const Icon(
              Icons.document_scanner_rounded,
              color: Color(0xFFC5D0DB),
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/profile');
            },
          ),
          const SizedBox(
            width: 70.0,
          ),
        ],
      ),
    );
  }
}
