import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:hk_acg_event_information/NavigationPage.dart/member/user_avater_widget.dart';
import 'package:hk_acg_event_information/provider/userProvider.dart';

class UserDetail extends ConsumerStatefulWidget {
  const UserDetail({super.key});

  @override
  ConsumerState<UserDetail> createState() => _UserDetailState();
}

class _UserDetailState extends ConsumerState<UserDetail> {
  void editUserAvater() {}

  @override
  Widget build(BuildContext context) {
    final double bottomInset = MediaQuery.of(context).viewInsets.bottom;

    final userProfile = ref.watch(userProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('個人資料'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  UserAvaterWidget(
                    radius: 60,
                    userAvatar: userProfile.userAvatar,
                  ),
                ],
              ),
              const Gap(10),
              FilledButton(
                onPressed: editUserAvater,
                child: const Text('更換頭像'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
