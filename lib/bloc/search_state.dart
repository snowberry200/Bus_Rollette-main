part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  final String? fromCity;
  final String? toCity;
  final DateTime? departureDate;
  BusRoute? get route;
  //  => TempDB.tableRoute.firstWhere(
  //   (element) => element.cityFrom == fromCity && element.cityTo == toCity,
  //);
  bool get isLoading => false;

  const SearchState({this.fromCity, this.toCity, this.departureDate});
}

// InitialState subClass
class InitialState extends SearchState {
  const InitialState({
    required super.fromCity,
    required super.toCity,
    required super.departureDate,
  });

  @override
  List<Object?> get props => [fromCity, toCity, departureDate];

  @override
  BusRoute? get route => null;
}

//LoadingSearchState subClass
class LoadingSearchState extends SearchState {
  final bool loading;
  const LoadingSearchState({
    required this.loading,
    super.fromCity,
    super.departureDate,
    super.toCity,
  });
  @override
  BusRoute? get route => null;
  @override
  bool get isLoading => loading;
  @override
  List<Object?> get props => [fromCity, toCity, departureDate];
}

// SuccessSearchState subClass
class SuccessSearchState extends SearchState {
  final BusRoute router;
  const SuccessSearchState({
    required this.router,
    required super.fromCity,
    required super.departureDate,
    required super.toCity,
  });
  @override
  BusRoute get route => router;

  @override
  List<Object?> get props => [fromCity, toCity, departureDate, route];
}

// ErrorSearchState subClass
class ErrorSearchState extends SearchState {
  final String message;
  const ErrorSearchState({
    required this.message,
    super.fromCity,
    super.departureDate,
    super.toCity,
  });

  @override
  List<Object?> get props => [fromCity, toCity, departureDate];

  @override
  BusRoute? get route => null;
}
