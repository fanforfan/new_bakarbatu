import 'dart:io';

import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:new_bakarbatu/core/usecases/usecase_contribution.dart';
import 'package:new_bakarbatu/db/models/article_model.dart';
import 'package:new_bakarbatu/features/contribution/data/models/article_response.dart';
import 'package:new_bakarbatu/features/contribution/domain/entities/article_request_entity.dart';
import 'package:new_bakarbatu/features/contribution/domain/repositories/contribution_repository.dart';

import '../../../../db/models/contribution_article_model.dart';

class ContributionUsecase implements UsecaseContribution {
  final ContributionRepository repository;

  ContributionUsecase(this.repository);

  @override
  Future<File?> getPhotoFile() async {
    return await repository.getPhotoFile();
  }

  @override
  Future<File?> getVideoFile() async {
    return await repository.getVideoFile();
  }

  @override
  Future<File?> getAudioFile() async {
    return await repository.getAudioFile();
  }

  @override
  Future<bool?> localSubmitArtikel(Article article) async {
    return await repository.localSubmitArtikel(article);
  }

  Future<bool?> saveToLocalArticle({required ArticleRequestEntity data}) async {
    return await repository.saveToLocalArticle(data);
  }

  Future<Box<ContributionArticle>?> getArticleLocal() async {
    return await repository.getArticleLocal();
  }

  Future<List<DataNewsroom>?> getArticleOnline() async {
    return await repository.getArticleOnline();
  }

  Future<bool?> saveToServerArticle({required ArticleRequestEntity data}) async {
    return await repository.saveToServerArticle(data);
  }

  Future<bool?> saveUpdateToLocalArticle({required ArticleRequestEntity data, String? collectionKey}) async {
    return await repository.saveUpdateToLocalArticle(data: data, collectionKey: collectionKey);
  }

  Future<bool?> saveToServerArticleVideo({required ArticleRequestEntity data}) async {
    return await repository.saveToServerArticleVideo(data);
  }

  Future<bool?> deleteLocalArticle({String? collectionKey}) async {
    return await repository.deleteLocalArticle(collectionKey: collectionKey);
  }

  Future<Response?> getCountArticle() async {
    return await repository.getCountArticle();
  }

}