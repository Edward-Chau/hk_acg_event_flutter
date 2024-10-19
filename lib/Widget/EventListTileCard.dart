import 'package:flutter/material.dart';
import 'package:hk_acg_event_information/Screen/informationScreen.dart';
import 'package:hk_acg_event_information/Widget/eventCategoryLabel.dart';
import 'package:hk_acg_event_information/model/EventModel.dart';
import 'package:intl/intl.dart';
import 'package:transparent_image/transparent_image.dart';

var format = DateFormat.yMd();

class EventListtilecard extends StatefulWidget {
  const EventListtilecard(
      {required this.event,
      super.key,
      required this.keep,
      required this.favoriteEventList,
      required this.eventList,
      required this.pushInformationScreen});
  final Event event;
  final Function(Event) keep;
  final List<Event> favoriteEventList;
  final List<Event> eventList;
  final Function() pushInformationScreen;

  @override
  State<EventListtilecard> createState() => _EventListtilecardState();
}

class _EventListtilecardState extends State<EventListtilecard> {
  @override
  Widget build(BuildContext context) {
    final String eventTime = format.format(widget.event.dateStart[0]) ==
            format.format(widget.event.dateStart.last)
        ? format.format(widget.event.dateStart[0])
        : '${format.format(widget.event.dateStart[0])} ~ ${format.format(widget.event.dateEnd.last)}';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: ListTile(
          onTap: () {
            widget.pushInformationScreen;
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return Informationscreen(
                    pushInformationScreen: widget.pushInformationScreen,
                    event: widget.event,
                    time: eventTime,
                    favoriteEventList: widget.favoriteEventList,
                    keep: widget.keep,
                    eventList: widget.eventList,
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
              widget.favoriteEventList.contains(widget.event)
                  ? const Icon(
                      Icons.favorite,
                      color: Colors.red,
                      size: 20,
                    )
                  : const Text(""), //check if item in favoriteEventList?
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
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        eventTime,
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
