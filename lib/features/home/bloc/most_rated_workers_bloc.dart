import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../data/repository/most_rated_workers_repo.dart';
import '../../../models/worker_model.dart';

part 'most_rated_workers_event.dart';
part 'most_rated_workers_state.dart';

class MostRatedWorkersBloc
    extends Bloc<MostRatedWorkersEvent, MostRatedWorkersState> {
  final MostRatedWorkersRepo repo;
  MostRatedWorkersBloc({required this.repo}) : super(MostRatedWorkersLoading()) {
    on<FetchMostRatedWorkers>((event, emit) async {
      emit(MostRatedWorkersLoading());
      final result = await repo.getMostRatedWorkers();
      // l means failure and r means success
      result.fold((l) {
        emit(MostRatedWorkersError(l));
      }, (r) {
        emit(MostRatedWorkersLoaded(r));
      });
    });
  }
}
