import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:open_weather/bloc/weather_bloc.dart';

class Weather7days extends StatelessWidget {
  const Weather7days({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<WeatherBloc>();
    final theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics()),
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              scrollDirection: Axis.vertical,
              itemCount: bloc.state.weatherFavList.first.daily.length,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                          bloc.state.weatherFavList.first.daily[index].dt,
                          textAlign: TextAlign.left,
                          style: theme.textTheme.headline2),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 0),
                        child: SvgPicture.asset(
                          "assets/icons/conditions/${bloc.state.weatherFavList.first.daily[index].icon}.svg",
                          alignment: Alignment.centerRight,
                          width: 30,
                          height: 30,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                          "${(bloc.state.weatherFavList.first.daily[index].pop * 100).toStringAsFixed(0)}% rain",
                          textAlign: TextAlign.right,
                          style: theme.textTheme.headline2),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                          "${bloc.state.weatherFavList.first.daily[index].tempMin}°/${bloc.state.weatherFavList.first.daily[index].tempMax}°",
                          textAlign: TextAlign.right,
                          style: theme.textTheme.headline2),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
