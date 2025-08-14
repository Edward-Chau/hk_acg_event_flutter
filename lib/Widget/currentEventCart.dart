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
    final List<String> keepList = ref.watch(keepEventProviderProvider);
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
                  Container(
                    decoration: BoxDecoration(color: Colors.grey[400]),
                    height: 100,
                    width: 180,
                    child: event.image.isEmpty
                        ? const Center(
                            child: Text(
                              '沒有活動圖片',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        : FadeInImage.memoryNetwork(
                            placeholder: kTransparentImage,
                            image: event.image.isNotEmpty ? event.image[0] : '',
                            fit: BoxFit.cover,
                            imageErrorBuilder: (context, error, stackTrace) =>
                                const Center(
                              child: Text('圖片發生錯誤'),
                            ),
                          ),
                  ),
                  Positioned(
                    top: 5,
                    left: 5,
                    child: Eventcategorylabel(event: event),
                  ),
                  if (keepList.contains(event.documentId))
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
