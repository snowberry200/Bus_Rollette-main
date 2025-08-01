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
      //state.copyWith(fromCity: event.fromCity)
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
      //state.copyWith(toCity: event.toCity)
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
      //state.copyWith(departureDate: event.departureDate)
    );
  }

  FutureOr<void> _onSearchButtonPressed(
    SearchButtonPressedEvent event,
    Emitter<SearchState> emit,
  ) async {
    //loading state
    emit(
      SearchState.loading(
        _LoadingSearchState(
          fromCity: event.fromCity,
          toCity: event.toCity,
          departureDate: event.departureDate,
          isLoading: true,
          resultedState: SearchValidation.validateSearch,
        ),
      ),
      //state.copyWith(isLoading: true)
    );

    try {
      // Simulate a network call or processing delay
      await Future.delayed(const Duration(seconds: 4));

      // success state
      // all search Validation is done in the SearchValidation class
      //if currentsState.validate is done is the SearchButton class

      emit(
        SearchState.success(
          _SuccessSearchState(
            fromCity: event.fromCity,
            toCity: event.toCity,
            departureDate: event.departureDate,
            isLoading: false,
            resultedState: SearchValidation.validateSearch,
          ),
        ),
        // state.copyWith(
        //   isLoading: false,
        //   fromCity: event.fromCity,
        //   toCity: event.toCity,
        //   departureDate: event.departureDate,
        //   resultedState: SearchValidation.validateSearch,
        // ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          resultedState: SearchValidation.validateSearch,
        ),
      );
    }
  }
}
