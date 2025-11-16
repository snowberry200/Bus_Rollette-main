part of 'search_bloc.dart';

@immutable
abstract class SearchEvent extends Equatable {
  bool get isLoading => false;
  BusRoute? get route => null;
}

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
  final BusRoute eRoute;
  // Constructor
  SearchButtonPressedEvent({required this.eRoute});
  @override
  List<Object?> get props => [];
  @override
  bool get isLoading => true;
  @override
  BusRoute get route => eRoute;
}
