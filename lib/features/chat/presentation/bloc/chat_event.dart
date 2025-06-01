part of 'chat_bloc.dart';

sealed class ChatEvent {}

class SendMessageEvent extends ChatEvent {
  final String userMessage;

  SendMessageEvent(this.userMessage);
}
