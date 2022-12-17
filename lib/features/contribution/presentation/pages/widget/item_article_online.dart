import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:new_bakarbatu/features/contribution/presentation/bloc/download%20_video/download_video_bloc.dart';
import 'package:new_bakarbatu/shared/widgets/shimmer_loading_article.dart';
import 'package:new_bakarbatu/shared/widgets/shimmer_loading_image.dart';
import 'package:path_provider/path_provider.dart';

import '../../../data/models/article_response.dart';
import '../detail_video.dart';

class ItemArticleOnline extends StatelessWidget {
  final DataNewsroom dataNewsroom;

  const ItemArticleOnline({Key? key, required this.dataNewsroom}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF800000),
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          dataNewsroom.articleUrl.toString().contains('.mp4')
              ?
          Container(
            width: MediaQuery.of(context).size.width,
            height: 150,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
            ),
            child: BlocConsumer<DownloadVideoBloc, DownloadVideoState>(
                listener: (context, state){
                  if(state.status.isSuccess) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailVideo(fileName: state.fileVideoPath)
                        )
                    );
                  }
                },
                builder: (context, state){
                  if('${state.idLoading}' == '${dataNewsroom.idNewsroom}'){
                    if(state.status.isLoading){
                      return Stack(
                        children: [
                          const Center(
                            child: SizedBox(
                              width: 70,
                              height: 70,
                              child: CircularProgressIndicator(),
                            ),
                          ),
                          Center(
                            child: Text(state.progress ?? '-'   ),
                          )
                        ],
                      );
                    }else {
                      return MaterialButton(
                        onPressed: (){
                          BlocProvider.of<DownloadVideoBloc>(context).add(DownloadVideo(urlVideo: '${dataNewsroom.articleUrl}', idArticle: '${dataNewsroom.idNewsroom}'));
                        },
                        child: const Icon(Icons.play_circle_outline_outlined, color: Colors.red,),
                      );
                    }
                  }
                  return MaterialButton(
                    onPressed: (){
                      BlocProvider.of<DownloadVideoBloc>(context).add(DownloadVideo(urlVideo: '${dataNewsroom.articleUrl}', idArticle: '${dataNewsroom.idNewsroom}'));
                    },
                    child: const Icon(Icons.play_circle_outline_outlined, color: Colors.red,),
                  );
                }
            )
          )
              :
          ClipRRect(
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
                child: CachedNetworkImage(
                imageUrl: '${dataNewsroom.articleUrl}',
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
                height: 150,
                width: MediaQuery.of(context).size.width,
                placeholder: (context, url){
                  return const Center(
                    child: ShimmerLoadingImage()
                  );
                },
              )
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
