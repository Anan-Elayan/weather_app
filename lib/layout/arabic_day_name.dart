import 'package:flutter/material.dart';

class ArabicDayName extends StatelessWidget {
  final int dayIndex;
  final TextStyle style;

  ArabicDayName({required this.dayIndex, required this.style});

  @override
  Widget build(BuildContext context) {
    List<String> arabicDayNames = [
      'الاثنين',
      'الثلاثاء',
      'الأربعاء',
      'الخميس',
      'الجمعة',
      'السبت',
      'الأحد',
    ];

    int dayIndex = DateTime.now().weekday - 1;

    return Text(
      arabicDayNames[dayIndex],
      style: style,
    );
  }
}
