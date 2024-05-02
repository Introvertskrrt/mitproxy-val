import 'package:flutter/material.dart';
import 'package:mitproxy_val/constants/textstyle_constant.dart';

class WaitingPage extends StatelessWidget {
  WaitingPage({super.key});

  final textStyleConstant = TextStyleConstant();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 150,
            height: 150,
            decoration: const BoxDecoration(
              color: Colors.transparent,
              image: DecorationImage(image: NetworkImage("https://i.imgur.com/0AXqK0O.png"),
                fit: BoxFit.fill
              ),
            ),
          ),
          Text( 
            "Valorant game client is not initialized in your computer, please enter the game",
            style: textStyleConstant.TextStyleInterBold(Colors.white, 18),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}