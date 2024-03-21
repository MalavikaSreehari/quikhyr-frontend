part of 'most_rated_workers_bloc.dart';

sealed class MostRatedWorkersState extends Equatable {
  const MostRatedWorkersState();
  
  @override
  List<Object> get props => [];
}

final class MostRatedWorkersLoading extends MostRatedWorkersState {}

final class MostRatedWorkersLoaded extends MostRatedWorkersState {
  final List<WorkerModel> workers;
  const MostRatedWorkersLoaded(this.workers);
  
  @override
  List<Object> get props => [workers];
}

class MostRatedWorkersError extends MostRatedWorkersState {
  final String message;
  const MostRatedWorkersError(this.message);
  
  @override
  List<Object> get props => [message];
}
