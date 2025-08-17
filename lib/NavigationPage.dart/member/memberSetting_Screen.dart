import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SettingCard(
                onClick: () {},
                hideArror: true,
                child: Row(
                  children: [
                    Text(
                      userProfile.username,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              Text(userProfile.id),
              Text(userProfile.documentId),
              Text(userProfile.jwt),
              Text(userProfile.usericon),
              Text(userProfile.username),
              Text(userProfile.isLogin.toString()),
              SettingCard(
                onClick: () {
                  ref.read(userProvider.notifier).logout();
                },
                hideArror: true,
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
