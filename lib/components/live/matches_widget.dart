import 'package:flutter/material.dart';
import 'package:mitproxy_val/constants/color_constant.dart';
import 'package:mitproxy_val/constants/textstyle_constant.dart';

class MatchesWidget extends StatelessWidget {
  MatchesWidget({super.key});

  final textStyleConstant = TextStyleConstant();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            "MATCHES",
            style: textStyleConstant.TextStyleInterNormal(Colors.black54, 14),
          ),
        ),
        Container( 
          width: double.infinity,
          height: 400,
          decoration: BoxDecoration(
            color: ColorConstant.pageColor2,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(

          ),

        ),
      ],
    );
  }
}