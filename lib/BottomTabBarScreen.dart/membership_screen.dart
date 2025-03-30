import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';

class MembershipScreen extends StatefulWidget {
  const MembershipScreen({super.key});

  @override
  State<MembershipScreen> createState() => _MembershipScreenState();
}

class _MembershipScreenState extends State<MembershipScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('會員中心'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('會員中心', style: Theme.of(context).textTheme.titleLarge),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gap(20),
                    // Text('電郵', style: Theme.of(context).textTheme.labelLarge),
                    // Gap(2),
                    TextFormField(
                      decoration: InputDecoration(labelText: '電郵'),
                    ),
                    Gap(20),
                    // Text('密碼', style: Theme.of(context).textTheme.labelLarge),
                    // Gap(2),
                    TextFormField(
                      decoration: InputDecoration(labelText: '輸入密碼'),
                    ),
                    Gap(15),
                    Center(
                      child: FilledButton(
                        onPressed: () {},
                        child: const Text('登入'),
                      ),
                    ),
                    Gap(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(onTap: () {}, child: Text('新會員')),
                        InkWell(onTap: () {}, child: Text('忘記密碼')),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
