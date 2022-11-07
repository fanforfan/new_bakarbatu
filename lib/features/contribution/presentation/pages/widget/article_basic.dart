import 'package:flutter/material.dart';

class ArticleBasic extends StatefulWidget {
  const ArticleBasic({super.key});

  @override
  State<ArticleBasic> createState() => _ArticleBasicState();
}

class _ArticleBasicState extends State<ArticleBasic> {
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
          Image.asset('assets/icons/ic_article.png'),
          const SizedBox(height: 16,),
          const Text('Add Article'),
        ],
      ),
    );
  }
}