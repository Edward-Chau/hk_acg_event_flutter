import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hk_acg_event_information/Navigation.dart/BottomNavigationTabBar.dart';

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
        useMaterial3: true,
        textTheme: const TextTheme().copyWith(
          titleLarge:
              const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      home: const BottomNavigationTabBar(),
    );
  }
}

// void main() {
//   runApp(App());
// }

// class App extends StatelessWidget {
//   App({super.key});

//   final theme = ThemeData(
//     useMaterial3: true,
//     colorScheme: ColorScheme.fromSeed(
//       brightness: Brightness.dark,
//       seedColor: const Color.fromARGB(255, 131, 57, 0),
//     ),
//     textTheme: GoogleFonts.latoTextTheme(),
//   );

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: theme,
//       home: const Scaffold(
//         // body: CategoriesScreen(),
//         body: Tabs(),
//       ),
//     );
//   }
// }
