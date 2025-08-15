import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hk_acg_event_information/Screen/favouriteScreen.dart';
import 'package:hk_acg_event_information/Widget/EventListTileCard.dart';
import 'package:hk_acg_event_information/Widget/currentEventCart.dart';
import 'package:hk_acg_event_information/Widget/homeScreenIconWidget.dart';
import 'package:hk_acg_event_information/model/EventModel.dart';
import 'package:hk_acg_event_information/provider/event_list_provider.dart';
import 'package:hk_acg_event_information/provider/pageNavigation_provider.dart';

class Homescreen extends ConsumerStatefulWidget {
  const Homescreen({
    super.key,
  });

  @override
  ConsumerState<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends ConsumerState<Homescreen> {
  Widget space10 = const SizedBox(height: 10);
  Widget space15 = const SizedBox(height: 15);

  @override
  Widget build(BuildContext context) {
    final eventList = ref.watch(eventProvider);

    return Scaffold(
        appBar: AppBar(
          title: const Text('香港動漫資訊'),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const FavouriteScreen();
                    },
                  ),
                );
              },
              icon: const Icon(
                Icons.bookmark,
              ),
            ),
            // IconButton(onPressed: () {}, icon: const Icon(Icons.notifications))
          ],
        ),
        body: eventList.when(
          data: (eventsLists) {
            final List<Event> currentEventList = eventsLists.length < 5
                ? eventsLists
                : eventsLists.sublist(1, 5); //4 item
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              child: RefreshIndicator(
                onRefresh: () async {
                  final bool refreshIsSuccess =
                      await ref.read(eventProvider.notifier).updateEventList();

                  if (refreshIsSuccess) {
                    print('refresh is success');
                    HapticFeedback.mediumImpact();
                  }
                },
                child: ListView(
                  children: [
                    space10,
                    const HomeScreenIconWidget(
                      icon: Icons.event,
                      title: '即將舉辦的活動',
                    ),
                    eventsLists.isEmpty
                        ? const Row(
                            children: [
                              Expanded(
                                child: Text(
                                  '沒有即將舉辦的活動',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          )
                        : EventListtilecard(event: eventsLists[0]),
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
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 5),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 0),
                                shape: ContinuousRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.blue),
                            onPressed: () {
                              ref
                                  .read(pageNavigationProvider.notifier)
                                  .onPageChage(1);
                            },
                            child: const Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('更多活動'),
                                Icon(Icons.arrow_forward_ios_outlined,
                                    size: 15),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Divider(indent: 5, endIndent: 5),
                    const HomeScreenIconWidget(
                      icon: Icons.local_fire_department_outlined,
                      title: '熱門討論',
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
                      children: [],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 5),
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
                                Text('更多討論'),
                                Icon(Icons.arrow_forward_ios_outlined,
                                    size: 15),
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
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, _) => Text('發生錯誤: $err'),
        ));
  }
}
