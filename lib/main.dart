import 'package:flutter/material.dart';
import 'package:register_form_flutter/pages/register_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Register Pgage',
      home: RegisterPage(),
    );
  }
}


