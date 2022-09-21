import 'dart:convert';
import 'package:open_weather/models/weather_model.dart';
import 'package:http/http.dart' as https;

class WeaherApi {
  Future<WeatherModel> getWeather(String city, double lon, double lat) async {
    final url = Uri.parse(
        "https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lon&exclude=minutely,alerts&appid=6f6f192517f2b62b4364d19778420b76&units=metric");
    final response = await https.get(url);
    var body = jsonDecode(response.body);
    return WeatherModel.fromJson(body, city);
  }
}
