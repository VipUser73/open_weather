import 'package:flutter/material.dart';
import 'package:open_weather/bloc/init_bloc.dart';
import 'package:open_weather/bloc/locations_bloc.dart';
import 'package:open_weather/pages/manage_location/widgets/search_city.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_weather/repositories/local_repository.dart';

class LocationsPage extends StatelessWidget {
  const LocationsPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider<LocationsBloc>(
      create: (context) => LocationsBloc(
          context.read<LocalRepository>(), context.read<InitBloc>()),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.blueGrey,
            title: const Text('Select location'),
          ),
          body: BlocListener<LocationsBloc, LocationsState>(
            listener: (context, state) {
              if (state is CityNotFoundState) {
                SnackBar snackBar = SnackBar(
                  behavior: SnackBarBehavior.floating,
                  margin: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height - 150),
                  backgroundColor: Colors.red.shade400,
                  content: const Text(
                    'City is not found!',
                    textAlign: TextAlign.center,
                  ),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            },
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color.fromRGBO(100, 200, 250, 1),
                    Color.fromRGBO(50, 120, 200, 1)
                  ],
                ),
              ),
              child: SafeArea(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 80, horizontal: 16),
                  child: SearchCity(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
