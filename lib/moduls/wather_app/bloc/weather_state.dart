part of 'weather_cubit.dart';

class WeatherState extends Equatable {
  final String nameLocation;
  final String error;
  final List<MainModelWeather> listMainWeather;
  final List<WeatherModel> weatherDetails;

  const WeatherState({
    this.error = '',
    this.nameLocation = '',
    this.listMainWeather = const [],
    this.weatherDetails = const [],
  });

  WeatherState copyWith({
    List<MainModelWeather>? listMainWeather,
    String? error,
    String? nameLocation,
    List<WeatherModel>? weatherDetails,
  }) =>
      WeatherState(
        error: error ?? this.error,
        nameLocation: nameLocation ?? this.nameLocation,
        listMainWeather: listMainWeather ?? this.listMainWeather,
        weatherDetails: weatherDetails ?? this.weatherDetails,
      );

  @override
  List<Object?> get props =>
      [error, nameLocation, listMainWeather, weatherDetails];
}
