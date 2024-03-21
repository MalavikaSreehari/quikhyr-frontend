part of 'most_rated_workers_bloc.dart';

sealed class MostRatedWorkersEvent extends Equatable {
  const MostRatedWorkersEvent();

  @override
  List<Object> get props => [];
}

class FetchMostRatedWorkers extends MostRatedWorkersEvent {}
