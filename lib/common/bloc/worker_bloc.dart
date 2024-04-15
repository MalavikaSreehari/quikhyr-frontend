import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'worker_event.dart';
part 'worker_state.dart';

class WorkerBloc extends Bloc<WorkerEvent, WorkerState> {
  WorkerBloc() : super(WorkerInitial()) {
    on<WorkerEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
