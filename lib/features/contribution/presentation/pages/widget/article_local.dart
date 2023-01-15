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
            return Stack(
              children: [
                state.isSearchLocal != null ? state.isSearchLocal!
                    ?
                /// SEARCH RESULT
                Container(
                  padding: const EdgeInsets.only(top: 20),
                  color: const Color(0xFF800000),
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemCount: state.articleSearchResultLocal!.length,
                    itemBuilder: (context, index){
                      return ItemArticleLocal(
                          index: index,
                          contributionArticle: state.articleSearchResultLocal![index]);
                    },
                  ),
                )
                    :
                /// RESET SEARCH
                Container(
                  color: const Color(0xFF800000),
                  padding: const EdgeInsets.only(top: 20),
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemCount: state.article!.length+1,
                    itemBuilder: (context, index){
                      return index == state.article!.length
                          ?
                      (((state.allArticleLocal!.length) != index)
                          ? MaterialButton(
                        onPressed: (){
                          BlocProvider.of<ArticleBloc>(context).add(GetNextArticleLocal());
                        },
                        child: Container(
                          width: 100.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.red
                          ),
                          margin: const EdgeInsets.only(bottom: 120,top: 10),
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
                          : const SizedBox(height: 50,))
                          :
                      ItemArticleLocal(
                          index: index,
                          contributionArticle: state.article![index]);
                    },
                  ),
                )
                    :
                /// DEFAULT FIRST LOAD
                Container(
                  color: const Color(0xFF800000),
                  padding: const EdgeInsets.only(top: 20),
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemCount: state.article!.length+1,
                    itemBuilder: (context, index){
                      return index == state.article!.length
                          ?
                      (((state.allArticleLocal!.length) != index)
                          ? MaterialButton(
                        onPressed: (){
                          BlocProvider.of<ArticleBloc>(context).add(GetNextArticleLocal());
                        },
                        child: Container(
                          width: 100.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.red
                          ),
                          margin: const EdgeInsets.only(bottom: 120,top: 10),
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
                          : const SizedBox(height: 50,))
                          :
                      ItemArticleLocal(
                          index: index,
                          contributionArticle: state.article![index]
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
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: Colors.white
                              )
                          ),
                          labelStyle: const TextStyle(color: Colors.white, fontSize: 12)
                      ),
                      style: const TextStyle(color: Colors.white),
                      onChanged: (value){
                        BlocProvider.of<ArticleBloc>(context).add(SearchArticleLocal(keySearch: value));
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
