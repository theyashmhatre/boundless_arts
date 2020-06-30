import 'package:boundless_arts/screens/home_screen.dart';
import 'package:boundless_arts/services/routing_service.dart';
import 'package:flutter/material.dart';
import 'package:boundless_arts/util/size_util.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: RoutingService(),
    );
  }
}
