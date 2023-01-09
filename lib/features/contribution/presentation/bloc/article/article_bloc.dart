import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:new_bakarbatu/db/models/contribution_article_model.dart';
import 'package:new_bakarbatu/features/contribution/data/models/article_response.dart';

import '../../../domain/usecases/contribution_usecase.dart';

part 'article_event.dart';
part 'article_state.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  final ContributionUsecase contributionUsecase;

  ArticleBloc({required this.contributionUsecase}) : super(const ArticleState()) {
    on<GetArticle>(_getArticle);
    on<GetNextArticle>(_getNextArticle);
    on<SearchArticle>(_seacrhArticle);
    // on<GetArticleOnline>(_getArticleOnline);
  }

  _getArticle(GetArticle event, Emitter<ArticleState> emit) async {
    emit(state.copyWith(
      status: ArticleStatus.loading
    ));
    var listArticle = <ContributionArticle>[];
    try{
      if(event.statusArticle == 0){
        var response = await contributionUsecase.getArticleLocal();
        if(response != null){
          response.values.map((e) => listArticle.add(
            ContributionArticle(
              collectionKey: e.collectionKey,
              filename: e.filename,
              timeSchedule: e.timeSchedule,
              judulIndonesia: e.judulIndonesia,
              captionIndonesia: e.captionIndonesia,
              deskripsiIndonesia: e.deskripsiIndonesia,
              tagKabupaten: e.tagKabupaten,
              tagKampung: e.tagKampung,
              tagDistrik: e.tagDistrik,
              hideAuthor: e.hideAuthor,
              jenisFile: e.jenisFile
            ))).toList();
          emit(state.copyWith(
              article: listArticle,
              status: ArticleStatus.success
          ));
        }else{
          emit(state.copyWith(
              article: listArticle,
              status: ArticleStatus.error
          ));
        }
      }else{
        List<DataNewsroom> listData = [];
        List<DataNewsroom> listDataAll = [];
        var response = await contributionUsecase.getArticleOnline();
        if(response != null){
          if(response.isNotEmpty){
            if(response.length < 4){
              for(int i=0; i<response.length; i++){
                print('NO. $i');
                listData.add(response[i]);
              }
            }else{
              for(int i=0; i<4; i++){
                print('NO. $i');
                listData.add(response[i]);
              }
            }
          }
        }
        emit(state.copyWith(
          page: 1,
          allArticleOnline: response,
          articleOnline: listData,
          status: ArticleStatus.success
        ));
      }
    } catch (error) {
      debugPrint('ERROR GAESS : $error');
      emit(state.copyWith(
          article: listArticle,
          status: ArticleStatus.error
      ));
    }
  }

  _getNextArticle(GetNextArticle event, Emitter<ArticleState> emit) async {
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

  _seacrhArticle(SearchArticle event, Emitter<ArticleState> emit) async {
    List<DataNewsroom> listData = [];
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
}
