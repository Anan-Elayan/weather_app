class ForecastModel {
  final String dateTime;
  final double temp;
  final int humidity;
  final double tempMin;
  final double tempMax;
  final String description;
  final String icon;

  ForecastModel({
    required this.dateTime,
    required this.temp,
    required this.humidity,
    required this.tempMin,
    required this.tempMax,
    required this.description,
    required this.icon,
  });

  factory ForecastModel.fromJson(Map<String, dynamic> json) => ForecastModel(
        dateTime: json["dt_txt"],
        temp: (json["main"]["temp"] is int)
            ? (json["main"]["temp"] as int).toDouble()
            : json["main"]["temp"].toDouble(),
        humidity: json["main"]["humidity"],
        tempMin: (json["main"]["temp_min"] is int)
            ? (json["main"]["temp_min"] as int).toDouble()
            : json["main"]["temp_min"].toDouble(),
        tempMax: (json["main"]["temp_max"] is int)
            ? (json["main"]["temp_max"] as int).toDouble()
            : json["main"]["temp_max"].toDouble(),
        description: json["weather"][0]["description"],
        icon: json["weather"][0]["icon"],
      );
}
