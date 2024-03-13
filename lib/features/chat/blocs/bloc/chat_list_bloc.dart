import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quikhyr/features/chat/data/chat_repo.dart';
import 'package:quikhyr/models/chat_model.dart';

part 'chat_list_event.dart';
part 'chat_list_state.dart';

class ChatListBloc extends Bloc<ChatListEvent, ChatListState> {
  final ChatRepository chatRepository;
  StreamSubscription? _chatsSubscription;
  ChatListBloc({required this.chatRepository}) : super(ChatListLoading()) {
    on<LoadChats>(_mapLoadChatsToState);
    on<ChatUpdated>(_mapChatUpdatedToState);
  }

  Future<void> _mapLoadChatsToState(
      LoadChats event, Emitter<ChatListState> emit) async {
    _chatsSubscription?.cancel();
    _chatsSubscription = chatRepository.getChats().listen((chats) {
      add(ChatUpdated(chats));
    }, onError: (error) {
      emit(ChatListError(error.toString()));
    });
  }

  void _mapChatUpdatedToState(ChatUpdated event, Emitter<ChatListState> emit) {
    emit(ChatListLoaded(event.chats));
  }

  @override
  Future<void> close() {
    _chatsSubscription?.cancel();
    return super.close();
  }
}
