import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quikhyr/features/home/data/repository/search_repo.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchRepo searchRepo;
  SearchBloc({required this.searchRepo}) : super(SearchInitial()) {
    on<SearchStarted>(_onSearchStarted);
  }

  FutureOr<void> _onSearchStarted(SearchStarted event, Emitter<SearchState> emit) {
    emit(SearchLoading());
    try{
      final results = searchRepo.search(event.query);
      emit(SearchLoaded(results: results));
    } catch (e) {
      emit(SearchError());
  }
}
}
