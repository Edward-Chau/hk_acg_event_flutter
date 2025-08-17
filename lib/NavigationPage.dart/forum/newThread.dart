import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Newthread extends StatefulWidget {
  const Newthread({super.key});

  @override
  State<Newthread> createState() => _NewthreadState();
}

class _NewthreadState extends State<Newthread> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('new'),
    );
  }
}
