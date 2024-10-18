import 'package:flutter/material.dart';
import 'package:hk_acg_event_information/model/ETAColor.dart';

class Acgnewsscreen extends StatefulWidget {
  const Acgnewsscreen({super.key});

  @override
  State<Acgnewsscreen> createState() => _AcgnewsscreenState();
}

class _AcgnewsscreenState extends State<Acgnewsscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('最新消息'),
        foregroundColor: Colors.white,
        backgroundColor: ETAColors.appbarColors_01,
      ),
      body: Container(
        color: ETAColors.screenBackgroundColor,
      ),
    );
  }
}
