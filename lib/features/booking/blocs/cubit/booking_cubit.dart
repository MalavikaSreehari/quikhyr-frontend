import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:quikhyr/features/booking/repository/booking_repository.dart';
import 'package:quikhyr/models/booking_model.dart';
import 'package:quikhyr/models/simple_booking_model.dart';

part 'booking_state.dart';

class BookingCubit extends Cubit<BookingState> {
  BookingCubit() : super(BookingInitial());
    Future<void> getBookingsById() async {
    emit(BookingLoading());
    try {
      final result = await BookingRepository().getBookingsById(FirebaseAuth.instance.currentUser!.uid);
      result.fold(
        (failure) {
          debugPrint(failure);
          return emit(BookingError(failure));
        },
        
        (bookingData) => emit(BookingLoaded(bookingData)),
      );
    } catch (e) {
      emit(BookingError(e.toString()));
    }
  }
}