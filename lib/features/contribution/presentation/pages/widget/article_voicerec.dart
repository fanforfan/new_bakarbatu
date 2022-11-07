import 'package:flutter/material.dart';

class ArticleVoiceRec extends StatefulWidget {
  const ArticleVoiceRec({super.key});

  @override
  State<ArticleVoiceRec> createState() => _ArticleVoiceRecState();
}

class _ArticleVoiceRecState extends State<ArticleVoiceRec> {
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
          Image.asset('assets/icons/ic_mic.png'),
          const SizedBox(height: 16,),
          const Text('Add Voice'),
        ],
      ),
    );
  }
}