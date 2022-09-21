import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_weather/bloc/init_bloc.dart';
import 'package:open_weather/models/cities_model.dart';
import 'package:open_weather/repositories/local_repository.dart';

abstract class LocationsEvent {}

class SearchCityEvent extends LocationsEvent {
  final String cityName;
  SearchCityEvent(this.cityName);
}

abstract class LocationsState {}

class CityNotFoundState extends LocationsState {}

class CityEmptyState extends LocationsState {}

class LocationsBloc extends Bloc<LocationsEvent, LocationsState> {
  final InitBloc _initBloc;
  final LocalRepository _storageRepository;
  LocationsBloc(this._storageRepository, this._initBloc)
      : super(CityEmptyState()) {
    on<SearchCityEvent>(_addCities);
  }

  void _addCities(SearchCityEvent event, Emitter<LocationsState> emit) async {
    try {
      final Cities cityAndCoord = _storageRepository.citiesFromJson.firstWhere(
          (e) => e.city.toLowerCase() == event.cityName.toLowerCase());

      await _storageRepository.saveFavCity(cityAndCoord);
      _initBloc.add(LoadingCitiesEvent());
    } catch (error) {
      emit(CityNotFoundState());
    }
  }
}
