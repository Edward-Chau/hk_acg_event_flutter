import 'package:flutter/material.dart';

class Dividerspece extends StatelessWidget {
  const Dividerspece({super.key, required this.dividerTitle});
final String dividerTitle;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          dividerTitle,
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.normal,
              color: Colors.blue[600]),
        ),
        Expanded(
          child: Divider(color: Colors.blue[600], thickness: 1, indent: 10),
        )
      ],
    );
  }
}
