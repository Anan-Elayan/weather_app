import 'package:carousel_slider/carousel_slider.dart';
import 'package:weather_app/moduls/wather_app/bloc/weather_cubit.dart';
import 'package:weather_app/layout/temp_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BodyScreen extends StatelessWidget {
  const BodyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherCubit, WeatherState>(
      builder: (context, state) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Color(0xFF475366),
                ),
                height: MediaQuery.of(context).size.height / 1.2,
                width: double.infinity,
                child: TemperatureScreen(),
              ),
            ),
          ],
        );
      },
    );
  }
}
