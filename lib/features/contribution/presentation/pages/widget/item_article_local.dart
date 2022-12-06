import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../../db/models/contribution_article_model.dart';
import '../detail_video.dart';

class ItemArticleLocal extends StatelessWidget {
  final ContributionArticle contributionArticle;

  const ItemArticleLocal({Key? key, required this.contributionArticle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF800000),
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          contributionArticle.jenisFile == 1
              ?
          ClipRRect(
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
              child: Image.file(File('${contributionArticle.filename}'))
          )
              :
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
            ),
            child: MaterialButton(
              onPressed: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetailVideo(fileName: contributionArticle.filename,)
                    )
                );
              },
              child: const Icon(Icons.play_circle_outline_outlined, color: Colors.red,),
            ),
          ),
          const SizedBox(height: 1),
          Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20))
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 10, top: 10, bottom: 8),
                  child: Text('${contributionArticle.judulIndonesia} ${contributionArticle.jenisFile}', style: const TextStyle(color: Colors.black54, fontSize: 18, fontWeight: FontWeight.bold),),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 10, bottom: 10),
                  child: Text(contributionArticle.hideAuthor! ? 'Publish Author' : 'Private Author', style: const TextStyle(color: Colors.black54),),
                ),
                Padding(
                    padding: const EdgeInsets.only(left: 20, right: 10, bottom: 10),
                    child: Row(
                      children: [
                        Text('${contributionArticle.timeSchedule}', style: const TextStyle(color: Color(0xFFC7C7C7)),),
                        const SizedBox(width: 8,),
                        Text('${contributionArticle.captionIndonesia}', style: const TextStyle(color: Color(0xFFC7C7C7)),),
                      ],
                    )
                ),
                Padding(
                    padding: const EdgeInsets.only(left: 20, right: 10, bottom: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text('${contributionArticle.tagDistrik} - ${contributionArticle.tagKampung} - ${contributionArticle.tagKabupaten}', style: const TextStyle(color: Color(0xFFC7C7C7)),),
                        )
                      ],
                    )
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 10, bottom: 10),
                  child: Text('${contributionArticle.deskripsiIndonesia}', style: const TextStyle(color: Colors.black54)),
                ),
                const SizedBox(height: 8,),
              ],
            ),
          ),
          const SizedBox(height: 20,)
        ],
      ),
    );
  }
}
