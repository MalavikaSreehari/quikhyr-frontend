import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quikhyr/features/home/data/repository/subservices_repo.dart';
import 'package:quikhyr/models/sub_service_category_model.dart';

part 'subservice_state.dart';

class SubserviceCubit extends Cubit<SubserviceState> {
  final SubservicesRepo _subservicesRepo;
  SubserviceCubit(this._subservicesRepo) : super(SubservicesLoading());
  void fetchSubservices (String serviceId) async{
    final result = await _subservicesRepo.getServices(serviceId);
    result.fold(
      (error) => emit(SubservicesError(error)),
      (subservices) => emit(SubservicesLoaded(subservices)),
    );
  }
}
