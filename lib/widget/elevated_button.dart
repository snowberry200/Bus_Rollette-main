import 'package:bus_rullette/bloc/search_bloc.dart';
import 'package:bus_rullette/widget/search_validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;

  const SearchButton({super.key, required this.formKey});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        return ElevatedButton(
          onPressed: state.isLoading ? null : () => _handleSearch(context),
          child: state.isLoading
              ? SearchValidation.showProgressiveBar()
              : const Text("Search"),
        );
      },
    );
  }

  void _handleSearch(BuildContext context) {
    final form = formKey.currentState!;
    final buttonBloc = context.read<SearchBloc>();

    // Step 1: Form validation
    if (!form.validate()) return;

    // Step 2: Business validation through BLoC
    final isValid = SearchValidation.validateSearch(
      fromCity: buttonBloc.state.fromCity,
      toCity: buttonBloc.state.toCity,
      departureDate: buttonBloc.state.departureDate,
      context: context,
    );
    buttonBloc.add(
      SearchButtonPressedEvent(
        fromCity: buttonBloc.state.fromCity,
        toCity: buttonBloc.state.toCity,
        departureDate: buttonBloc.state.departureDate,
      ),
    );
    if (!isValid) {
      return;
    }
  }
}
