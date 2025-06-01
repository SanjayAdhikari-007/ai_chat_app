import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

import '../../domain/repository/chat_repository.dart';

class ChatRepositoryImpl extends ChatRepository {
  final GenerativeModel _model;

  ChatRepositoryImpl()
      : _model = GenerativeModel(
          model: 'gemini-1.5-flash-latest',
          apiKey: dotenv.env['GEMINI_API_KEY']!,
        );

  @override
  Future<String> sendMessage(String message) async {
    final content = [Content.text(message)];
    final response = await _model.generateContent(content);
    return response.text ?? "No response from Gemini.";
  }
}

// import 'dart:convert';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:http/http.dart' as http;

// import '../../domain/repository/chat_repository.dart';

// /// ChatRepository Implementation for OpenAI ChatGPT model gpt-3.5 turbo
// class ChatRepositoryImpl extends ChatRepository {
//   final String _endpoint = 'https://api.openai.com/v1/chat/completions';
//   final String _model = 'gpt-3.5-turbo';

//   @override
//   Future<String> sendMessage(String message) async {
//     print(dotenv.env['OPENAI_API_KEY']);
//     final response = await http.post(
//       Uri.parse(_endpoint),
//       headers: {
//         'Authorization': 'Bearer ${dotenv.env['OPENAI_API_KEY']}',
//         'Content-Type': 'application/json',
//       },
//       body: jsonEncode({
//         "model": _model,
//         "messages": [
//           {"role": "user", "content": message}
//         ]
//       }),
//     );

//     if (response.statusCode == 200) {
//       final decoded = jsonDecode(response.body);
//       print(decoded);
//       return decoded['choices'][0]['message']['content'];
//     } else {
//       print('Status Code: ${response.statusCode}');
//       print('Response Body: ${response.body}');
//       throw Exception('Failed to load AI response');
//     }
//   }
// }
