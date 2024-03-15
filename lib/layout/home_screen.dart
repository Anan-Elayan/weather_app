import 'package:weather_app/layout/body_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2f3542),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFF2f3542),
        title: const Text(
          " My Weather",
          textDirection: TextDirection.rtl,
          style: TextStyle(
            color: Colors.lightBlueAccent,
            fontWeight: FontWeight.bold,
            fontSize: 24,
            fontFamily: 'MadimiOneRegular',
          ),
        ),
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle.light
            .copyWith(statusBarColor: Color(0xFF2f3542)),
      ),
      body: BodyScreen(),
    );
  }
}
