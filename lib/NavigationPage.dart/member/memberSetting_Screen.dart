import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
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
            children: [
              SettingCard(
                onClick: () {},
                // hideArror: true,
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: Colors.grey[200],
                      backgroundImage: userProfile.userAvatar != ''
                          ? NetworkImage(userProfile.userAvatar)
                          : null,
                      child: userProfile.userAvatar == ''
                          ? Icon(Icons.person,
                              size: 40, color: Colors.grey[500])
                          : null,
                    ),
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
              Text(userProfile.id),
              Text(userProfile.documentId),
              Text(userProfile.jwt),
              Text(userProfile.userAvatar),
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
