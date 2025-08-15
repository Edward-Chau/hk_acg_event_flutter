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
  String formatDateWithWeekday(DateTime date) {
    final weekdays = ['日', '一', '二', '三', '四', '五', '六'];
    return '${DateFormat('dd/MM/yyyy').format(date)}(${weekdays[date.weekday % 7]})';
  }

  String eventTime(List<EventTime> eventTime) {
    if (eventTime.isEmpty) {
      return '';
    }

    if (eventTime.length == 1) {
      return formatDateWithWeekday(eventTime[0].startTime);
    }

    return '${formatDateWithWeekday(eventTime[0].startTime)} ~ ${formatDateWithWeekday(eventTime[eventTime.length - 1].endTime)}';
  }

  @override
  Widget build(BuildContext context) {
    final List<String> keepList = ref.watch(keepEventProviderProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: ListTile(
          titleAlignment: ListTileTitleAlignment.top,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return Informationscreen(event: widget.event);
                },
              ),
            );
          },
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Eventcategorylabel(event: widget.event), //label
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  widget.event.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),

              if (keepList.contains(widget.event.documentId))
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
                Container(
                  decoration: BoxDecoration(color: Colors.grey[400]),
                  width: 100,
                  height: 100,
                  child: widget.event.image.isEmpty
                      ? const Center(
                          child: Text(
                            '沒有活動圖片',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      : FadeInImage.memoryNetwork(
                          placeholder: kTransparentImage,
                          image: widget.event.image.isNotEmpty
                              ? widget.event.image[0]
                              : '',
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
                        widget.event.location,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        eventTime(widget.event.eventTimes),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.blue[700]),
                      ),

                      // Text('門票: \$${widget.event.ticket}'),
                      if (widget.event.organizer != '')
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Text('主辦單位: ${widget.event.organizer}'),
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
