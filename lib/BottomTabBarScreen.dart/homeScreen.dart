import 'package:flutter/material.dart';
import 'package:hk_acg_event_information/Widget/DoujinshiCard.dart';
import 'package:hk_acg_event_information/Widget/EventListTileCard.dart';
import 'package:hk_acg_event_information/Widget/currentEventCart.dart';
import 'package:hk_acg_event_information/Widget/homeScreenIconWidget.dart';
import 'package:hk_acg_event_information/model/DoujinshiModel.dart';
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

  Doujinshimodel doujinshimodel_01 = Doujinshimodel(
    bookURL: 'https://forum.gamer.com.tw/Co.php?bsn=43473&sn=91071',
    bookName: 'bookName',
    imageUrl:
        'https://live.staticflickr.com/65535/54068555853_3ebba331f4_o.png',
    summary: [
      '以長夢與對巨人結局的理解與感情為主題的衍生創作。',
      '~本篇34頁漫畫完稿版已全公開~',
      '現階段離實體本完工還有段距離，歡迎大家可以先讀看看內容',
      '※實體本預購相關事宜會在封面跟插圖一切都弄好準備送印的階段才開始。',
    ],
    information: BookInformation(
      pages: 38,
      date: DateTime(2024, 10, 15),
    ),
    animename: '進撃的巨人',
  );

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
        child: SingleChildScrollView(
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
              Scrollbar(
                child: SingleChildScrollView(
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
              const HomeScreenIconWidget(
                icon: Icons.collections_bookmark_outlined,
                title: '最新登錄同人誌',
              ),
              space10,
              GridView.count(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                childAspectRatio: 2 / 3,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                shrinkWrap: true,
                primary: false,
                crossAxisCount: 3,
                children: [
                  Doujinshicard(doujinshi: doujinshimodel_01),
                  Doujinshicard(doujinshi: doujinshimodel_01),
                  Doujinshicard(doujinshi: doujinshimodel_01),
                  Doujinshicard(doujinshi: doujinshimodel_01),
                  Doujinshicard(doujinshi: doujinshimodel_01),
                  Doujinshicard(doujinshi: doujinshimodel_01),
                ],
              ),

              // Wrap(
              //   children: [
              //     Doujinshicard(doujinshi: doujinshimodel_01),
              //     Doujinshicard(doujinshi: doujinshimodel_01),
              //     Doujinshicard(doujinshi: doujinshimodel_01),
              //     Doujinshicard(doujinshi: doujinshimodel_01),
              //     Doujinshicard(doujinshi: doujinshimodel_01),
              //     Doujinshicard(doujinshi: doujinshimodel_01),

              //   ],
              // ),

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
                      onPressed: () {},
                      child: const Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('更多同人誌'),
                          Icon(Icons.arrow_forward_ios_outlined, size: 15),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(indent: 5, endIndent: 5),
              space15
            ],
          ),
        ),
      ),
    );
  }
}
