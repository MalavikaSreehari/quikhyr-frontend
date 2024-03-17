part of 'search_bloc.dart';

sealed class SearchState extends Equatable {
  const SearchState();
  
  @override
  List<Object> get props => [];
}

final class SearchInitial extends SearchState {}
final class SearchLoading extends SearchState {}

final class SearchLoaded extends SearchState {
  final List<Map<String, String>> results;

  const SearchLoaded({required this.results});

  @override
  List<Object> get props => [results];
}

final class SearchEmpty extends SearchState {}
final class SearchError extends SearchState {}