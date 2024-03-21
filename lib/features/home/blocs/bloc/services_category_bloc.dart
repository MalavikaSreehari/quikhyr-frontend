import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quikhyr/features/home/data/repository/services_category_repo.dart';
import 'package:quikhyr/models/service_category_model.dart';

part 'services_category_event.dart';
part 'services_category_state.dart';

class ServicesCategoryBloc
    extends Bloc<ServicesCategoryEvent, ServicesCategoryState> {
      final ServicesCategoryRepo servicesCategoryRepo;
  ServicesCategoryBloc({required this.servicesCategoryRepo}) : super(ServicesCategoryLoading()) {
    on<LoadServicesCategories>((event, emit) async {
      emit(ServicesCategoryLoading());
      try {
        final servicesCategoryModelList = await servicesCategoryRepo.getServicesCategory();
        emit(ServicesCategoryLoaded(servicesCategoryModelList));
      } catch (e) {
        emit(const ServicesCategoryError('Failed to load services category'));
      }
    });
  }
}

