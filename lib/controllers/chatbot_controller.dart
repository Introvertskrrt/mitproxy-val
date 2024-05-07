import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:get/get.dart';

class ChatBotController extends GetxController {
  ChatUser muself = ChatUser(id: "1", firstName: "SHARJEEL");
  ChatUser bot = ChatUser(id: "2", firstName: "Gemini");
  List<ChatMessage> allMessages = [];
  List<ChatUser> typing = [];

  final geminiAPI = "https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=${dotenv.env['GEMINI_KEY']}";
  final header = {
    'Content-Type': 'application/json'
  };

  void sendMessage(ChatMessage m) async {
    typing.add(bot);
    allMessages.insert(0, m);
    update();

    var data = {
      "contents": [{"parts": [{"text": m.text}]}]
    };

    await http.post(Uri.parse(geminiAPI), headers: header, body: jsonEncode(data)).then((value) {
      if (value.statusCode == 200) {
        var result = jsonDecode(value.body);
        ChatMessage m1 = ChatMessage(
          user: bot,
          createdAt: DateTime.now(),
          text: result["candidates"][0]["content"]["parts"][0]["text"],
        );
        allMessages.insert(0, m1);

        // if token reached max limit
      } else if (value.statusCode == 429){
        ChatMessage m1 = ChatMessage(
          user: bot,
          createdAt: DateTime.now(),
          text: "Limit request has reached, please try again later...",
        );
        allMessages.insert(0, m1);
      }
    }).catchError((e) {});

    typing.remove(bot);
    update();
  }
}