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
              image: DecorationImage(image: NetworkImage("https://cdn.discordapp.com/attachments/1127494450030051349/1230202405489086595/valorant-logo-play-2-svgrepo-com.png?ex=66327645&is=66200145&hm=b7953d3be8beb333e4e9c85fc7553d5ae56ee56f0c1fdaea77b0a7395416c4f6&"),
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