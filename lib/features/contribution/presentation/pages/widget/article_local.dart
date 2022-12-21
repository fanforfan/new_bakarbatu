import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:new_bakarbatu/features/contribution/presentation/pages/widget/item_article_local.dart';

import '../../bloc/article/article_bloc.dart';

class ArticleLocal extends StatefulWidget {
  const ArticleLocal({Key? key}) : super(key: key);

  @override
  State<ArticleLocal> createState() => _ArticleLocalState();
}

class _ArticleLocalState extends State<ArticleLocal> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ArticleBloc, ArticleState>(
      bloc: BlocProvider.of<ArticleBloc>(context)..add(GetArticle(statusArticle: 0)),
      builder: (context, state){
        if(state.status.isLoading){
          return const Center(
            child: CircularProgressIndicator(),
          );
        }else{
          if(state.article != null && state.article!.isNotEmpty){
            return SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(bottom: 50),
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.article!.length,
                  itemBuilder: (context, index){
                    return ItemArticleLocal(contributionArticle: state.article![index]);
                  },
                ),
              ),
            );
          }else{
            return Container(
              color: const Color(0xFF800000),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset('assets/images/empty_image.svg', width: 80.0,),
                    const Text("Empty Data", style: TextStyle(color: Colors.white),),
                  ],
                ),
              ),
            );
          }
        }
      },
    );
  }
}
