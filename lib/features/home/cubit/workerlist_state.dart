part of 'workerlist_cubit.dart';

sealed class WorkerlistState extends Equatable {
  const WorkerlistState();

  @override
  List<Object> get props => [];
}

final class WorkerlistInitial extends WorkerlistState {}

final class WorkerlistLoading extends WorkerlistState {}

final class WorkerlistLoaded extends WorkerlistState {
  final List<WorkerModel> workers;

  const WorkerlistLoaded(this.workers);

  @override
  List<Object> get props => [workers];
}

final class WorkerlistError extends WorkerlistState {
  final String error;

  const WorkerlistError(this.error);

  @override
  List<Object> get props => [error];
}

final class WorkerlistDropDown extends WorkerlistState {}

final class WorkerlistDropDownLoading extends WorkerlistState {}

final class WorkerlistDropDownLoaded extends WorkerlistState {
  final List<WorkerModel> workers;

  const WorkerlistDropDownLoaded(this.workers);

  @override
  List<Object> get props => [workers];
}

final class WorkerlistDropDownError extends WorkerlistState {
  final String error;

  const WorkerlistDropDownError(this.error);

  @override
  List<Object> get props => [error];
}