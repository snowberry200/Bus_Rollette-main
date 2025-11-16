import 'package:bus_rullette/bloc/search_bloc.dart';
import 'package:bus_rullette/datasource/temp_db.dart';
import 'package:bus_rullette/utils/constants.dart';
import 'package:bus_rullette/widget/search_validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;

  const SearchButton({super.key, required this.formKey});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchBloc, SearchState>(
      builder: (context, state) {
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: state.isLoading
                ? Colors.grey
                : Colors.blue, // Visual feedback
            overlayColor: Colors.transparent,
            minimumSize: const Size.fromHeight(50),
            fixedSize: const Size(80, 20),
          ),
          onPressed: state.isLoading
              ? null
              : () => _handleSearch(context, state),
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
      listener: (BuildContext context, SearchState state) {
        if (state is LoadingSearchState) {
          SearchValidation.showProgress(context, "Searching for routes...");
        }
        if (state is SuccessSearchState) {
          SearchValidation.showSuccess(
            context,
            "Found route: ${state.route.routeName}",
          );
          if (context.mounted) {
            Future.delayed(Duration(seconds: 1));
            Navigator.pushNamed(
              context,
              routeNameSearchResultPage,
              arguments: {
                'route': state.route,
                'departureDate': state.departureDate,
              },
            );
          }
        }
        if (state is ErrorSearchState) {
          SearchValidation.showError(context, state.message);
        }
      },
    );
  }

  void _handleSearch(BuildContext context, SearchState state) {
    try {
      final isValid = SearchValidation.validateSearch(
        context: context,
        fromCity: state.fromCity,
        toCity: state.toCity,
        departureDate: state.departureDate,
      );

      if (isValid) {
        context.read<SearchBloc>().add(
          SearchButtonPressedEvent(
            eRoute: TempDB.tableRoute.firstWhere(
              (element) =>
                  element.cityFrom == state.fromCity &&
                  element.cityTo == state.toCity,
            ),
          ),
        );
      }
    } catch (_) {
      SearchValidation.showProgress(context, "Searching for routes...");
      SearchValidation.showError(
        context,
        'No buses found for route: ${state.fromCity} to ${state.toCity}',
      );
    }
  }
}
