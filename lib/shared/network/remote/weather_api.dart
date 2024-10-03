import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/shared/network/remote/result_api.dart';
import 'package:weather_app/shared/network/remote/string.dart';

class WeatherApi {
  Future<ResultApi> getWeather() async {
    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    try {
      Uri url = Uri.https('api.openweathermap.org', '/data/2.5/weather', {
        'lat': position.latitude.toString(),
        'lon': position.longitude.toString(),
        'lang': 'ar',
        'units': ''.units,
        'appid': ''.getApiKey,
      });
      var response = await http.get(url);
      var dataDecoded = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return ResultApi(isDone: true, resultOrError: response.body);
      } else {
        return ResultApi(
            isDone: false, resultOrError: 'Some Error According in server');
      }
    } catch (e) {
      return ResultApi(isDone: false, resultOrError: 'Some Error accord');
    }
  }

  Future<String> getLatitude() async {
    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    double latitude = position.latitude;
    return latitude.toString();
  }

  Future<ResultApi> getFiveDayForecast() async {
    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    try {
      Uri url = Uri.https('api.openweathermap.org', '/data/2.5/forecast', {
        'lat': position.latitude.toString(),
        'lon': position.longitude.toString(),
        'units': ''.units,
        'appid': ''.getApiKey,
      });
      var response = await http.get(url);
      var dataDecoded = jsonDecode(response.body);
      print(url);
      print(response);

      if (response.statusCode == 200) {
        return ResultApi(isDone: true, resultOrError: response.body);
      } else {
        return ResultApi(
            isDone: false, resultOrError: 'Some Error According in server');
      }
    } catch (e) {
      return ResultApi(isDone: false, resultOrError: 'Some Error accord');
    }
  }
}
