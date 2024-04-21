import 'package:flutter/material.dart';

class LoadingDialogConstant extends StatelessWidget {
  const LoadingDialogConstant({super.key});

  @override
  Widget build(BuildContext context) {
    return const Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Center(
        child: CircularProgressIndicator(), // Or any other loading indicator widget
      ),
    );
  }
}


