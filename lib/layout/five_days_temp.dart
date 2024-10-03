import 'package:flutter/material.dart';
import 'package:weather_app/models/forcast_model.dart';

class ForecastWidget extends StatelessWidget {
  final List<ForecastModel>
      forecastList; // Make sure to define the Forecast model.

  const ForecastWidget({Key? key, required this.forecastList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          '5-Day Forecast',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        forecastList.isNotEmpty
            ? SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: forecastList.map(
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
            : const Center(child: Text("جار التحميل...")),
      ],
    );
  }

  String _getDayName(int weekday) {
    const days = [
      'Sunday',
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday'
    ];
    return days[weekday % 7];
  }
}

class FiveDaysTemp extends StatelessWidget {
  final String temp;
  final String day;

  const FiveDaysTemp({
    Key? key,
    required this.temp,
    required this.day,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10.0,
                  spreadRadius: 2.0,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 50.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.sunny_snowing, color: Colors.black),
                  Text(
                    temp,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Text(
          day,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
