import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bus_rullette/models/bus_route.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  SearchBloc({required this.formKey})
    : super((InitialState(fromCity: null, toCity: null, departureDate: null))) {
    on<FromCityChangeEvent>(_onFromCityChanged);
    on<ToCityChangeEvent>(_onToCityChanged);
    on<DateChangeEvent>(_onDateChanged);
    on<SearchButtonPressedEvent>(_onSearchButtonPressed);
  }

  FutureOr<void> _onFromCityChanged(
    FromCityChangeEvent event,
    Emitter<SearchState> emit,
  ) {
    emit(
      InitialState(
        fromCity: event.fromCity,
        toCity: state.toCity,
        departureDate: state.departureDate,
      ),
    );
  }

  FutureOr<void> _onToCityChanged(
    ToCityChangeEvent event,
    Emitter<SearchState> emit,
  ) {
    emit(
      InitialState(
        fromCity: state.fromCity,
        toCity: event.toCity,
        departureDate: state.departureDate,
      ),
    );
  }

  FutureOr<void> _onDateChanged(
    DateChangeEvent event,
    Emitter<SearchState> emit,
  ) {
    emit(
      InitialState(
        fromCity: state.fromCity,
        toCity: state.toCity,
        departureDate: event.departureDate,
      ),
    );
  }

  FutureOr<void> _onSearchButtonPressed(
    SearchButtonPressedEvent event,
    Emitter<SearchState> emit,
  ) async {
    emit(
      LoadingSearchState(
        loading: event.isLoading,
        fromCity: state.fromCity,
        toCity: state.toCity,
        departureDate: state.departureDate,
      ),
    );

    await Future.delayed(const Duration(seconds: 4));

    try {
      emit(
        SuccessSearchState(
          fromCity: state.fromCity,
          departureDate: state.departureDate,
          toCity: state.toCity,
          router: event.route,
        ),
      );
    } catch (e) {
      emit(
        ErrorSearchState(
          message: 'Search failed: ${e.toString()}',
          fromCity: state.fromCity,
          toCity: state.toCity,
          departureDate: state.departureDate,
        ),
      );
    }
  }
}
