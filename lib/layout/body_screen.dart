import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/layout/temp_screen.dart';
import 'package:weather_app/moduls/wather_app/bloc/weather_cubit.dart';

import 'five_days_temp.dart';

class BodyScreen extends StatelessWidget {
  const BodyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherCubit, WeatherState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: const Color(0xFF475366),
                  ),
                  height: MediaQuery.of(context).size.height / 1.561,
                  width: double.infinity,
                  child: const TemperatureScreen(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "درجة الحرارة لخمس ايام تحديث كل 6/ساعات",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
              state.forecastList.isNotEmpty
                  ? SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: state.forecastList.map(
                          (forecast) {
                            final date = DateTime.parse(forecast.dateTime);
                            final dayName = _getDayName(date.weekday);

                            return FiveDaysTemp(
                              temp: "${forecast.temp.toStringAsFixed(1)}°C",
                              day: dayName,
                            );
                          },
                        ).toList(),
                      ),
                    )
                  : const Center(
                      child: Text(
                        "جار التحميل...",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
            ],
          ),
        );
      },
    );
  }

  String _getDayName(int weekday) {
    switch (weekday) {
      case 1:
        return 'الأثنين';
      case 2:
        return 'الثلاثاء';
      case 3:
        return 'الأربعاء';
      case 4:
        return 'الخميس';
      case 5:
        return 'الجمعة';
      case 6:
        return 'السبت';
      case 7:
        return 'الأحد';
      default:
        return '';
    }
  }
}
