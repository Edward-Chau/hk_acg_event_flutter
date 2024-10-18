import 'package:flutter/material.dart';
import 'package:hk_acg_event_information/Widget/EventListTileCard.dart';
import 'package:hk_acg_event_information/Widget/currentEventCart.dart';
import 'package:hk_acg_event_information/Widget/homeScreenIconWidget.dart';
import 'package:hk_acg_event_information/model/ETAColor.dart';
import 'package:hk_acg_event_information/model/EventModel.dart';

class Homescreen extends StatefulWidget {
  const Homescreen(
      {super.key,
      required this.eventList,
      required this.favoriteEventList,
      required this.keep,
      required this.navigateToEventPage});
  final List<Event> eventList;
  final List<Event> favoriteEventList;
  final Function(Event) keep;
  final void Function() navigateToEventPage;

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  Widget space10 = const SizedBox(height: 10);
  Widget space15 = const SizedBox(height: 15);

  @override
  Widget build(BuildContext context) {
    final currentEventList = widget.eventList.sublist(1, 5); //4 item

    return Scaffold(
      backgroundColor: ETAColors.screenBackgroundColor,
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: const Text('香港動漫資訊'),
        backgroundColor: ETAColors.appbarColors_01,
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            space10,
            const HomeScreenIconWidget(
              icon: Icons.event,
              title: '即將舉辦的活動',
            ),
            EventListtilecard(
                event: widget.eventList[0],
                keep: widget.keep,
                favoriteEventList: widget.favoriteEventList,
                eventList: widget.eventList),
            space10,
            const Divider(indent: 5, endIndent: 5),
            const HomeScreenIconWidget(
              icon: Icons.calendar_month_sharp,
              title: '近期的活動',
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ...currentEventList.map(
                    (toElement) {
                      return CurrentEventCart(
                        event: toElement,
                        eventList: widget.eventList,
                        keep: widget.keep,
                        favoriteEventList: widget.favoriteEventList,
                      );
                    },
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 0),
                        shape: ContinuousRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.blue),
                    onPressed: widget.navigateToEventPage,
                    child: const Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('更多活動'),
                        Icon(Icons.arrow_forward_ios_outlined, size: 15),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const Divider(indent: 5, endIndent: 5),
          ],
        ),
      ),
    );
  }
}
