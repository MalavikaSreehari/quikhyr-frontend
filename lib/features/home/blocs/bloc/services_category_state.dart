part of 'services_category_bloc.dart';

sealed class ServicesCategoryState extends Equatable {
  const ServicesCategoryState();

  @override
  List<Object> get props => [];
}

final class ServicesCategoryLoading extends ServicesCategoryState {}

final class ServicesCategoryLoaded extends ServicesCategoryState {
  final List<ServiceCategoryModel> servicesCategory;
  const ServicesCategoryLoaded(this.servicesCategory);

  @override
  List<Object> get props => [servicesCategory];
}

final class ServicesCategoryError extends ServicesCategoryState {
  final String message;
  const ServicesCategoryError(this.message);

  @override
  List<Object> get props => [message];
}
