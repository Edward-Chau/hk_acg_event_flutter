import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hk_acg_event_information/Navigation.dart/BottomNavigationTabBar.dart';
import 'package:hk_acg_event_information/model/ETAColor.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // print(evenCategoryChineseName[EvenCategory.acg]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: ETAColors.screenBackgroundColor,
        useMaterial3: true,
        textTheme: const TextTheme().copyWith(
          titleLarge:
              const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        appBarTheme: const AppBarTheme().copyWith(
          foregroundColor: Colors.white,
          backgroundColor: ETAColors.appbarColors_01,
        ),
        inputDecorationTheme: const InputDecorationTheme().copyWith(
          filled: true,
          fillColor: Colors.grey[100],
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: Colors.grey,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: Colors.grey,
              width: 1,
            ),
          ),
          // contentPadding: const EdgeInsets.symmetric(
          //   horizontal: 20,
          //   vertical: 20,
          // ),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            backgroundColor: const Color(0xff1B84FF),
            // padding: EdgeInsets.symmetric(
            //   horizontal: 20,
            //   vertical: 20,
            // ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            textStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),

            // backgroundColor: FingerColor.purple,
          ),
        ),
      ),
      home: const BottomNavigationTabBar(),
    );
  }
}
