part of 'services_category_bloc.dart';

sealed class ServicesCategoryEvent extends Equatable {
  const ServicesCategoryEvent();

  @override
  List<Object> get props => [];
}

class LoadServicesCategories extends ServicesCategoryEvent {}
