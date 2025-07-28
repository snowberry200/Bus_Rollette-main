import 'package:bus_rullette/bloc/search_bloc.dart';
import 'package:bus_rullette/widget/collections/list_cities.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ToCityDropDownWidget extends StatefulWidget {
  final SearchBloc? toCityBloc;
  final String? toCity;

  const ToCityDropDownWidget({super.key, this.toCityBloc, this.toCity});

  @override
  State<ToCityDropDownWidget> createState() => ToCityDropDownWidgetState();
}

class ToCityDropDownWidgetState extends State<ToCityDropDownWidget> {
  String? toCity;
  SearchBloc? toCityBloc;
  @override
  void initState() {
    super.initState();
    toCity = widget.toCity;
    toCityBloc = widget.toCityBloc;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        final toCityBloc = context.read<SearchBloc>();

        return DropdownButtonFormField<String>(
          value: state.toCity,
          validator: (value) =>
              value == null ? 'Please select a "to" city' : null,
          dropdownColor: CupertinoColors.black,
          style: const TextStyle(color: Colors.white, fontSize: 20),
          icon: const Icon(Icons.arrow_drop_down_circle, color: Colors.grey),
          iconEnabledColor: Colors.green,
          hint: const Text(
            "to:",
            style: TextStyle(
              color: Colors.blue,
              fontSize: 18,
              fontStyle: FontStyle.italic,
            ),
          ),
          items: cities
              .map((city) => DropdownMenuItem(value: city, child: Text(city)))
              .toList(),
          onChanged: (value) {
            if (value != null) {
              toCityBloc.add(ToCityChangeEvent(toCity: value));
            }
          },
        );
      },
    );
  }
}
