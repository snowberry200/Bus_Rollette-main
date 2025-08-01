part of 'search_bloc.dart';

abstract class SearchState {
  late final String? fromCity;
  final String? toCity;
  final DateTime? departureDate;
  final bool isLoading;
  final Object? resultedState;

  // Constructor
  SearchState({
    this.fromCity,
    this.toCity,
    this.departureDate,
    this.isLoading = false,
    this.resultedState,
  });

  // CopyWith method to create a new instance with updated values
  SearchState copyWith({
    String? fromCity,
    String? toCity,
    DateTime? departureDate,
    bool? isLoading,
    Object? resultedState,
  });

  // Factory method to create an initial state
  factory SearchState.initial(SearchState prevState) => _InitialSearchState(
    fromCity: prevState.fromCity,
    toCity: prevState.toCity,
    departureDate: prevState.departureDate,
    isLoading: false,
    resultedState: prevState.resultedState,
  );

  // Factory method to create a loading state
  factory SearchState.loading(SearchState prevState) {
    return _LoadingSearchState(
      fromCity: prevState.fromCity,
      toCity: prevState.toCity,
      departureDate: prevState.departureDate,
      isLoading: true,
      resultedState: prevState.resultedState,
    );
  }
  //factory method to create a success state
  factory SearchState.success(SearchState prevState) {
    return _SuccessSearchState(
      fromCity: prevState.fromCity,
      toCity: prevState.toCity,
      departureDate: prevState.departureDate,
      isLoading: false,
      resultedState: prevState.resultedState,
    );
  }
}

class _InitialSearchState extends SearchState {
  _InitialSearchState({
    super.fromCity,
    super.toCity,
    super.departureDate,
    super.isLoading,
    super.resultedState,
  });

  @override
  SearchState copyWith({
    String? fromCity,
    String? toCity,
    DateTime? departureDate,
    bool? isLoading,
    Object? resultedState,
  }) {
    // Return a new instance of _InitialSearchState with updated values
    // This allows for immutability and ensures that the state can be updated without modifying the original instance
    return _InitialSearchState(
      fromCity: fromCity ?? this.fromCity,
      toCity: toCity ?? this.toCity,
      departureDate: departureDate ?? this.departureDate,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

//_LoadingSearchState Class
class _LoadingSearchState extends SearchState {
  _LoadingSearchState({
    super.fromCity,
    super.departureDate,
    super.toCity,
    super.isLoading = true,
    super.resultedState,
  });
  @override
  SearchState copyWith({
    DateTime? departureDate,
    String? fromCity,
    String? toCity,
    bool? isLoading,
    Object? resultedState,
  }) {
    return _LoadingSearchState(
      departureDate: departureDate ?? this.departureDate,
      fromCity: fromCity ?? this.fromCity,
      toCity: toCity ?? this.toCity,
      isLoading: isLoading ?? this.isLoading,
      resultedState: resultedState ?? this.resultedState,
    );
  }
}

class _SuccessSearchState extends SearchState {
  _SuccessSearchState({
    super.fromCity,
    super.departureDate,
    super.toCity,
    super.isLoading = false,
    required super.resultedState,
  });
  @override
  SearchState copyWith({
    DateTime? departureDate,
    String? fromCity,
    String? toCity,
    bool? isLoading,
    Object? resultedState,
  }) {
    return _SuccessSearchState(
      departureDate: departureDate ?? this.departureDate,
      fromCity: fromCity ?? this.fromCity,
      toCity: toCity ?? this.toCity,
      isLoading: isLoading ?? this.isLoading,
      resultedState: resultedState ?? this.resultedState,
    );
  }
}
