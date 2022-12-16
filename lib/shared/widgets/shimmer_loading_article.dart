import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoadingArticle extends StatelessWidget {
  const ShimmerLoadingArticle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20),
      margin: const EdgeInsets.only(bottom: 20),
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
            const SizedBox(height: 2,),
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                color: Colors.white,
              ),
              height: 50.0,
              width: double.infinity,
            ),
          ],
        ),
      ),
    );
  }
}
