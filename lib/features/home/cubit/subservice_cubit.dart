import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../data/repository/subservices_repo.dart';
import '../../../models/sub_service_category_model.dart';

part 'subservice_state.dart';

class SubserviceCubit extends Cubit<SubserviceState> {
  final SubservicesRepo _subservicesRepo;
  SubserviceCubit(this._subservicesRepo) : super(SubservicesLoading());
  void fetchSubservices (String serviceId) async{
    final result = await _subservicesRepo.getServices(serviceId);
    result.fold(
      (error) => emit(SubservicesError(error)),
      (subservices) => emit(SubservicesLoaded(subservices: subservices)),
    );
  }
    void subserviceSelected(SubserviceModel subservice) {
    final currentState = state;
    if (currentState is SubservicesLoaded) {
      // Check if the selected subservice is not 'All'
      final isSendServiceRequestSignalEnabled = subservice.serviceName != 'All';
      // Emit a new state with the updated flag
      emit(currentState.copyWith(isSendServiceRequestSignalEnabled: isSendServiceRequestSignalEnabled));
    }
  }
}
