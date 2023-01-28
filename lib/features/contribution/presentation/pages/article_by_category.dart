import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:new_bakarbatu/features/contribution/presentation/bloc/article_category/article_category_bloc.dart';

import 'widget/item_article_online.dart';

class ArticleByCategory extends StatefulWidget {
  final int category;

  const ArticleByCategory({Key? key, required this.category}) : super(key: key);

  @override
  State<ArticleByCategory> createState() => _ArticleByCategoryState();
}

class _ArticleByCategoryState extends State<ArticleByCategory> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.category == 0){
      BlocProvider.of<ArticleCategoryBloc>(context).add(const GetArticleOnline(category: 0));
    }else if(widget.category == 1){
      BlocProvider.of<ArticleCategoryBloc>(context).add(const GetArticleOnline(category: 1));
    }else{
      BlocProvider.of<ArticleCategoryBloc>(context).add(const GetArticleOnline(category: 2));
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF800000),
      appBar: AppBar(
        title: Text(widget.category == 0 ? 'Total Konten' : widget.category == 1 ? 'Approve' : 'Waiting Editor'),
      ),
      body: BlocBuilder<ArticleCategoryBloc, ArticleCategoryState>(
        builder: (context, state){
          if(state.allArticleOnline != null){
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
                          fromCategory: true
                        );
                      },
                    ),
                  )
                  /// RESET SEARCH
                      : Container(
                    padding: const EdgeInsets.only(top: 50),
                    color: const Color(0xFF800000),
                    child: state.articleOnline != null
                        ? ListView.builder(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemCount: state.articleOnline!.length+1,
                      itemBuilder: (context, index){
                        return (index == (state.articleOnline!.length))
                            ?
                        (((state.allArticleOnline!.length) != index) ? MaterialButton(
                          onPressed: (){
                            BlocProvider.of<ArticleCategoryBloc>(context).add(const GetNextArticle());
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
                        ) : const SizedBox(height: 50,))
                            : ItemArticleOnline(
                          index: index,
                          dataNewsroom: state.articleOnline![index],
                          fromCategory: true
                        );
                      },
                    )
                        : _emptyData(),
                  )
                  /// DEFAULT LIST
                      : Container(
                    padding: const EdgeInsets.only(top: 10),
                    color: const Color(0xFF800000),
                    child: state.articleOnline != null
                        ? ListView.builder(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemCount: state.articleOnline!.length+1,
                      itemBuilder: (context, index){
                        return (index == (state.articleOnline!.length))
                            ?
                        (((state.allArticleOnline!.length) != index) ? MaterialButton(
                          onPressed: (){
                            BlocProvider.of<ArticleCategoryBloc>(context).add(const GetNextArticle());
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
                        ) : const SizedBox(height: 50,))
                            :
                        ItemArticleOnline(
                          index: index,
                          dataNewsroom: state.articleOnline![index],
                          fromCategory: true
                        );
                      },
                    )
                        : _emptyData(),
                  ),
                  /// SEARCH WIDGET
                  Container(
                      padding: const EdgeInsets.only(left: 23, right: 23, top: 10),
                      child: TextFormField(
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.black12,
                            prefixIcon: const Icon(Icons.search, size: 18, color: Colors.white,),
                            labelText: 'Cari',
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: Colors.white
                                )
                            ),
                            labelStyle: const TextStyle(color: Colors.white, fontSize: 12)
                        ),
                        style: const TextStyle(color: Colors.white),
                        onChanged: (value){
                          BlocProvider.of<ArticleCategoryBloc>(context).add(SearchArticleCategory(keySearch: value));
                        },
                      )
                  )
                ],
              );
            }else{
              return _emptyData();
            }
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _emptyData(){
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
