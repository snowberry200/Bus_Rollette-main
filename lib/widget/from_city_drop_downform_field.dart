import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bus_rullette/bloc/search_bloc.dart';
import 'package:bus_rullette/widget/collections/list_cities.dart';

class FromCityDropDownWidget extends StatefulWidget {
  final SearchBloc? fromCityBloc;

  const FromCityDropDownWidget({super.key, this.fromCityBloc});

  @override
  State<FromCityDropDownWidget> createState() => FromCityDropDownWidgetState();
}

class FromCityDropDownWidgetState extends State<FromCityDropDownWidget> {
  String? fromCity;
  SearchBloc? fromCityBloc;
  @override
  void initState() {
    super.initState();
    fromCityBloc = widget.fromCityBloc;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        final fromCityBloc = context.read<SearchBloc>();

        return DropdownButtonFormField<String>(
          value: state.fromCity,
          dropdownColor: CupertinoColors.black,
          style: const TextStyle(color: Colors.white, fontSize: 20),
          icon: Icon(
            Icons.arrow_drop_down_circle_outlined,
            color: state.fromCity == null ? Colors.grey : Colors.green,
          ),
          iconEnabledColor: Colors.green,
          hint: const Text(
            "from:",
            style: TextStyle(
              color: Colors.green,
              fontSize: 18,
              fontStyle: FontStyle.italic,
            ),
          ),
          items: cities
              .map((city) => DropdownMenuItem(value: city, child: Text(city)))
              .toList(),
          onChanged: (value) {
            if (value!.isNotEmpty) {
              fromCityBloc.add(FromCityChangeEvent(fromCity: value));
            }
          },
        );
      },
    );
  }
}
