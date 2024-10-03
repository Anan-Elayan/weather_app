import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/layout/home_screen.dart';
import 'package:weather_app/moduls/wather_app/bloc/weather_cubit.dart';
import 'package:weather_app/shared/network/remote/weather_api.dart';
import 'package:weather_app/shared/network/remote/weather_api_repository.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WeatherCubit(
          weatherApiRepository: WeatherApiRepository(weatherApi: WeatherApi())),
      child: MaterialApp(
        title: 'Weather App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        builder: DevicePreview.appBuilder,
        useInheritedMediaQuery: true,
        locale: DevicePreview.locale(context),
        home: const HomeScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
