import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../data/repository/worker_list_repo.dart';
import '../../../models/worker_model.dart';

part 'workerlist_state.dart';

class WorkerlistCubit extends Cubit<WorkerlistState> {
  final WorkerListRepo _workerListRepo;
  WorkerlistCubit(this._workerListRepo) : super(WorkerlistInitial());
  void getWorkersByServiceId({required String serviceId}) async {
    emit(WorkerlistLoading());
    final workerList =
        await _workerListRepo.getWorkersByServiceId(serviceId);
    workerList.fold(
      (error) => emit(WorkerlistError(error)),
      (workers) => emit(WorkerlistLoaded(workers)),
    );
  }
  void getWorkersBySubserviceId({required String subserviceId}) async {
    emit(WorkerlistDropDownLoading());
    final workerList =
        await _workerListRepo.getWorkersBySubserviceId(subserviceId);
    workerList.fold(
      (error) => emit(WorkerlistDropDownError(error)),
      (workers) => emit(WorkerlistDropDownLoaded(workers)),
    );
  }
}
