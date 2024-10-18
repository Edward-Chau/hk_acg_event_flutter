import 'package:flutter/material.dart';
import 'package:hk_acg_event_information/Widget/currentEventCart.dart';
import 'package:hk_acg_event_information/model/ETAColor.dart';
import 'package:hk_acg_event_information/model/EventModel.dart';

class Homescreen extends StatefulWidget {
  const Homescreen(
      {super.key,
      required this.eventList,
      required this.favoriteEventList,
      required this.keep});
  final List<Event> eventList;
  final List<Event> favoriteEventList;
  final Function(Event) keep;

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  Widget space10 = const SizedBox(height: 10);
  Widget space15 = const SizedBox(height: 15);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ETAColors.screenBackgroundColor,
      appBar: AppBar(
        title: const Text('香港動漫資訊'),
        backgroundColor: ETAColors.appbarColors_01,
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            space10,
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Row(
                children: [
                  Icon(Icons.calendar_month_sharp),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Text('近期的活動'),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return CurrentEventCart(
                    event: widget.eventList[index],
                    eventList: widget.eventList,
                    keep: widget.keep,
                    favoriteEventList: widget.favoriteEventList,
                  );
                },
              ),
            ),
            // CurrentEventCart(
            //         event: widget.eventList[5],
            //         eventList: widget.eventList,
            //         keep: widget.keep,
            //         favoriteEventList: widget.favoriteEventList,
            //       )
                  
            Text("sss")
           
          ],
        ),
      ),
    );
  }
}
