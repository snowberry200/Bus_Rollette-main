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
          SearchValidation.showProgressiveBar();
          SearchValidation.showProgress(context, "Searching for routes...");
        }
        if (state is SuccessSearchState) {
          try {
            if (state.route !=
                TempDB.tableRoute.firstWhere(
                  (element) =>
                      element.cityFrom == state.fromCity &&
                      element.cityTo == state.toCity,
                )) {
              SearchValidation.showError(
                context,
                "No buses found for this route",
              );
            }

            //if true

            SearchValidation.showSuccess(
              context,
              "found route : ${state.route.routeName}",
            );
          } on StateError {
            if (context.mounted) {
              SearchValidation.showError(
                context,
                "No buses found for this route",
              );
            }
          } catch (e) {
            if (context.mounted) {
              SearchValidation.showError(
                context,
                "Search failed: ${e.toString()}",
              );
            }
          }
          Future.delayed(Duration(seconds: 2));
          Navigator.pushNamed(context, routeNameSearchResultPage);
        }
      },
    );
  }

  void _handleSearch(BuildContext context, SearchState state) {
    try {
      // Use the fixed validation method
      final isValid = SearchValidation.validateSearch(
        context: context,
        fromCity: state.fromCity,
        toCity: state.toCity,
        departureDate: state.departureDate,
      );

      if (isValid) {
        context.read<SearchBloc>().add(SearchButtonPressedEvent());
      }
    } catch (e) {
      print("Error in _handleSearch: $e");
      SearchValidation.showError(context, "An error occurred: ${e.toString()}");
    }
  }
}
