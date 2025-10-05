part of 'search_bloc.dart';

@immutable
abstract class SearchEvent extends Equatable {}

class FromCityChangeEvent extends SearchEvent {
  final String? fromCity;
  FromCityChangeEvent({this.fromCity});

  @override
  List<Object?> get props => [fromCity];
}

class ToCityChangeEvent extends SearchEvent {
  final String? toCity;
  ToCityChangeEvent({this.toCity});

  @override
  List<Object?> get props => [toCity];
}

class DateChangeEvent extends SearchEvent {
  final DateTime? departureDate;
  DateChangeEvent({required this.departureDate});

  @override
  List<Object?> get props => [departureDate];
}

class SearchButtonPressedEvent extends SearchEvent {
  final String? fromCity;
  final String? toCity;
  final DateTime? departureDate;
  final bool isLoading;
  final String? errorMessage;

  // Constructor
  SearchButtonPressedEvent({
    required this.fromCity,
    required this.toCity,
    required this.departureDate,
    required this.errorMessage,
    this.isLoading = true,
  });
  @override
  List<Object?> get props => [fromCity, toCity, departureDate, isLoading];
}
