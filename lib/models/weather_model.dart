import 'package:intl/intl.dart';

class WeatherModel {
  String name;
  double lat;
  double lon;
  int timezoneOffset;
  int temp;
  int wind;
  int humidity;
  int pressure;
  String description;
  String icon;
  List<Hourly> hourly;
  List<Daily> daily;

  WeatherModel(
      {required this.name,
      required this.lat,
      required this.lon,
      required this.timezoneOffset,
      required this.temp,
      required this.wind,
      required this.humidity,
      required this.pressure,
      required this.description,
      required this.icon,
      required this.hourly,
      required this.daily});

  factory WeatherModel.fromJson(Map<String, dynamic> json, String city) {
    return WeatherModel(
      name: city,
      lat: json['lat'].toDouble(),
      lon: json['lon'].toDouble(),
      timezoneOffset: json['timezone_offset'],
      temp: json['current']['temp'].toInt(),
      wind: json['current']['wind_speed'].toInt(),
      humidity: json['current']['humidity'],
      pressure: json['current']['pressure'],
      description: json['current']['weather'][0]['description'],
      icon: json['current']['weather'][0]['icon'],
      hourly: (json['hourly'] as List<dynamic>)
          .map((e) => Hourly.fromJSON(
              e as Map<String, dynamic>, json['timezone_offset']))
          .toList(),
      daily: (json['daily'] as List<dynamic>)
          .map((e) => Daily.fromJSON(
              e as Map<String, dynamic>, json['timezone_offset']))
          .toList(),
    );
  }
}

class Hourly {
  int hour;
  int temp;
  String icon;
  double pop;

  Hourly({
    required this.hour,
    required this.temp,
    required this.icon,
    required this.pop,
  });

  factory Hourly.fromJSON(Map<String, dynamic> json, int timezoneOffset) {
    var hour = DateTime.fromMillisecondsSinceEpoch(
            (json['dt'] + timezoneOffset) * 1000)
        .hour;
    return Hourly(
        hour: hour,
        temp: json['temp'].toInt(),
        icon: json['weather'][0]['icon'],
        pop: json['pop'].toDouble());
  }
}

class Daily {
  String dt;
  String icon;
  int tempMin;
  int tempMax;
  double pop;

  Daily(
      {required this.dt,
      required this.icon,
      required this.tempMin,
      required this.tempMax,
      required this.pop});

  factory Daily.fromJSON(Map<String, dynamic> json, int timezoneOffset) {
    var date = DateTime.fromMillisecondsSinceEpoch(
        (json['dt'] + timezoneOffset) * 1000);
    var dt = DateFormat('E').format(date);
    return Daily(
        dt: dt,
        icon: json['weather'][0]['icon'],
        tempMin: json['temp']['min'].toInt(),
        tempMax: json['temp']['max'].toInt(),
        pop: json['pop'].toDouble());
  }
}
