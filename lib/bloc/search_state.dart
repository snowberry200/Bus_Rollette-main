part of 'search_bloc.dart';

abstract class SearchState {
  final String? fromCity;
  final String? toCity;
  final DateTime? departureDate;
  final bool isLoading;
  final String? errorMessage;
  final Object? resultedState;

  // Constructor
  SearchState({
    this.fromCity,
    this.toCity,
    this.departureDate,
    this.isLoading = false,
    this.errorMessage,
    this.resultedState,
  });

  // CopyWith method to create a new instance with updated values
  SearchState copyWith({
    String? fromCity,
    String? toCity,
    DateTime? departureDate,
    bool? isLoading,
    String? errorMessage,
    Object? resultedState,
  });

  // Factory method to create an initial state
  factory SearchState.initial(SearchState prevState) => _InitialSearchState(
    fromCity: prevState.fromCity,
    toCity: prevState.toCity,
    departureDate: prevState.departureDate,
    isLoading: prevState.isLoading,
    errorMessage: prevState.errorMessage,
    resultedState: prevState.resultedState,
  );

  // Factory method to create a loading state
  factory SearchState.loading(SearchState prevState) {
    return _LoadingSearchState(
      fromCity: prevState.fromCity,
      toCity: prevState.toCity,
      departureDate: prevState.departureDate,
      isLoading: prevState.isLoading,
      errorMessage: prevState.errorMessage,
      resultedState: prevState.resultedState,
    );
  }
  //factory method to create a success state
  factory SearchState.success(SearchState prevState) {
    return _SuccessSearchState(
      fromCity: prevState.fromCity,
      toCity: prevState.toCity,
      departureDate: prevState.departureDate,
      isLoading: prevState.isLoading,
      errorMessage: prevState.errorMessage,
      resultedState: prevState.resultedState,
    );
  }
  // Factory method to create an error state
  factory SearchState.error(SearchState prevState, String errorMessage) {
    return _ErrorSearchState(
      fromCity: prevState.fromCity,
      toCity: prevState.toCity,
      departureDate: prevState.departureDate,
      isLoading: prevState.isLoading,
      errorMessage: errorMessage,
      resultedState: prevState.resultedState,
    );
  }
}

class _InitialSearchState extends SearchState {
  _InitialSearchState({
    super.errorMessage,
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
    String? errorMessage,
    Object? resultedState,
  }) {
    // Return a new instance of _InitialSearchState with updated values
    // This allows for immutability and ensures that the state can be updated without modifying the original instance
    return _InitialSearchState(
      fromCity: fromCity ?? this.fromCity,
      toCity: toCity ?? this.toCity,
      departureDate: departureDate ?? this.departureDate,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      resultedState: resultedState ?? this.resultedState,
    );
  }
}

//_LoadingSearchState Class
class _LoadingSearchState extends SearchState {
  _LoadingSearchState({
    super.fromCity,
    super.departureDate,
    super.toCity,
    super.isLoading,
    super.errorMessage,
    super.resultedState,
  });
  @override
  SearchState copyWith({
    DateTime? departureDate,
    String? fromCity,
    String? toCity,
    bool? isLoading,
    String? errorMessage,
    Object? resultedState,
  }) {
    return _LoadingSearchState(
      departureDate: departureDate ?? this.departureDate,
      fromCity: fromCity ?? this.fromCity,
      toCity: toCity ?? this.toCity,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      resultedState: resultedState ?? this.resultedState,
    );
  }
}

class _SuccessSearchState extends SearchState {
  _SuccessSearchState({
    super.fromCity,
    super.departureDate,
    super.toCity,
    super.isLoading,
    super.errorMessage,
    required super.resultedState,
  });
  @override
  SearchState copyWith({
    DateTime? departureDate,
    String? fromCity,
    String? toCity,
    bool? isLoading,
    String? errorMessage,
    Object? resultedState,
  }) {
    return _SuccessSearchState(
      departureDate: departureDate ?? this.departureDate,
      fromCity: fromCity ?? this.fromCity,
      toCity: toCity ?? this.toCity,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      resultedState: resultedState ?? this.resultedState,
    );
  }
}

class _ErrorSearchState extends SearchState {
  _ErrorSearchState({
    super.fromCity,
    super.departureDate,
    super.toCity,
    super.isLoading,
    required super.errorMessage,
    super.resultedState,
  });

  @override
  SearchState copyWith({
    DateTime? departureDate,
    String? fromCity,
    String? toCity,
    bool? isLoading,
    String? errorMessage,
    Object? resultedState,
  }) {
    return _ErrorSearchState(
      departureDate: departureDate ?? this.departureDate,
      fromCity: fromCity ?? this.fromCity,
      toCity: toCity ?? this.toCity,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      resultedState: resultedState ?? this.resultedState,
    );
  }
}
