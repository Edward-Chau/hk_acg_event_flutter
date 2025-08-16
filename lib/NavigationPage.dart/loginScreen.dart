import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();
  final TextEditingController confirmPasswordTextController =
      TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool newMember = false;

  submit() {
    if (!formKey.currentState!.validate()) return;

    print(emailTextController.text);
    print(passwordTextController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('會員中心'),
      ),
      body: Form(
        key: formKey,
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(newMember ? '註冊新會員' : '會員中心',
                      style: Theme.of(context).textTheme.titleLarge),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Gap(20),
                      // Text('電郵', style: Theme.of(context).textTheme.labelLarge),
                      // Gap(2),
                      TextFormField(
                        controller: emailTextController,
                        decoration: const InputDecoration(labelText: '電郵'),
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.trim() == '' ||
                              !value.contains('@') ||
                              value.length < 6) {
                            return '請輸入電郵';
                          }
                          return null;
                        },
                      ),
                      const Gap(20),
                      // Text('密碼', style: Theme.of(context).textTheme.labelLarge),
                      // Gap(2),
                      TextFormField(
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.trim() == '' ||
                              value.length < 6) {
                            return '請輸入密碼';
                          } else if (passwordTextController.text !=
                              confirmPasswordTextController.text) {
                            return '密碼不一致';
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(labelText: '密碼'),
                      ),
                      const Gap(15),
                      if (newMember)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: TextFormField(
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value.trim() == '' ||
                                  value.length < 6) {
                                return '請輸入密碼';
                              } else if (passwordTextController.text !=
                                  confirmPasswordTextController.text) {
                                return '密碼不一致';
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(labelText: '確認密碼'),
                          ),
                        ),
                      Center(
                        child: FilledButton(
                          onPressed: submit,
                          child: Text(newMember ? '註冊' : '登入'),
                        ),
                      ),
                      const Gap(20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                              onTap: () {
                                setState(() {
                                  newMember = !newMember;
                                });
                              },
                              child: Text(newMember ? '登入會員' : '新會員')),
                          InkWell(
                            onTap: () {},
                            child: const Text('忘記密碼'),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
