import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quikhyr/common/data/repositories/client_repo.dart';
import 'package:quikhyr/features/auth/data/repository/firebase_user_repo.dart';
import 'package:quikhyr/models/location_model.dart';
import 'package:quikhyr/models/client_model.dart';

part 'client_state.dart';
part 'client_event.dart';

class ClientBloc extends Bloc<ClientEvent, ClientState> {
  final ClientRepo clientRepo;
  final FirebaseUserRepo firebaseUserRepo;

  ClientBloc({required this.clientRepo, required this.firebaseUserRepo})
      : super(ClientInitial()) {
    on<FetchClient>(_onFetchClient);
    on<UpdatePincode>(_onUpdatePincode);
  }

  FutureOr<void> _onFetchClient(
      FetchClient event, Emitter<ClientState> emit) async {
    final String clientId = await firebaseUserRepo.getCurrentUserId();
    final clientResult = await clientRepo.getClient(clientId: clientId);
    clientResult.fold(
      (error) => emit(ClientError(error: error)),
      (client) => emit(ClientLoaded(client: client)),
    );
  }

  FutureOr<void> _onUpdatePincode(UpdatePincode event, Emitter<ClientState> emit) async{
    emit(PincodeUpdating());
    final String clientId = await firebaseUserRepo.getCurrentUserId();
    final clientResult = await clientRepo.updateClientPincode(clientId: clientId, pincode: event.newPincode);
    clientResult.fold(
      (error) => emit(PincodeUpdatedError(error: error)),
      (client) => add(FetchClient()),
    );
  }
}
