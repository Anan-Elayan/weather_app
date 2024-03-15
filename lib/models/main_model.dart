class MainModelWeather {
  
  final double temp;
  final double temp_min;
  final double temp_max;
  final int humidity;
  final int pressure;
  MainModelWeather(
      {required this.temp,
      required this.humidity,
      required this.pressure,
      required this.temp_min,
      required this.temp_max});

  factory MainModelWeather.fromJson(Map, json) => MainModelWeather(
        temp: json["temp"],
        temp_min: json['temp_min'],
        temp_max: json['temp_max'],
        humidity: json["humidity"],
        pressure: json["pressure"],
      );

  Map<String, dynamic> toJson() => {
        'temp': temp,
        "temp_min": temp_min,
        "temp_max": temp_max,
        "humidity": humidity,
        "pressure": pressure
      };
}
