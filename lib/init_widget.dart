import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_weather/bloc/init_bloc.dart';
import 'package:open_weather/bloc/weather_bloc.dart';
import 'package:open_weather/pages/manage_location/locations_page.dart';
import 'package:open_weather/pages/forecast_now/forecast_page.dart';
import 'package:open_weather/repositories/local_repository.dart';
import 'package:open_weather/services/weather_api.dart';
import 'package:open_weather/splash_screen.dart';

class InitWidget extends StatelessWidget {
  InitWidget({Key? key}) : super(key: key);
  final LocalRepository _storageRepository = LocalRepository(WeaherApi());
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _storageRepository,
      child: BlocProvider<InitBloc>(
        create: (context) => InitBloc(context.read<LocalRepository>())
          ..add(LoadingCitiesEvent()),
        child: BlocBuilder<InitBloc, InitState>(builder: (context, state) {
          if (state is OpenLocationsPageState) {
            return const LocationsPage();
          }

          if (state is OpenForecastPageState) {
            return const Forecast();
          } else {
            return const SplashScreen();
          }
        }),
      ),
    );
  }
}
