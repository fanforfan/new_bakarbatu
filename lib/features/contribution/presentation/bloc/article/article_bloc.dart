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
        var response = await contributionUsecase.getArticleOnline();
        print('YANG INI BUKAN SIH? ${response}');
        emit(state.copyWith(
          articleOnline: response,
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

  // _getArticleOnline(GetArticleOnline event, Emitter<ArticleState> emit) async {
  //   emit(state.copyWith(
  //       status: ArticleStatus.loading
  //   ));
  //   var listArticle = <ContributionArticle>[];
  //   try{
  //     if(event.statusArticle == 0){
  //       var response = await contributionUsecase.getArticleLocal();
  //       if(response != null){
  //         response.values.map((e) => listArticle.add(
  //             ContributionArticle(
  //                 filename: e.filename,
  //                 timeSchedule: e.timeSchedule,
  //                 judulIndonesia: e.judulIndonesia,
  //                 captionIndonesia: e.captionIndonesia,
  //                 deskripsiIndonesia: e.deskripsiIndonesia,
  //                 tagKabupaten: e.tagKabupaten,
  //                 tagKampung: e.tagKampung,
  //                 tagDistrik: e.tagDistrik,
  //                 hideAuthor: e.hideAuthor,
  //                 jenisFile: e.jenisFile
  //             ))).toList();
  //         emit(state.copyWith(
  //             article: listArticle,
  //             status: ArticleStatus.success
  //         ));
  //       }else{
  //         emit(state.copyWith(
  //             article: listArticle,
  //             status: ArticleStatus.error
  //         ));
  //       }
  //     }else{
  //       var response = await contributionUsecase.getArticleOnline();
  //       print('YANG INI BUKAN SIH? ${response}');
  //       emit(state.copyWith(
  //           articleOnline: response
  //       ));
  //     }
  //   } catch (error) {
  //     debugPrint('ERROR GAESS : $error');
  //     emit(state.copyWith(
  //         article: listArticle,
  //         status: ArticleStatus.error
  //     ));
  //   }
  // }
}
