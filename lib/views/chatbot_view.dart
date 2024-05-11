import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mitproxy_val/constants/color_constant.dart';
import 'package:mitproxy_val/constants/textstyle_constant.dart';
import 'package:mitproxy_val/controllers/chatbot_controller.dart';

class ChatBotView extends StatelessWidget {
  ChatBotView({super.key});

  final chatbotController = Get.put(ChatBotController());
  final textStyleConstant = TextStyleConstant();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.pageColor,
      appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(
              "KAY/O AI",
              style: textStyleConstant.TextStyleInterBold(Colors.black, 18),
            ),
          ),
      body: GetBuilder<ChatBotController>(
        builder: (controller) {
          return DashChat(
            inputOptions: InputOptions(
              inputToolbarStyle: const BoxDecoration(
                color: Colors.white
              ),
              sendButtonBuilder: (Function() sendMessage) {
                return IconButton(
                  icon: const Icon(Icons.send),
                  color: Colors.blue, // Set your desired send button color here
                  onPressed: sendMessage,
                );
              },
            ),
            messageOptions: const MessageOptions(
              showTime: true,
              textColor: Colors.black,
              containerColor: Colors.white,

              currentUserContainerColor: Colors.blue,
              currentUserTextColor: Colors.white,
            ),
            typingUsers: controller.typing,
            currentUser: controller.muself,
            onSend: (ChatMessage m) {
              controller.sendMessage(m);
            },
            messages: controller.allMessages,
            
          );
        },
      ),
    );
  }
}