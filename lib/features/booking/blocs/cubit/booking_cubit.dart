import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:quikhyr/features/booking/repository/booking_repository.dart';
import 'package:quikhyr/models/booking_model.dart';
import 'package:quikhyr/models/simple_booking_model.dart';

part 'booking_state.dart';

class BookingCubit extends Cubit<BookingState> {
  BookingCubit() : super(BookingInitial());
  void getBookingsById() async {
    emit(BookingLoading());
    final response = await BookingRepository()
        .getBookingsById(FirebaseAuth.instance.currentUser!.uid);
    response.fold((l) => emit(BookingError(l)), (r) {
      debugPrint(r.currentBookings.toString());
      debugPrint(r.pastBookings.toString());
      return emit(BookingLoaded(r));
    });
  }
}
