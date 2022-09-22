import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_weather/bloc/init_bloc.dart';
import 'package:open_weather/bloc/weather_bloc.dart';
import 'package:open_weather/pages/forecast/widgets/weather_7days.dart';
import 'package:open_weather/pages/forecast/widgets/weather_hourly.dart';
import 'package:open_weather/pages/forecast/widgets/weathet_now.dart';

class ForecastPage extends StatelessWidget {
  const ForecastPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final titleTextStyle = theme.textTheme.headline1;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
        leading: IconButton(
          icon: const Icon(Icons.search),
          tooltip: 'Search city',
          onPressed: () {
            context.read<InitBloc>().add(ClearLocationEvent());
          },
        ),
        title: const Text('Forecast'),
        actions: [
          IconButton(
            icon: const Icon(Icons.list),
            tooltip: 'Forecast 7 days',
            onPressed: () {
              if (context.read<WeatherBloc>().state is LoadedForecastState) {
                context.read<WeatherBloc>().add(Show7daysForecastEvent());
              } else {
                context.read<WeatherBloc>().add(LoadingForecastEvent());
              }
            },
          ),
        ],
      ),
      body: Container(
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
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: BlocConsumer<WeatherBloc, WeatherState>(
                listener: (context, state) {
              if (state is ErrorConnectingState) {
                SnackBar snackBar = SnackBar(
                  behavior: SnackBarBehavior.floating,
                  margin: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height - 150),
                  backgroundColor: Colors.red.shade400,
                  content: const Text(
                    'Failed to load data.',
                    textAlign: TextAlign.center,
                  ),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            }, builder: (context, state) {
              if (state is LoadedForecastState) {
                return RefreshIndicator(
                  onRefresh: () async {
                    context.read<WeatherBloc>().add(LoadingForecastEvent());
                  },
                  child: ListView(
                    physics: const AlwaysScrollableScrollPhysics(
                        parent: BouncingScrollPhysics()),
                    children: const [WeatherNow(), WeatherHourly()],
                  ),
                );
              }
              if (state is LoadedForecast7DaysState) {
                return const Weather7days();
              }
              if (state is ErrorConnectingState) {
                return Center(
                  child: Text(
                    "Failed to load data.",
                    style: titleTextStyle?.copyWith(fontSize: 20),
                  ),
                );
              } else {
                return const Center(
                    child: CircularProgressIndicator(color: Colors.white));
              }
            }),
          ),
        ),
      ),
    );
  }
}
