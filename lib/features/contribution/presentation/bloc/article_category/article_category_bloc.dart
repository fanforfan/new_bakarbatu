import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../data/models/article_response.dart';
import '../../../domain/usecases/contribution_usecase.dart';

part 'article_category_event.dart';
part 'article_category_state.dart';

class ArticleCategoryBloc extends Bloc<ArticleCategoryEvent, ArticleCategoryState> {
  final ContributionUsecase contributionUsecase;

  ArticleCategoryBloc({required this.contributionUsecase}) : super(const ArticleCategoryState()) {
    on<GetArticleOnline>(_getArticle);
    on<SearchArticleCategory>(_seacrhArticle);
    on<GetNextArticle>(_getNextArticle);
  }

  _getArticle(GetArticleOnline event, Emitter<ArticleCategoryState> emit) async {
    emit(state.copyWith(
        status: ArticleStatus.loading
    ));
    List<DataNewsroom> listData = [];
    List<DataNewsroom> listAllData = [];
    try{
      var response = await contributionUsecase.getArticleOnline();
      if(response != null){
        if(response.isNotEmpty){

          if(event.category == 0){
            for(int i=0; i<response.length; i++){
              listAllData.add(response[i]);
            }
          }else if(event.category == 1){
            for(int i=0; i<response.length; i++){
              if(response[i].status == 'Approve'){
                listAllData.add(response[i]);
              }
            }
          }else{
            for(int i=0; i<response.length; i++){
              if(response[i].status == 'Need Editor'){
                listAllData.add(response[i]);
              }
            }
          }

          if(listAllData.isNotEmpty){
            if(listAllData.length < 4){
              for(int i=0; i<listAllData.length; i++){
                listData.add(listAllData[i]);
              }
            }else{
              for(int i=0; i<4; i++){
                listData.add(listAllData[i]);
              }
            }
          }
        }
      }
      emit(state.copyWith(
          page: 1,
          allArticleOnline: listAllData,
          articleOnline: listData,
          status: ArticleStatus.success
      ));
      debugPrint('HALO DATA : ${listAllData.length}');
    } catch (error) {
      debugPrint('ERROR GAESS : $error');
      emit(state.copyWith(
          status: ArticleStatus.error
      ));
    }
  }

  _seacrhArticle(SearchArticleCategory event, Emitter<ArticleCategoryState> emit) async {
      List<DataNewsroom> listData = [];
      print('KETUG KENE');
      if (event.keySearch != null && event.keySearch!.length > 2) {
        emit(state.copyWith(
            isSearch: true
        ));
        listData = state.articleOnline!.where((articleSearch) =>
            articleSearch.title!.toLowerCase().contains(event.keySearch!.toLowerCase()))
            .toList();
      } else {
        emit(state.copyWith(
            isSearch: false
        ));
      }
      emit(state.copyWith(
          articleSearchResult: listData
      ));
  }

  _getNextArticle(GetNextArticle event, Emitter<ArticleCategoryState> emit) async {
    List<DataNewsroom> listData = [];
    var firstIndex = state.articleOnline!.length;
    int lastIndex;
    int? page;
    if(state.allArticleOnline != null){

      if((state.allArticleOnline!.length-state.articleOnline!.length) < 4){
        lastIndex = state.articleOnline!.length+(state.allArticleOnline!.length-state.articleOnline!.length);
      }else{
        lastIndex = state.articleOnline!.length+4;
      }

      if(state.articleOnline!.length != state.allArticleOnline!.length){
        page = state.page!+1;
        if(state.allArticleOnline!.isNotEmpty){
          for(int i=firstIndex; i<lastIndex; i++){
            listData.add(state.allArticleOnline![i]);
          }
        }
      }else{
        page = state.page;
      }
    }
    var summaryData = state.articleOnline!+listData;
    emit(state.copyWith(
        articleOnline: summaryData,
        page: page
    ));
  }
}
