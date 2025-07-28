import 'package:bus_rullette/bloc/search_bloc.dart';
import 'package:bus_rullette/widget/search_validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;

  const SearchButton({super.key, required this.formKey});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchBloc, SearchState>(
      listener: (context, state) {
        if (state.errorMessage != null) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
        }
      },
      builder: (context, state) {
        return ElevatedButton(
          onPressed: state.isLoading ? null : () => _handleSearch(context),
          style: ElevatedButton.styleFrom(minimumSize: const Size(200, 48)),
          child: state.isLoading
              ? SizedBox(
                  width: 24,
                  height: 24,
                  child: SearchValidation.showProgressiveBar(),
                )
              : const Text("Search"),
        );
      },
    );
  }

  Future<void> _handleSearch(BuildContext context) async {
    final bloc = context.read<SearchBloc>();
    final form = formKey.currentState!;

    if (!form.validate()) return;

    try {
      final isValid = SearchValidation.validateSearch(
        fromCity: bloc.state.fromCity,
        toCity: bloc.state.toCity,
        departureDate: bloc.state.departureDate,
        context: context,
      );

      if (!isValid) return;

      // If search is valid, emit a success state
      bloc.add(
        SearchButtonPressedEvent(
          fromCity: bloc.state.fromCity,
          toCity: bloc.state.toCity,
          departureDate: bloc.state.departureDate,
          isLoading: true,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Search failed: ${e.toString()}')));
    } finally {
      bloc.add(
        SearchButtonPressedEvent(
          fromCity: bloc.state.fromCity,
          toCity: bloc.state.toCity,
          departureDate: bloc.state.departureDate,
          isLoading: false,
        ),
      );
    }
  }
}
