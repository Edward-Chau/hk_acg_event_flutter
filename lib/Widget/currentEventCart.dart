import 'package:flutter/material.dart';
import 'package:hk_acg_event_information/Screen/informationScreen.dart';

import 'package:hk_acg_event_information/Widget/eventCategoryLabel.dart';
import 'package:hk_acg_event_information/model/EventModel.dart';
import 'package:intl/intl.dart';
import 'package:transparent_image/transparent_image.dart';

var format = DateFormat.yMd();

class CurrentEventCart extends StatelessWidget {
  const CurrentEventCart({
    super.key,
    required this.event,
  });
  final Event event;

  @override
  Widget build(BuildContext context) {
    final String eventTime = format.format(event.dateStart[0]) ==
            format.format(event.dateStart.last)
        ? format.format(event.dateStart[0])
        : '${format.format(event.dateStart[0])} ~ ${format.format(event.dateEnd.last)}';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return Informationscreen(event: event);
              },
            ),
          );
        },
        child: Container(
          width: 180,
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: 100,
                    width: 180,
                    child: FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      image: event.imageURL,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 5,
                    left: 5,
                    child: Eventcategorylabel(event: event),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 3),
                child: Text(
                  event.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 12),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 3),
                    child: Text(
                      format.format(event.dateStart[0]),
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
