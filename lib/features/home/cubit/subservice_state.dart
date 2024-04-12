part of 'subservice_cubit.dart';

abstract class SubserviceState extends Equatable {
  const SubserviceState();

  @override
  List<Object> get props => [];
}

class SubservicesLoading extends SubserviceState {}

class SubservicesLoaded extends SubserviceState {
  final List<SubserviceModel> subservices;
  final bool isSendServiceRequestSignalEnabled;

  const SubservicesLoaded({
    required this.subservices,
    this.isSendServiceRequestSignalEnabled = false,
  });

  SubservicesLoaded copyWith({
    List<SubserviceModel>? subservices,
    bool? isSendServiceRequestSignalEnabled,
  }) {
    return SubservicesLoaded(
      subservices: subservices ?? this.subservices,
      isSendServiceRequestSignalEnabled:
          isSendServiceRequestSignalEnabled ?? this.isSendServiceRequestSignalEnabled,
    );
  }

  @override
  List<Object> get props => [subservices, isSendServiceRequestSignalEnabled];
}

class SubservicesError extends SubserviceState {
  final String message;
  const SubservicesError(this.message);

  @override
  List<Object> get props => [message];
}
