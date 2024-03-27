part of 'subservice_cubit.dart';

sealed class SubserviceState extends Equatable {
  const SubserviceState();

  @override
  List<Object> get props => [];
}


final class SubservicesLoading extends SubserviceState {}

final class SubservicesLoaded extends SubserviceState {
  final List<SubserviceModel> subservices;
  const SubservicesLoaded(this.subservices);

  @override
  List<Object> get props => [subservices];
}

final class SubservicesError extends SubserviceState {
  final String message;
  const SubservicesError(this.message);

  @override
  List<Object> get props => [message];
}