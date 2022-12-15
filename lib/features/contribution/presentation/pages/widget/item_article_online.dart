import 'package:flutter/material.dart';

import '../../../data/models/article_response.dart';

class ItemArticleOnline extends StatelessWidget {
  final DataNewsroom dataNewsroom;

  const ItemArticleOnline({Key? key, required this.dataNewsroom}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('URL IMAGE : ${dataNewsroom.articleUrl}');
    return Container(
      color: const Color(0xFF800000),
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
              child: Image.network('${dataNewsroom.articleUrl}')
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
                  child: Text('${dataNewsroom.title}', style: const TextStyle(color: Colors.black54, fontSize: 18, fontWeight: FontWeight.bold),),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 10, bottom: 10),
                  child: Text(dataNewsroom.nameEditor ?? 'Private Author', style: const TextStyle(color: Colors.black54),),
                ),
                Padding(
                    padding: const EdgeInsets.only(left: 20, right: 10, bottom: 10),
                    child: Row(
                      children: [
                        Text('${dataNewsroom.saved}', style: const TextStyle(color: Color(0xFFC7C7C7)),),
                        const SizedBox(width: 8,),
                        Text('${dataNewsroom.categoryName}', style: const TextStyle(color: Color(0xFFC7C7C7)),),
                      ],
                    )
                ),
                // Padding(
                //     padding: const EdgeInsets.only(left: 20, right: 10, bottom: 10),
                //     child: Row(
                //       children: [
                //         Expanded(
                //           child: Text('${dataNewsroom.} - ${contributionArticle.tagKampung} - ${contributionArticle.tagKabupaten}', style: const TextStyle(color: Color(0xFFC7C7C7)),),
                //         )
                //       ],
                //     )
                // ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 10, bottom: 10),
                  child: Text('${dataNewsroom.description}', style: const TextStyle(color: Colors.black54)),
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
