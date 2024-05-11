// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:get/get.dart';

class ChatBotController extends GetxController {
  ChatUser muself = ChatUser(id: "1", firstName: "Agent");
  ChatUser bot = ChatUser(id: "2", firstName: "KAY/O", profileImage: "assets/kayo_potrait.png");
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
        String msg_response = result["candidates"][0]["content"]["parts"][0]["text"];
        
        // Clean up the response
        msg_response = msg_response.replaceAll(RegExp(r'<[^>]*>'), ''); // Remove HTML-like tags
        msg_response = msg_response.replaceAll('* ', '- '); // Replace asterisks with hyphens
        
        ChatMessage m1 = ChatMessage(
          user: bot,
          createdAt: DateTime.now(),
          text: msg_response,
        );
        allMessages.insert(0, m1);

        // if token reached max limit
      } else if (value.statusCode == 429){
        ChatMessage m1 = ChatMessage(
          user: bot,
          createdAt: DateTime.now(),
          text: "Limit request has been reached, please try again later...",
        );
        allMessages.insert(0, m1);
      }
    }).catchError((e) {});

    typing.remove(bot);
    update();
  }
}