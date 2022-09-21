import 'package:flutter/material.dart';
import 'package:open_weather/init_widget.dart';
import 'package:open_weather/models/theme.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: themeData,
      home: InitWidget(),
    );
  }
}
