import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bus_rullette/datasource/temp_db.dart';
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
    // Validate inputs first
    if (state.fromCity == null || state.toCity == null) {
      emit(
        ErrorSearchState(
          message: 'Please select both from and to cities',
          fromCity: state.fromCity,
          toCity: state.toCity,
          departureDate: state.departureDate,
        ),
      );
      return;
    }

    emit(
      LoadingSearchState(
        loading: true,
        fromCity: state.fromCity,
        toCity: state.toCity,
        departureDate: state.departureDate,
      ),
    );

    await Future.delayed(const Duration(seconds: 3));

    try {
      // Use firstWhereOrNull instead of firstWhere to avoid StateError
      final route = TempDB.tableRoute.firstWhere(
        (element) =>
            element.cityFrom == state.fromCity &&
            element.cityTo == state.toCity,
        orElse: () => throw StateError('No route found'), // Custom handling
      );

      emit(
        SuccessSearchState(
          fromCity: state.fromCity,
          departureDate: state.departureDate,
          toCity: state.toCity,
          router: route,
        ),
      );
    } on StateError catch (_) {
      emit(
        ErrorSearchState(
          message:
              'No buses found for route: ${state.fromCity} to ${state.toCity}',
          fromCity: state.fromCity,
          toCity: state.toCity,
          departureDate: state.departureDate,
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
