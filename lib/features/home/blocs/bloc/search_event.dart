part of 'search_bloc.dart';

sealed class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class SearchStarted extends SearchEvent {
  final String query;

  const SearchStarted({required this.query});

  @override
  List<Object> get props => [query];

}

class SearchCleared extends SearchEvent {
  const SearchCleared();
}

