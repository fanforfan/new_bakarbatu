import 'package:flutter/material.dart';

class ArticleFoto extends StatefulWidget {
  const ArticleFoto({super.key});

  @override
  State<ArticleFoto> createState() => _ArticleFotoState();
}

class _ArticleFotoState extends State<ArticleFoto> {
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
          Image.asset('assets/icons/ic_fotoimage.png'),
          const SizedBox(height: 16,),
          const Text('Add Foto'),
        ],
      ),
    );
  }
}