import 'package:open_weather/bloc/weather_bloc.dart';
import 'package:open_weather/repositories/local_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class InitEvent {}

class LoadingCitiesEvent extends InitEvent {}

class ClearLocationEvent extends InitEvent {}

abstract class InitState {}

class LoadingCitiesState extends InitState {}

class LoadedCitiesState extends InitState {}

class OpenForecastPageState extends InitState {}

class OpenLocationsPageState extends InitState {}

class InitBloc extends Bloc<InitEvent, InitState> {
  final LocalRepository _storageRepository;
  InitBloc(this._storageRepository) : super(LoadingCitiesState()) {
    on<LoadingCitiesEvent>(_loadingCities);
    on<ClearLocationEvent>(_clearLocation);
  }

  void _loadingCities(LoadingCitiesEvent event, Emitter<InitState> emit) async {
    await _storageRepository.readFavCity();
    if (_storageRepository.citiesFromJson.isEmpty) {
      await _storageRepository.getCitiesList();
    }
    if (_storageRepository.cityFromPrefs.isNotEmpty) {
      emit(OpenForecastPageState());
    } else {
      emit(OpenLocationsPageState());
    }
  }

  void _clearLocation(ClearLocationEvent event, Emitter<InitState> emit) async {
    await _storageRepository.deleteCity();
    emit(OpenLocationsPageState());
  }
}
