import 'package:flutter/material.dart';
import 'package:myapp/details.dart';
import 'package:myapp/home_page.dart'; // Ma
import 'package:myapp/navbar.dart';
import 'package:myapp/util/qtybox.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false, // ✅ Remove debug banner
      theme: ThemeData(
        useMaterial3: true, // ✅ Use Material 3
        fontFamily: 'Roboto', // ✅ Apply custom font
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontWeight: FontWeight.w900),
          displayMedium: TextStyle(fontWeight: FontWeight.w700),
          bodyLarge: TextStyle(fontWeight: FontWeight.w500),
          bodyMedium: TextStyle(fontWeight: FontWeight.w300),
          bodySmall: TextStyle(fontWeight: FontWeight.w200),
        ),
      ),
      home: Nav(), // ✅ Use the correct homepage widget
    );
  }
}
