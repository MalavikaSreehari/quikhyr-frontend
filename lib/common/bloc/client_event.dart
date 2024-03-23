part of 'client_bloc.dart';

@immutable
sealed class ClientEvent {}

class UpdateLocation extends ClientEvent {
  final LocationModel newLocation;
  UpdateLocation(this.newLocation);
}

class UpdatePhone extends ClientEvent {
  final String newPhone;
  UpdatePhone(this.newPhone);
}

class UpdatePincode extends ClientEvent {
  final String newPincode;
  UpdatePincode(this.newPincode);
}

class AddWorker extends ClientEvent {
  final ClientModel worker;
  AddWorker(this.worker);
}

class FetchClient extends ClientEvent {}
