import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:get/get.dart';
import 'package:mitproxy_val/controllers/introduction_controller.dart';

class IntroductionView extends StatelessWidget {
  final IntroductionController introductionController = Get.put(IntroductionController());

  IntroductionView({super.key});

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);

    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introductionController.introKey,
      globalBackgroundColor: Colors.white,
      allowImplicitScrolling: true,
      infiniteAutoScroll: false,
      globalHeader: const Align(
        alignment: Alignment.topRight,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(top: 16, right: 16),
            child: Text(""),
          ),
        ),
      ),
      globalFooter: const SizedBox(
        width: double.infinity,
        height: 60,
        child: Center(
          child: Expanded(
            child: Text(
              '© 2024 Mitproxy Valorant, All Rights Reserved',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal),
            ),
          ),
        ),
      ),
      pages: [
        PageViewModel(
          title: "Welcome",
          body:
              "Mitproxy Valorant is a Powerful Mobile Valorant Tracker app with agent instalocker feature.",
          image: const Image(image: AssetImage('assets/jett.png')),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Disclaimer",
          body:
              "This project is strictly for educational purposes and is intended to enhance learning and understanding of software development concepts. It is not to be used for gaining any advantage in the game or for any unethical activities.",
          image: const Image(image: AssetImage('assets/raze.png')),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "About Vanguard Detection",
          body:
              "This app exclusively utilizes Riot Games' API for data access, unlike other desktop Valorant trackers that rely on accessing game memory. This approach ensures security and reliability, as it adheres to official guidelines and eliminates potential integrity issues. Additionally, by not running directly on users' computers, the app can deliver optimal performance and accessibility.",
          image: const Image(image: AssetImage('assets/vanguard.png'), height: 300,),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => introductionController.onIntroEnd(context),
      onSkip: () => introductionController.onIntroEnd(context),
      showSkipButton: false,
      skipOrBackFlex: 0,
      nextFlex: 0,
      showBackButton: true,
      back: const Icon(Icons.arrow_back, color: Colors.white,),
      skip: const Text('Skip', style: TextStyle(fontWeight: FontWeight.w600)),
      next: const Icon(Icons.arrow_forward, color: Colors.white,),
      done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white)),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color.fromARGB(255, 255, 255, 255),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
        activeColor: Colors.white
      ),
      dotsContainerDecorator: const ShapeDecoration(
        color: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );
  }
}
