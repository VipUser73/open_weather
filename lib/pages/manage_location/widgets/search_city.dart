import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_weather/bloc/locations_bloc.dart';

class SearchCity extends StatelessWidget {
  SearchCity({Key? key}) : super(key: key);
  final TextEditingController _textSearch = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: TextField(
              style: const TextStyle(color: Colors.black),
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(5),
                hintText: 'Search for a city or airport',
                hintStyle: TextStyle(color: Colors.grey),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                    borderSide: BorderSide.none),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
              ),
              controller: _textSearch,
              onSubmitted: (_) {
                context
                    .read<LocationsBloc>()
                    .add(SearchCityEvent(_textSearch.text));
                _textSearch.text = '';
              }),
        ),
        ElevatedButton(
          onPressed: () {
            FocusScope.of(context).unfocus();
            context
                .read<LocationsBloc>()
                .add(SearchCityEvent(_textSearch.text));
            _textSearch.text = '';
          },
          style: ElevatedButton.styleFrom(
              minimumSize: const Size(110, 45),
              primary: Colors.grey.shade700,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              )),
          child: const Text(
            'Confirm',
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
