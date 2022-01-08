import 'package:flutter/material.dart';

class ToolItem extends StatelessWidget {
  final String tool;
  final String title;
  const ToolItem({Key? key, required this.tool, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/$tool');
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 3,
            child: SizedBox(
              child: Image.asset(
                'assets/topics/$tool.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
          Text(title,
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
