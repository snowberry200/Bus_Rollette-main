import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bus_rullette/widget/search_validation.dart';
import 'package:flutter/material.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  SearchBloc({required this.formKey}) : super((_InitialSearchState())) {
    on<FromCityChangeEvent>(_onFromCityChanged);
    on<ToCityChangeEvent>(_onToCityChanged);
    on<DateChangeEvent>(_onDateChanged);
    on<SearchButtonPressedEvent>(_onSearchButtonPressed);
    on<SearchStateError>(_onSearchStateError);
  }

  void _onFromCityChanged(
    FromCityChangeEvent event,
    Emitter<SearchState> emit,
  ) {
    emit(state.copyWith(fromCity: event.fromCity, errorMessage: null));
  }

  void _onToCityChanged(ToCityChangeEvent event, Emitter<SearchState> emit) {
    emit(state.copyWith(toCity: event.toCity, errorMessage: null));
  }

  void _onDateChanged(DateChangeEvent event, Emitter<SearchState> emit) {
    emit(
      state.copyWith(departureDate: event.departureDate, errorMessage: null),
    );
  }

  Future<void> _onSearchButtonPressed(
    SearchButtonPressedEvent event,
    Emitter<SearchState> emit,
  ) async {
    // Set loading state to true
    emit(state.copyWith(isLoading: true, errorMessage: null));

    try {
      // Simulate API delay
      await Future.delayed(const Duration(seconds: 3));

      // Business validation
      final isValid = SearchValidation.validateSearch(
        fromCity: event.fromCity!,
        toCity: event.toCity!,
        departureDate: event.departureDate!,
        context: formKey.currentContext!,
      );

      if (!isValid) {
        emit(
          state.copyWith(
            isLoading: false,
            errorMessage: 'Invalid search parameters',
          ),
        );
        return;
      }

      // Success case - set loading to false
      emit(
        state.copyWith(
          isLoading: false,
          fromCity: event.fromCity,
          toCity: event.toCity,
          departureDate: event.departureDate,
          errorMessage: null,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: 'Search failed: ${e.toString()}',
        ),
      );
    }
  }

  void _onSearchStateError(SearchStateError event, Emitter<SearchState> emit) {
    emit(state.copyWith(errorMessage: event.errorMessage));
  }
}
