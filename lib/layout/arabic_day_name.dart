import 'package:flutter/material.dart';

class ArabicDayName extends StatelessWidget {
  final int dayIndex;
  final TextStyle style;

  ArabicDayName({required this.dayIndex, required this.style});

  @override
  Widget build(BuildContext context) {
    List<String> arabicDayNames = [
      'السبت', 
      'الأحد', 
      'الاثنين', 
      'الثلاثاء', 
      'الأربعاء', 
      'الخميس', 
      'الجمعة', 
    ];

    return Text(
      arabicDayNames[dayIndex],
      style: style,
    );
  }
}