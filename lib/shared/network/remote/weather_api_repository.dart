import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:weather_app/models/main_model.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/shared/network/remote/result_api.dart';
import 'package:weather_app/shared/network/remote/weather_api.dart';

class WeatherApiRepository {
  final WeatherApi weatherApi;

  WeatherApiRepository({required this.weatherApi});
  List<MainModelWeather> list = [];
  List<WeatherModel> weatherMdelList = [];

  Future<ResultApi> getLocation() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none) {
      ResultApi resultApi = await weatherApi.getWeather();
      if (resultApi.isDone) {
        print("rrr");
        Map<String, dynamic> data = jsonDecode(resultApi.resultOrError);
        print('${data.length}lenght1');

        String name = data['name'];
        print(name);

        return ResultApi(isDone: true, resultOrError: name);
      } else {
        return resultApi;
      }
    } else {
      return ResultApi(
        isDone: false,
        resultOrError: 'No internet access',
      );
    }
  }

  Future<ResultApi> getMainData() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    print('oooooooo');
    if (connectivityResult != ConnectivityResult.none) {
      ResultApi resultApi = await weatherApi.getWeather();
      print('ppppp');
      if (resultApi.isDone) {
        print('gggg');
        Map<String, dynamic> responseData = jsonDecode(resultApi.resultOrError);
        print('${responseData.length}lenght');
        Map<String, dynamic> mainData = responseData['main'];
        for (int i = 0; i < mainData.length; i++) {
          print('${mainData[i]}main data');
        }
        double tempValue = mainData['temp'];
        print(tempValue);
        double temp = mainData['temp'];
        double temp_min = mainData['temp_min'];
        double temp_max = mainData['temp_max'];
        int pressure = mainData['pressure'];
        int humidity = mainData['humidity'];
        print('Temperature: $temp');
        print(temp);
        print(temp_min);
        print(temp_max);
        print(pressure);
        print(humidity);

        MainModelWeather mainModelWeather = MainModelWeather(
            temp: temp,
            humidity: humidity,
            pressure: pressure,
            temp_min: temp_min,
            temp_max: temp_max);

        list.add(mainModelWeather);
        print('${list.length}----------------');
        return ResultApi(isDone: true, resultOrError: list);
      } else {
        return resultApi;
      }
    } else {
      return ResultApi(
        isDone: false,
        resultOrError: 'No internet access',
      );
    }
  }

  Future<ResultApi> getWeatherDetails() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none) {
      ResultApi resultApi = await weatherApi.getWeather();
      if (resultApi.isDone) {
        Map<String, dynamic> responseData = jsonDecode(resultApi.resultOrError);
        List<dynamic> weatherData = responseData['weather'];
        List<WeatherModel> weatherDetails = weatherData.map((weather) {
          return WeatherModel(
            id: weather['id'],
            main: weather['main'],
            description: weather['description'],
            icon: weather['icon'],
          );
        }).toList();
        return ResultApi(isDone: true, resultOrError: weatherDetails);
      } else {
        return resultApi;
      }
    } else {
      return ResultApi(
        isDone: false,
        resultOrError: 'No internet access',
      );
    }
  }
}
