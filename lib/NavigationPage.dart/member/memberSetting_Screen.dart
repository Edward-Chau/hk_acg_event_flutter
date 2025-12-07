import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:hk_acg_event_information/NavigationPage.dart/member/page/user_detail.dart';
import 'package:hk_acg_event_information/NavigationPage.dart/member/user_avater_widget.dart';
import 'package:hk_acg_event_information/Widget/setting_card.dart';
import 'package:hk_acg_event_information/provider/userProvider.dart';

class MembersettingScreen extends ConsumerStatefulWidget {
  const MembersettingScreen({super.key});

  @override
  ConsumerState<MembersettingScreen> createState() =>
      _MembersettingScreenState();
}

class _MembersettingScreenState extends ConsumerState<MembersettingScreen> {
  @override
  Widget build(BuildContext context) {
    final userProfile = ref.watch(userProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('會員中心'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 40),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // for debugging purposes only
              // Text(userProfile.id),
              // Text(userProfile.documentId),
              // Text(userProfile.jwt),
              // Text(userProfile.userAvatar),
              // Text(userProfile.username),
              // Text(userProfile.isLogin.toString()),
              Text('帳號管理'),
              Gap(5),
              SettingCard(
                onClick: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) => const UserDetail(),
                    ),
                  );
                },
                // hideArror: true,
                child: Row(
                  children: [
                    UserAvaterWidget(userAvatar: userProfile.userAvatar),
                    const Gap(10),
                    Expanded(
                      child: Text(
                        userProfile.username,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              Gap(10),
              // 更多
              Text('更多'),
              const Gap(5),
              SettingCard(
                onClick: () {},
                // hideArror: true,
                child: const Text(
                  '私隱政策',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    // color: Colors.red,
                  ),
                ),
              ),
              const Gap(5),
              SettingCard(
                onClick: () {},
                // hideArror: true,
                child: const Text(
                  '聯絡我們',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    // color: Colors.red,
                  ),
                ),
              ),
              const Gap(20),
              SettingCard(
                onClick: () {
                  ref.read(userProvider.notifier).logout();
                },
                // hideArror: true,
                child: const Text(
                  '登出',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
