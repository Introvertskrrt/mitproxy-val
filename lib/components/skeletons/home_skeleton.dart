import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mitproxy_val/constants/color_constant.dart';
import 'package:mitproxy_val/constants/shimmer_container.dart';

class HomeSkeleton extends StatelessWidget {
  const HomeSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: ShimmerContainer(width: 80, height: 16, radius: 1),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: ColorConstant.pageColor2
            ),
            child: const Column(
              children: [
                ShimmerContainer(width: double.infinity, height: 130, radius: 10),
                SizedBox(height: 20),
                Center(child: ShimmerContainer(width: 150, height: 14, radius: 10)),
                SizedBox(height: 20),
                Center(child: ShimmerContainer(width: 100, height: 14, radius: 10)),
                SizedBox(height: 30),
                Center(child: ShimmerContainer(width: 90, height: 90, radius: 180)),
                SizedBox(height: 20),
                Center(child: ShimmerContainer(width: 80, height: 16, radius: 10)),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ShimmerContainer(width: 60, height: 16, radius: 10),
                    ShimmerContainer(width: 60, height: 16, radius: 10),
                  ],
                ),
                SizedBox(height: 30),
                ShimmerContainer(width: double.infinity, height: 200, radius: 10),
                SizedBox(height: 10),
              ],
            ),
          )
          
        ],
      ),
    );
  }
}
