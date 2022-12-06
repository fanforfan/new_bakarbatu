import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_bakarbatu/features/contribution/presentation/pages/widget/item_article_online.dart';

import '../../bloc/article/article_bloc.dart';

class ArticleOnline extends StatefulWidget {
  const ArticleOnline({Key? key}) : super(key: key);

  @override
  State<ArticleOnline> createState() => _ArticleOnlineState();
}

class _ArticleOnlineState extends State<ArticleOnline> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ArticleBloc, ArticleState>(
      bloc: BlocProvider.of<ArticleBloc>(context)..add(GetArticle(statusArticle: 1)),
      builder: (context, state){
        if(state.status.isLoading){
          return const Center(
            child: CircularProgressIndicator(),
          );
        }else{
          if(state.articleOnline != null && state.articleOnline!.isNotEmpty){
            return Container(
              color: const Color(0xFF800000),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemCount: state.articleOnline!.length,
                itemBuilder: (context, index){
                  return ItemArticleOnline(dataNewsroom: state.articleOnline![index]);
                },
              ),
            );
          }else{
            return Container(
              color: const Color(0xFF800000),
              child: const Center(
                child: Text("Empty Data"),
              ),
            );
          }
        }
      },
    );
  }
}
