import 'package:flutter/material.dart';

class UserAvaterWidget extends StatelessWidget {
  const UserAvaterWidget({this.radius, required this.userAvatar, super.key});
  final String userAvatar;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius ?? 28,
      backgroundColor: Colors.grey[200],
      backgroundImage: userAvatar != '' ? NetworkImage(userAvatar) : null,
      child: userAvatar == ''
          ? Icon(Icons.person, size: 40, color: Colors.grey[500])
          : null,
    );
  }
}
