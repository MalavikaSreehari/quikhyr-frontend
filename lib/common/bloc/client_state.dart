part of 'client_bloc.dart';

@immutable
sealed class ClientState {}
sealed class PincodeState extends ClientState{}
final class ClientInitial extends ClientState {}

final class ClientLoading extends ClientState {}

final class ClientLoaded extends ClientState {
  final ClientModel client;

  ClientLoaded({required this.client});
}

final class ClientError extends ClientState {
  final String error;

  ClientError({required this.error});
}

final class PincodeUpdatedSuccess extends PincodeState {}

final class PincodeUpdatedError extends PincodeState {
  final String error;

  PincodeUpdatedError({required this.error});
}

final class PincodeUpdating extends PincodeState {}
