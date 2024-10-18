import 'package:flutter/material.dart';
import 'package:hk_acg_event_information/model/EventModel.dart';

class Eventcategorylabel extends StatelessWidget {
  const Eventcategorylabel({required this.event, super.key});
  final Event event;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: evenCategoryColor[event.evenCategory],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          evenCategoryChineseName[event.evenCategory].toString(),
          style: Theme.of(context)
              .textTheme
              .labelSmall!
              .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
