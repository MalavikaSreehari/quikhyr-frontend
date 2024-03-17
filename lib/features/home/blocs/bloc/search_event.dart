part of 'search_bloc.dart';

sealed class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class SearchStarted extends SearchEvent {
  final String query;

  const SearchStarted({required this.query});

}

