import 'dart:convert';
import 'package:open_weather/models/weather_model.dart';
import 'package:flutter/services.dart';
import 'package:open_weather/models/cities_model.dart';
import 'package:open_weather/services/weather_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalRepository {
  LocalRepository(this._weaherApi);
  final WeaherApi _weaherApi;
  List<Cities> citiesFromJson = [];
  List<Cities> cityFromPrefs = [];
  List<WeatherModel> weatherForecast = [];

  // Получение списка городов
  Future<List<Cities>> getCitiesList() async {
    var response = await rootBundle.loadString('assets/city_list.json');
    final data = await jsonDecode(response) as List<dynamic>;
    citiesFromJson = data
        .map((dynamic e) => Cities.fromJson(e as Map<String, dynamic>))
        .toList();
    return citiesFromJson;
  }

  // Получение информации о погоде
  Future<List<WeatherModel>> getFavWeather() async {
    weatherForecast.clear();
    weatherForecast.add(await _weaherApi.getWeather(cityFromPrefs.first.city,
        cityFromPrefs.first.lon, cityFromPrefs[0].lat));
    weatherForecast.first.daily
        .sort((a, b) => Comparable.compare(a.tempMin, b.tempMin));
    return weatherForecast;
  }

// Сохранение информации о городе в локальном хранилище
  Future saveFavCity(Cities item) async {
    final responce = cityInfoToJson(item);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('favCity', responce);
  }

  // Кодирование информации в JSON для сохранения в локальое хранилище
  String cityInfoToJson(Cities city) {
    List<Cities> citiesList = [];
    citiesList.add(city);
    return jsonEncode(citiesList.map((e) => e.toJson()).toList());
  }

  List<Cities> listFromBody(List<dynamic> body) =>
      body.map((e) => Cities.fromJson(e as Map<String, dynamic>)).toList();

  // Чтение из локального хранилища
  Future<List<Cities>> readFavCity() async {
    final prefs = await SharedPreferences.getInstance();
    final item = prefs.getString('favCity') ?? "[]";
    final data = await json.decode(item);
    cityFromPrefs = listFromBody(data);
    return cityFromPrefs;
  }

  // Удаление информации из локального хранилища
  Future<bool> deleteCity() async {
    final prefs = await SharedPreferences.getInstance();
    final success = await prefs.remove('favCity');
    return success;
  }
}
