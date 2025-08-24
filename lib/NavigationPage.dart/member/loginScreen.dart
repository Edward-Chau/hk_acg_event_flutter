import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:hk_acg_event_information/provider/userProvider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();
  final TextEditingController confirmPasswordTextController =
      TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool newMember = false;
  bool isLoading = false;
  String? errorMessage;

  Future<void> submit() async {
    if (!formKey.currentState!.validate()) return;
    setState(() {
      errorMessage = null;
      isLoading = true;
    });

    try {
      if (newMember) {
        //register
        await ref.read(userProvider.notifier).register(
              emailTextController.text,
              passwordTextController.text,
            );
      } else {
        //login
        await ref.read(userProvider.notifier).login(
              emailTextController.text,
              passwordTextController.text,
            );
      }
    } catch (e) {
      setState(() {
        errorMessage = e.toString().replaceFirst("Exception: ", "");
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final double bottomInset = MediaQuery.of(context).viewInsets.bottom;
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
              child: Padding(
                padding: EdgeInsets.only(bottom: bottomInset),
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
                          controller: passwordTextController,
                          obscureText: true,
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.trim() == '' ||
                                value.length < 6) {
                              return '請輸入密碼';
                            } else if ((passwordTextController.text !=
                                    confirmPasswordTextController.text) &&
                                newMember) {
                              return '密碼不一致';
                            } else {
                              return null;
                            }
                          },
                          decoration: const InputDecoration(labelText: '密碼'),
                        ),

                        if (newMember)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: TextFormField(
                              controller: confirmPasswordTextController,
                              obscureText: true,
                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    value.trim() == '') {
                                  return '請再次輸入密碼';
                                } else if (value !=
                                    passwordTextController.text) {
                                  return '兩次輸入的密碼不一致';
                                }
                                return null;
                              },
                              decoration:
                                  const InputDecoration(labelText: '確認密碼'),
                            ),
                          ),
                        if (errorMessage != null)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Center(
                              child: Text(
                                errorMessage!,
                                style: const TextStyle(color: Colors.red),
                              ),
                            ),
                          ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Center(
                            child: FilledButton(
                              onPressed: submit,
                              child: Text(newMember ? '註冊' : '登入'),
                            ),
                          ),
                        ),

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
      ),
    );
  }
}
