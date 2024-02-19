import 'package:flutter/material.dart';
import 'package:the_tech_brother_api/screens/post_api_screen.dart';
import 'package:the_tech_brother_api/screens/user_api_screen.dart';
import 'package:the_tech_brother_api/screens/without_model_user_api_procedure_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const WithOutModelUserAPIProcedureScreen(),
    );
  }
}
