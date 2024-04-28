part of 'worker_bloc.dart';

@immutable
sealed class WorkerEvent {}

class FetchWorker extends WorkerEvent {
  final String workerId;
  FetchWorker({required this.workerId});
}

class FetchInitiated extends WorkerEvent {}