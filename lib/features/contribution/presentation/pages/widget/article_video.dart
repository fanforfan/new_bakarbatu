import 'package:flutter/material.dart';

class ArticleVideo extends StatefulWidget {
  const ArticleVideo({super.key});

  @override
  State<ArticleVideo> createState() => _ArticleVideoState();
}

class _ArticleVideoState extends State<ArticleVideo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16))
      ),
      height: MediaQuery.of(context).size.height - 50,
      child: ListView(
        children: [
          Image.asset('assets/icons/ic_video.png'),
          const SizedBox(height: 16,),
          const Text('Add Video'),
        ],
      ),
    );
  }
}