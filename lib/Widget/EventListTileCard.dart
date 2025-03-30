import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hk_acg_event_information/Screen/informationScreen.dart';
import 'package:hk_acg_event_information/Widget/eventCategoryLabel.dart';
import 'package:hk_acg_event_information/model/EventModel.dart';
import 'package:hk_acg_event_information/provider/keep_event_provider.dart';
import 'package:intl/intl.dart';
import 'package:transparent_image/transparent_image.dart';

var format = DateFormat.yMd();

class EventListtilecard extends ConsumerStatefulWidget {
  const EventListtilecard({
    required this.event,
    super.key,
  });
  final Event event;

  @override
  ConsumerState<EventListtilecard> createState() => _EventListtilecardState();
}

class _EventListtilecardState extends ConsumerState<EventListtilecard> {
  @override
  Widget build(BuildContext context) {
    final List<int> keepList = ref.watch(keepEventProviderProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: ListTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return Informationscreen(
                    event: widget.event,
                  );
                },
              ),
            );
          },
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Eventcategorylabel(event: widget.event), //label
              const SizedBox(width: 8),
              Text(
                widget.event.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              if (keepList.contains(widget.event.id))
                const Icon(
                  Icons.favorite,
                  color: Colors.red,
                  size: 20,
                )
            ],
          ),
          subtitle: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                SizedBox(
                  width: 100,
                  height: 100,
                  child: FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: widget.event.imageURL,
                    fit: BoxFit.cover,
                    imageErrorBuilder: (context, error, stackTrace) =>
                        const Center(
                      child: Text('error'),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'eventTime wip',
                        style: TextStyle(color: Colors.blue[700]),
                      ),
                      Text(
                        widget.event.location,
                      ),
                      Text('門票: \$${widget.event.ticket}'),
                      Text(
                        '主辦單位: ${widget.event.organizer}',
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
