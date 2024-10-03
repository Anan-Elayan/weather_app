import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:weather_app/models/main_model.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/shared/network/remote/result_api.dart';
import 'package:weather_app/shared/network/remote/weather_api.dart';

import '../../../models/forcast_model.dart';

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
        Map<String, dynamic> data = jsonDecode(resultApi.resultOrError);

        String name = data['name'];

        return ResultApi(isDone: true, resultOrError: name);
      } else {
        return resultApi;
      }
    } else {
      return ResultApi(
        isDone: false,
        resultOrError: 'لا يوجد اتصال بالإنترنت',
      );
    }
  }

  Future<ResultApi> getMainData() async {
    final connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult != ConnectivityResult.none) {
      ResultApi resultApi = await weatherApi.getWeather();

      if (resultApi.isDone) {
        Map<String, dynamic> responseData = jsonDecode(resultApi.resultOrError);
        Map<String, dynamic> mainData = responseData['main'];

        double tempValue = (mainData['temp'] as num).toDouble();
        double temp_min = (mainData['temp_min'] as num).toDouble();
        double temp_max = (mainData['temp_max'] as num).toDouble();
        int pressure = mainData['pressure'] as int;
        int humidity = mainData['humidity'] as int;

        MainModelWeather mainModelWeather = MainModelWeather(
          temp: tempValue,
          humidity: humidity,
          pressure: pressure,
          temp_min: temp_min,
          temp_max: temp_max,
        );

        list.add(mainModelWeather);
        return ResultApi(isDone: true, resultOrError: list);
      } else {
        return resultApi;
      }
    } else {
      return ResultApi(
        isDone: false,
        resultOrError: 'لا يوجد اتصال بالإنترنت',
      );
    }
  }

  Future<ResultApi> getFiveDayForecast() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none) {
      ResultApi resultApi = await weatherApi.getFiveDayForecast();
      if (resultApi.isDone) {
        Map<String, dynamic> responseData = jsonDecode(resultApi.resultOrError);
        print(responseData);
        List<dynamic> forecastData = responseData['list'];
        List<ForecastModel> forecasts = forecastData.map((forecast) {
          return ForecastModel.fromJson(forecast);
        }).toList();

        return ResultApi(isDone: true, resultOrError: forecasts);
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
        resultOrError: 'لا يوجد اتصال بالإنترنت',
      );
    }
  }
}
