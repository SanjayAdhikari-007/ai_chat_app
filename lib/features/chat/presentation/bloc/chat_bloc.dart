import 'package:ai_chat_app/features/chat/data/models/chat_message_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repository/chat_repository_impl.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatRepositoryImpl repository;
  ChatBloc(this.repository) : super(ChatState(messages: [])) {
    on<SendMessageEvent>(_onSendMessage);
  }

  Future<void> _onSendMessage(
      SendMessageEvent event, Emitter<ChatState> emit) async {
    final userMsg =
        ChatMessageModel(text: event.userMessage, sender: Sender.user);
    final updatedMessages = List<ChatMessageModel>.from(state.messages)
      ..add(userMsg);

    emit(state.copyWith(messages: updatedMessages, isLoading: true));

    try {
      final botResponse = await repository.sendMessage(event.userMessage);
      final botMsg =
          ChatMessageModel(text: botResponse.trim(), sender: Sender.bot);
      final newMessages = List<ChatMessageModel>.from(updatedMessages)
        ..add(botMsg);

      emit(state.copyWith(messages: newMessages, isLoading: false));
    } catch (err) {
      print(err);
      final errorMsg = ChatMessageModel(
        text: "Oops! Failed to get response.",
        sender: Sender.bot,
      );
      emit(state.copyWith(
          messages: [...updatedMessages, errorMsg], isLoading: false));
    }
  }
}
