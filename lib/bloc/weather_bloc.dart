import 'package:open_weather/models/weather_model.dart';
import 'package:open_weather/repositories/local_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class WeatherEvent {}

class LoadingForecastEvent extends WeatherEvent {}

class Show7daysForecastEvent extends WeatherEvent {}

abstract class WeatherState {
  final List<WeatherModel> weatherFavList;
  WeatherState({this.weatherFavList = const []});
}

class LoadingForecastState extends WeatherState {}

class ErrorConnectingState extends WeatherState {}

class LoadedForecastState extends WeatherState {
  LoadedForecastState({required List<WeatherModel> weatherFavList})
      : super(weatherFavList: weatherFavList);
}

class LoadedForecast7DaysState extends WeatherState {
  LoadedForecast7DaysState({required List<WeatherModel> weatherFavList})
      : super(weatherFavList: weatherFavList);
}

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc(this._storageRepository) : super(LoadingForecastState()) {
    on<LoadingForecastEvent>(_loadingForecastEvent);
    on<Show7daysForecastEvent>(_show3daysForecast);
  }
  final LocalRepository _storageRepository;

  void _loadingForecastEvent(
      LoadingForecastEvent event, Emitter<WeatherState> emit) async {
    try {
      await _storageRepository.getFavWeather();
      emit(LoadedForecastState(
          weatherFavList: _storageRepository.weatherForecast));
    } catch (error) {
      emit(ErrorConnectingState());
    }
  }

  void _show3daysForecast(
      Show7daysForecastEvent event, Emitter<WeatherState> emit) async {
    emit(LoadedForecast7DaysState(
        weatherFavList: _storageRepository.weatherForecast));
  }
}
