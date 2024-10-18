import 'package:flutter/material.dart';

class HomeScreenIconWidget extends StatelessWidget {
  const HomeScreenIconWidget(
      {super.key, required this.icon, required this.title});
  final IconData icon;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Icon(icon),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Text(title),
          ),
        ],
      ),
    );
  }
}
