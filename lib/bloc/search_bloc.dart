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
  }

  void _onFromCityChanged(
    FromCityChangeEvent event,
    Emitter<SearchState> emit,
  ) {
    emit(
      _InitialSearchState(
        fromCity: event.fromCity,
        toCity: state.toCity,
        departureDate: state.departureDate,
        isLoading: state.isLoading,
        resultedState: SearchValidation.validateSearch,
      ),
    );
  }

  void _onToCityChanged(ToCityChangeEvent event, Emitter<SearchState> emit) {
    emit(
      _InitialSearchState(
        fromCity: state.fromCity,
        toCity: event.toCity,
        departureDate: state.departureDate,
        isLoading: state.isLoading,
        resultedState: SearchValidation.validateSearch,
      ),
    );
  }

  void _onDateChanged(DateChangeEvent event, Emitter<SearchState> emit) {
    emit(
      _InitialSearchState(
        fromCity: state.fromCity,
        toCity: state.toCity,
        departureDate: event.departureDate,
        isLoading: state.isLoading,
        resultedState: SearchValidation.validateSearch,
      ),
    );
  }

  FutureOr<void> _onSearchButtonPressed(
    SearchButtonPressedEvent event,
    Emitter<SearchState> emit,
  ) async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    try {
      final isValid = SearchValidation.validateSearch(
        fromCity: event.fromCity,
        toCity: event.toCity,
        departureDate: event.departureDate,
        context: formKey.currentContext!,
        isLoading: event.isLoading,
      );

      if (!isValid) {
        return;
      }

      //loading state
      emit(
        _LoadingSearchState(
          fromCity: state.fromCity,
          toCity: state.toCity,
          departureDate: state.departureDate,
          isLoading: event.isLoading,
          resultedState: isValid,
        ),
      );

      // Simulate a network call or processing delay
      await Future.delayed(const Duration(seconds: 5));

      emit(
        _SuccessSearchState(
          fromCity: event.fromCity,
          toCity: event.toCity,
          departureDate: event.departureDate,
          isLoading: event.isLoading,
          resultedState: isValid,
          errorMessage: state.errorMessage,
        ),
      );
    } catch (e) {
      // Emit error state
      emit(
        _ErrorSearchState(
          fromCity: state.fromCity,
          toCity: state.toCity,
          departureDate: state.departureDate,
          isLoading: false,
          errorMessage: e.toString(),
          resultedState: SearchValidation.validateSearch,
        ),
      );
    } finally {
      // Reset the loading state after the search is complete
      emit(
        state.copyWith(
          isLoading: false,
          resultedState: SearchValidation.validateSearch,
        ),
      );
    }
  }
}
