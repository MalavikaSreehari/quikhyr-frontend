part of 'search_bloc.dart';

sealed class SearchState extends Equatable {
  const SearchState();
  
  @override
  List<Object> get props => [];
}

final class SearchInitial extends SearchState {}
final class SearchLoading extends SearchState {}

final class SearchLoaded extends SearchState {
  final List<String> results;

  const SearchLoaded({required this.results});
}

final class SearchError extends SearchState {}