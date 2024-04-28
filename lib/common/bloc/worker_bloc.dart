import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

import '../../models/worker_model.dart';
import '../repo/worker_repo.dart';

part 'worker_event.dart';
part 'worker_state.dart';

class WorkerBloc extends Bloc<WorkerEvent, WorkerState> {
  final WorkerRepo workerRepository;
  WorkerBloc({required this.workerRepository,})
      : super(WorkerInitial()) {
    on<FetchWorker>(_onFetchWorker);
    }

  FutureOr<void> _onFetchWorker(
      FetchWorker event, Emitter<WorkerState> emit) async {
    final workerResult = await workerRepository.getWorker(workerId: event.workerId);
    workerResult.fold(
      (error) => emit(WorkerError(error: error)),
      (worker) => emit(WorkerLoaded(worker: worker)),
    );
  }
}
