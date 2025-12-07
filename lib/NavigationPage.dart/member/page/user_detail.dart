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
    GlobalKey _formKey = GlobalKey<FormState>();
    final double bottomInset = MediaQuery.of(context).viewInsets.bottom;

    final TextEditingController usernameController = TextEditingController();

    initState() {
      super.initState();
      final userProfile = ref.read(userProvider);
      usernameController.text = userProfile.username;
    }

    final userProfile = ref.watch(userProvider);
    return Form(
      key: _formKey,
      child: Scaffold(
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
                Gap(20),
                TextFormField(
                  controller: usernameController,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: '用戶名稱',
                    border: const OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
