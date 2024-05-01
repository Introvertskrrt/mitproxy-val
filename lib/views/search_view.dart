import 'package:flutter/material.dart';
import 'package:mitproxy_val/view_components/search_player/search_widget.dart';
import 'package:mitproxy_val/constants/color_constant.dart';
import 'package:mitproxy_val/constants/textstyle_constant.dart';

class SearchView extends StatelessWidget {
  SearchView({super.key});

  final textStyleConstant = TextStyleConstant();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.pageColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Search Player",
          style: textStyleConstant.TextStyleInterBold(Colors.black, 18),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SearchWidget()
            ],
          ),
        ),
      ),
    );
  }
}