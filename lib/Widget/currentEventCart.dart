import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hk_acg_event_information/Screen/informationScreen.dart';

import 'package:hk_acg_event_information/Widget/eventCategoryLabel.dart';
import 'package:hk_acg_event_information/model/EventModel.dart';
import 'package:hk_acg_event_information/provider/keep_event_provider.dart';
import 'package:intl/intl.dart';
import 'package:transparent_image/transparent_image.dart';

var format = DateFormat.yMd();

class CurrentEventCart extends ConsumerWidget {
  const CurrentEventCart({
    super.key,
    required this.event,
  });
  final Event event;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<int> keepList = ref.watch(keepEventProviderProvider);
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
                      imageErrorBuilder: (context, error, stackTrace) =>
                          const Center(
                        child: Text('error'),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 5,
                    left: 5,
                    child: Eventcategorylabel(event: event),
                  ),
                  if (keepList.contains(event.id))
                    const Positioned(
                      top: 5,
                      right: 5,
                      child: Icon(
                        Icons.favorite,
                        size: 24,
                        color: Colors.red,
                      ),
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
                      'WIP',
                      // format.format(event.dateStart[0]),
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
