import 'package:weather_app/layout/arabic_day_name.dart';
import 'package:weather_app/moduls/wather_app/bloc/weather_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class TemperatureScreen extends StatelessWidget {
  const TemperatureScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = "${now.day}/${now.month}/${now.year}";

    return BlocBuilder<WeatherCubit, WeatherState>(
      builder: (context, state) {
        final weatherState = context.read<WeatherCubit>().state;
        if (weatherState.listMainWeather.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final name = weatherState.nameLocation;
        final temp = weatherState.listMainWeather.first.temp;
        final humidity = weatherState.listMainWeather.first.humidity;
        final temp_min = weatherState.listMainWeather.first.temp_min;
        final temp_max = weatherState.listMainWeather.first.temp_max;

        final description = weatherState.weatherDetails.first.description;
        final icon = weatherState.weatherDetails.first.icon;

        return Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 45,
                  child: ArabicDayName(
                    dayIndex: DateTime.now().weekday - 1,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 25,
                    child: Text(
                      formattedDate,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 70,
              child: Text(
                name,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.white),
              ),
            ),
            SizedBox(
              height: 120,
              child: Transform.scale(
                scale: 2.0,
                alignment: Alignment.center,
                child: Image(
                  image: NetworkImage(
                    'https://openweathermap.org/img/wn/${icon}@2x.png',
                  ),
                ),
              ),
            ),
            Row(
              children: [
                const SizedBox(
                  width: 57,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Icon(
                    Icons.thermostat,
                    color: Colors.redAccent,
                    size: 45,
                  ),
                ),
                SizedBox(
                  height: 60,
                  child: Text(
                    "$temp°C",
                    style: const TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 135,
              child: Text(
                description,
                style: const TextStyle(fontSize: 21, color: Colors.white),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    children: [
                      Text(
                        "$humidity%",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      const Icon(
                        Icons.water_drop,
                        size: 35,
                        color: Colors.blue,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 50, // Adjust height of the line
                  child: VerticalDivider(
                    color: Colors.red,
                    thickness: 2, // Adjust thickness of the line
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    children: [
                      Text(temp_min.toString(),
                          style: const TextStyle(
                              color: Colors.white, fontSize: 20)),
                      const Icon(
                        Icons.arrow_downward_rounded,
                        color: Colors.blue,
                        size: 35,
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 50, // Adjust height of the line
                  child: VerticalDivider(
                    color: Colors.red,
                    thickness: 2, // Adjust thickness of the line
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    children: [
                      Text(temp_max.toString(),
                          style: const TextStyle(
                              color: Colors.white, fontSize: 20)),
                      const Icon(
                        Icons.arrow_outward_rounded,
                        color: Colors.blue,
                        size: 35,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
