import 'package:open_weather/repositories/local_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class InitEvent {}

class LoadingCitiesEvent extends InitEvent {}

class ClearLocationEvent extends InitEvent {}

abstract class InitState {}

class LoadingCitiesState extends InitState {}

class OpenForecastPageState extends InitState {}

class OpenLocationsPageState extends InitState {}

class InitBloc extends Bloc<InitEvent, InitState> {
  final LocalRepository _storageRepository;
  InitBloc(this._storageRepository) : super(LoadingCitiesState()) {
    on<LoadingCitiesEvent>(_loadingCities);
    on<ClearLocationEvent>(_clearLocation);
  }
// Инициализация экранов
  void _loadingCities(LoadingCitiesEvent event, Emitter<InitState> emit) async {
    // Чтение из локального хранилища
    await _storageRepository.readFavCity();
    if (_storageRepository.citiesFromJson.isEmpty) {
      // Получение списка городов, если ранее это не сделано
      await _storageRepository.getCitiesList();
    }
    if (_storageRepository.cityFromPrefs.isNotEmpty) {
      // Если в локальном хранилище сохранён город, открывается экран с погодой
      emit(OpenForecastPageState());
    } else {
      // Иначе, открывается экран для ввода города
      emit(OpenLocationsPageState());
    }
  }

  void _clearLocation(ClearLocationEvent event, Emitter<InitState> emit) async {
    // Удаление информации из локального хранилища
    await _storageRepository.deleteCity();
    // Переход на экран для ввода города
    emit(OpenLocationsPageState());
  }
}
