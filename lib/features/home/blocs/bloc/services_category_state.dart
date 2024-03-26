part of 'services_category_bloc.dart';

sealed class ServicesState extends Equatable {
  const ServicesState();

  @override
  List<Object> get props => [];
}

final class ServicesLoading extends ServicesState {}

final class ServicesLoaded extends ServicesState {
  final List<ServiceModel> servicesCategory;
  const ServicesLoaded(this.servicesCategory);

  @override
  List<Object> get props => [servicesCategory];
}

final class ServicesError extends ServicesState {
  final String message;
  const ServicesError(this.message);

  @override
  List<Object> get props => [message];
}
