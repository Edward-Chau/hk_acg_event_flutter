import 'package:flutter/material.dart';

class SettingCard extends StatelessWidget {
  const SettingCard(
      {required this.child, this.hideArror = false, this.onClick, super.key});
  final Widget child;
  final bool hideArror;
  final Function()? onClick;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Expanded(child: child),
              if (!hideArror)
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 8,
                )
            ],
          ),
        ),
      ),
    );
  }
}
