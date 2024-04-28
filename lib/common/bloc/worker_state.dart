part of 'worker_bloc.dart';

@immutable
sealed class WorkerState {}

final class WorkerInitial extends WorkerState {}

final class WorkerLoading extends WorkerState {}

final class WorkerLoaded extends WorkerState {
  final WorkerModel worker;

  WorkerLoaded({required this.worker});
}
final class WorkerError extends WorkerState {
  final String error;

  WorkerError({required this.error});
}
