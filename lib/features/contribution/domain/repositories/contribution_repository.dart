import 'dart:io';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:new_bakarbatu/db/models/article_model.dart';
import 'package:new_bakarbatu/db/models/contribution_article_model.dart';
import 'package:new_bakarbatu/features/contribution/data/models/article_response.dart';
import 'package:new_bakarbatu/features/contribution/domain/entities/article_request_entity.dart';

abstract class ContributionRepository {
  Future<File?> getPhotoFile();
  Future<File?> getVideoFile();
  Future<File?> getAudioFile();
  Future<bool?> localSubmitArtikel(Article article);
  Future<bool?> saveToLocalArticle(ArticleRequestEntity data);
  Future<Box<ContributionArticle>?> getArticleLocal();

  Future<List<DataNewsroom>?> getArticleOnline();

  Future<bool?> saveToServerArticle(ArticleRequestEntity data);

  Future<bool?> saveUpdateToLocalArticle({required ArticleRequestEntity data, String? collectionKey});

  Future<bool?> saveToServerArticleVideo(ArticleRequestEntity data);
}