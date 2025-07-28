part of 'search_bloc.dart';

abstract class SearchState {
  final String? fromCity;
  final String? toCity;
  final DateTime? departureDate;
  final bool isLoading;
  final String? errorMessage;

  const SearchState({
    this.fromCity,
    this.toCity,
    this.departureDate,
    this.isLoading = false,
    this.errorMessage,
  });

  factory SearchState.initial() => const _InitialSearchState();

  SearchState copyWith({
    String? fromCity,
    String? toCity,
    DateTime? departureDate,
    bool? isLoading,
    String? errorMessage,
  });
}

class _InitialSearchState extends SearchState {
  const _InitialSearchState({
    super.fromCity,
    super.toCity,
    super.departureDate,
    super.isLoading,
    super.errorMessage,
  });

  @override
  SearchState copyWith({
    String? fromCity,
    String? toCity,
    DateTime? departureDate,
    bool? isLoading,
    String? errorMessage,
  }) {
    return _InitialSearchState(
      fromCity: fromCity ?? this.fromCity,
      toCity: toCity ?? this.toCity,
      departureDate: departureDate ?? this.departureDate,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
