import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:weather_app/layout/body_screen.dart';
import 'package:weather_app/moduls/wather_app/bloc/weather_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    _checkLocationPermission();
  }

  Future<void> _checkLocationPermission() async {
    PermissionStatus status = await Permission.location.status;

    if (status.isDenied) {
      _showLocationPermissionDialog();
    } else if (status.isGranted) {
      _fetchWeatherData();
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  void _showLocationPermissionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('مطلوب إذن الموقع'),
          content: const Text(
              'يتطلب هذا التطبيق الوصول إلى موقعك. يرجى السماح بالوصول للمتابعة.'),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await _requestLocationPermission();
              },
              child: const Text('سماح'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('إلغاء'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _requestLocationPermission() async {
    PermissionStatus status = await Permission.location.request();

    if (status.isGranted) {
      _fetchWeatherData();
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  void _fetchWeatherData() {
    context.read<WeatherCubit>().fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2f3542),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF2f3542),
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
            .copyWith(statusBarColor: const Color(0xFF2f3542)),
      ),
      body: const BodyScreen(),
    );
  }
}
