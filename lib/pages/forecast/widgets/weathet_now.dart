import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:open_weather/bloc/weather_bloc.dart';

class WeatherNow extends StatelessWidget {
  const WeatherNow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bloc = context.read<WeatherBloc>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            bloc.state.weatherFavList.first.name,
            style: theme.textTheme.headline1?.copyWith(fontSize: 24),
            textAlign: TextAlign.center,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgPicture.asset(
                "assets/icons/conditions/${bloc.state.weatherFavList.first.icon}.svg",
                width: 90,
                height: 90,
              ),
              Column(
                children: [
                  Text(bloc.state.weatherFavList.first.daily.first.dt,
                      style: theme.textTheme.headline1),
                  Text("${bloc.state.weatherFavList.first.temp}°",
                      style: theme.textTheme.headline1?.copyWith(fontSize: 60)),
                  Text(bloc.state.weatherFavList.first.description,
                      style: theme.textTheme.headline1),
                ],
              ),
            ],
          ),
          const Divider(
            height: 20,
            thickness: 2,
            color: Colors.white,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 20, right: 11.67),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset("assets/icons/wind.png"),
                    const SizedBox(
                      width: 10,
                    ),
                    Text("${bloc.state.weatherFavList.first.wind} m/s\nWind",
                        style: theme.textTheme.bodyText1),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset("assets/icons/rain.png"),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                        "${(bloc.state.weatherFavList.first.hourly.first.pop * 100).round()}%\nChance of rain",
                        style: theme.textTheme.bodyText1),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 31.67, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset("assets/icons/pressure.png"),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                        "${bloc.state.weatherFavList.first.pressure} hPa\nPressure",
                        style: theme.textTheme.bodyText1),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset("assets/icons/humidity.png"),
                    const SizedBox(
                      width: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 26),
                      child: Text(
                          "${bloc.state.weatherFavList.first.humidity}% \nHumidity",
                          style: theme.textTheme.bodyText1),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
