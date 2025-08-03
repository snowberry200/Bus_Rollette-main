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
          style: ElevatedButton.styleFrom(
            minimumSize: const Size.fromHeight(50),
            fixedSize: const Size(80, 20),
            backgroundColor: Colors.transparent,
            overlayColor: Colors.transparent,
          ),
          onPressed: state.isLoading ? null : () => _handleSearch(context),
          child: state.isLoading
              ? SearchValidation.showProgressiveBar()
              : const Text(
                  "Search",
                  softWrap: true,
                  textScaler: TextScaler.noScaling,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        );
      },
    );
  }

  void _handleSearch(BuildContext context) {
    final buttonBloc = context.read<SearchBloc>();
    buttonBloc.add(
      SearchButtonPressedEvent(
        fromCity: buttonBloc.state.fromCity,
        toCity: buttonBloc.state.toCity,
        departureDate: buttonBloc.state.departureDate,
      ),
    );
  }
}
