import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quikhyr/features/home/data/repository/services_category_repo.dart';
import 'package:quikhyr/models/service_category_model.dart';

part 'services_category_event.dart';
part 'services_category_state.dart';

class ServicesBloc extends Bloc<ServicesEvent, ServicesState> {
  final ServicesRepo servicesRepo;
  ServicesBloc({required this.servicesRepo}) : super(ServicesLoading()) {
    on<LoadServices>((event, emit) async {
      emit(ServicesLoading());
      try {
        final servicesModelList = await servicesRepo.getServices();

        servicesModelList.fold(
          (error) =>
              emit(const ServicesError('Failed to load services category')),
          (list) => emit(ServicesLoaded(list)),
        );
      } catch (e) {
        emit(
            const ServicesError('Exception: Failed to load services category'));
      }
    });
  }
}
