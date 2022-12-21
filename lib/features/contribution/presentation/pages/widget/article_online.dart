import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:new_bakarbatu/features/contribution/presentation/pages/widget/item_article_online.dart';
import 'package:new_bakarbatu/shared/widgets/shimmer_loading_article.dart';

import '../../../../../shared/widgets/reguler_text_form_field.dart';
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
          return ListView.builder(
            itemCount: 4,
            itemBuilder: (context, index) {
              return const ShimmerLoadingArticle();
            },
          );
        }
        else{
          if(state.articleOnline != null && state.articleOnline!.isNotEmpty){
            return Stack(
              children: [
                state.isSearch != null ? state.isSearch!
                    /// SEARCH LIST
                    ? Container(
                  padding: const EdgeInsets.only(top: 77),
                  color: const Color(0xFF800000),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemCount: state.articleSearchResult!.length,
                    itemBuilder: (context, index){
                      return ItemArticleOnline(
                        dataNewsroom: state.articleSearchResult![index],
                      );
                    },
                  ),
                )
                    /// DEFAULT LIST
                    : Container(
                  padding: const EdgeInsets.only(top: 77),
                  color: const Color(0xFF800000),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemCount: state.articleOnline!.length+1,
                    itemBuilder: (context, index){
                      return (index == (state.articleOnline!.length))
                          ? MaterialButton(
                        onPressed: (){
                          BlocProvider.of<ArticleBloc>(context).add(GetNextArticle());
                        },
                        child: Container(
                          width: 100.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.red
                          ),
                          margin: const EdgeInsets.only(bottom: 60,top: 10),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text('Show more', style: TextStyle(color: Colors.white, fontSize: 10),),
                                Icon(Icons.arrow_downward, color: Colors.white, size: 15,)
                              ],
                            ),
                          ),
                        ),
                      )
                          : ItemArticleOnline(
                        dataNewsroom: state.articleOnline![index],
                      );
                    },
                  ),
                )
                    : Container(
                  padding: const EdgeInsets.only(top: 77),
                  color: const Color(0xFF800000),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemCount: state.articleOnline!.length+1,
                    itemBuilder: (context, index){
                      return (index == (state.articleOnline!.length))
                          ? MaterialButton(
                        onPressed: (){
                          BlocProvider.of<ArticleBloc>(context).add(GetNextArticle());
                        },
                        child: Container(
                          width: 100.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.red
                          ),
                          margin: const EdgeInsets.only(bottom: 60,top: 10),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text('Show more', style: TextStyle(color: Colors.white, fontSize: 10),),
                                Icon(Icons.arrow_downward, color: Colors.white, size: 15,)
                              ],
                            ),
                          ),
                        ),
                      )
                          : ItemArticleOnline(
                        dataNewsroom: state.articleOnline![index],
                      );
                    },
                  ),
                ),
                /// SEARCH WIDGET
                Container(
                  padding: const EdgeInsets.only(left: 23, right: 23, top: 20),
                  child: TextFormField(
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.black12,
                        prefixIcon: const Icon(Icons.search, size: 18, color: Colors.white,),
                        labelText: 'Cari',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelStyle: const TextStyle(color: Colors.white, fontSize: 12)
                    ),
                    style: const TextStyle(color: Colors.white),
                    onChanged: (value){
                      BlocProvider.of<ArticleBloc>(context).add(SearchArticle(keySearch: value));
                    },
                  )
                )
              ],
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
