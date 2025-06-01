enum Sender { user, bot }

class ChatMessageModel {
  final String text;
  final Sender sender;

  ChatMessageModel({required this.text, required this.sender});
}
