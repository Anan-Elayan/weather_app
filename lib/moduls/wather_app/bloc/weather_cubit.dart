import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app/models/main_model.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/shared/network/remote/result_api.dart';

import '../../../models/forcast_model.dart';
import '../../../shared/network/remote/weather_api_repository.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final WeatherApiRepository weatherApiRepository;

  WeatherCubit({required this.weatherApiRepository})
      : super(const WeatherState());

  Future<void> fetchWeather() async {
    await getLocation();
    await getMainData();
    await getWeatherDetails();
    await getFiveDayForecast();
  }

  Future<void> getLocation() async {
    final ResultApi resultApi = await weatherApiRepository.getLocation();
    if (resultApi.isDone) {
      String name = resultApi.resultOrError;
      emit(
        state.copyWith(nameLocation: name, error: ''),
      );
    }
  }

  Future<void> getFiveDayForecast() async {
    final ResultApi resultApi = await weatherApiRepository.getFiveDayForecast();
    if (resultApi.isDone) {
      List<ForecastModel> forecasts = List.from(
        resultApi.resultOrError,
      );
      emit(state.copyWith(forecastList: forecasts, error: ''));
    } else {
      emit(state.copyWith(error: resultApi.resultOrError));
    }
  }

  Future<void> getMainData() async {
    final ResultApi resultApi = await weatherApiRepository.getMainData();
    if (resultApi.isDone) {
      List<MainModelWeather> mainWeatherList =
          List.from(resultApi.resultOrError);
      emit(state.copyWith(error: '', listMainWeather: mainWeatherList));
    } else {
      emit(state.copyWith(error: resultApi.resultOrError));
    }
  }

  Future<void> getWeatherDetails() async {
    final ResultApi resultApi = await weatherApiRepository.getWeatherDetails();
    if (resultApi.isDone) {
      List<WeatherModel> weatherDetails = List.from(resultApi.resultOrError);
      emit(state.copyWith(weatherDetails: weatherDetails, error: ''));
    } else {
      emit(state.copyWith(error: resultApi.resultOrError));
    }
  }
}
