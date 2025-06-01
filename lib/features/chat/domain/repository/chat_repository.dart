abstract class ChatRepository {
  /// Send Message to AI Server.
  Future<String> sendMessage(String message);
}
