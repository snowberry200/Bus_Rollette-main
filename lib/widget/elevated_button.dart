import 'dart:async';

import 'package:bus_rullette/widget/form_widget.dart';
import 'package:bus_rullette/widget/from_city_drop_downform_field.dart';
import 'package:bus_rullette/widget/row_widget.dart';
import 'package:bus_rullette/widget/search_validation.dart';
import 'package:bus_rullette/widget/to_city_drop_downformfield.dart';
import 'package:flutter/material.dart';

class ElevatedButtonWidget extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final GlobalKey<FromCityDropDownWidgetState> fromCityKey;
  final GlobalKey<ToCityDropDownWidgetState> toCityKey;
  final GlobalKey<RowWidgetState> rowWidgetKey;
  final GlobalKey<FormWidgetState> formWidgetKey;

  const ElevatedButtonWidget({
    super.key,
    required this.fromCityKey,
    required this.toCityKey,
    required this.rowWidgetKey,
    required this.formKey,
    required this.formWidgetKey,
  });

  @override
  State<ElevatedButtonWidget> createState() => _ElevatedButtonWidgetState();
}

class _ElevatedButtonWidgetState extends State<ElevatedButtonWidget> {
  bool isLoading = false;
  late GlobalKey<FormState> formKey;
  @override
  void initState() {
    super.initState();
    formKey = widget.formKey;
  }

  Future<void> _handleSearch() async {
    final formState = formKey.currentState!.validate();
    if (!formState) {
      if (mounted) {
        return;
      }
    }

    // if (formState) {
    // Safely get all values first
    final fromCity = widget.fromCityKey.currentState?.fromCity;
    final toCity = widget.toCityKey.currentState?.toCity;
    final departureDate = widget.rowWidgetKey.currentState?.departureDate;

    try {
      if (mounted) {
        setState(() => isLoading = true);

        final isValid = SearchValidation.validateSearch(
          context: context,
          fromCity: fromCity,
          toCity: toCity,
          departureDate: departureDate,
        );

        Timer(Duration(seconds: 2), () {
          setState(() => isLoading = false);
        });

        if (!isValid || !mounted) {
          return;
        }
      }
    } finally {
      if (mounted) {
        //setState(() => isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : _handleSearch,
      child: isLoading
          ? SearchValidation.showProgressiveBar()
          : (Text("Search")),
    );
  }
}
