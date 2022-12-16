import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoadingImage extends StatelessWidget {
  const ShimmerLoadingImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Shimmer.fromColors(
        baseColor: Colors.grey,
        highlightColor: const Color(0xFFC2C2C2),
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                color: Colors.white,
              ),
              height: 100.0,
              width: double.infinity,
            ),
          ],
        ),
      ),
    );
  }
}
