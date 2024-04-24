import 'package:flutter/material.dart';

class LoadingDialogConstant extends StatelessWidget {
  const LoadingDialogConstant({super.key});

  @override
  Widget build(BuildContext context) {
    return const Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 10),
            Text(
              "Authenticating...",
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 16,
                color: Colors.white
              ),
            ),
          ],
        ), // Or any other loading indicator widget
      ),
    );
  }
}


