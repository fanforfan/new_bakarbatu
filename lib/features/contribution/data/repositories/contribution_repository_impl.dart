import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:new_bakarbatu/db/models/article_model.dart';
import 'package:new_bakarbatu/db/models/contribution_article_model.dart';
import 'package:new_bakarbatu/features/contribution/data/datasources/submit_local_datasources.dart';
import 'package:new_bakarbatu/features/contribution/data/models/article_response.dart';
import 'package:new_bakarbatu/features/contribution/domain/entities/article_request_entity.dart';
import 'package:new_bakarbatu/features/contribution/domain/repositories/contribution_repository.dart';
import 'package:new_bakarbatu/shared/common/key_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../datasources/contribution_remote_datasources.dart';

class ContributionRepositoryImpl implements ContributionRepository {
  final SubmitLocalDatasources submitLocalDatasources;
  final ContributuionRemoteDatasources contributionRemoteDatasources;

  ContributionRepositoryImpl({required this.submitLocalDatasources, required this.contributionRemoteDatasources});

  @override
  Future<File?> getPhotoFile() async {
    // TODO: implement getPhotoFile
    throw UnimplementedError();
  }

  @override
  Future<File?> getVideoFile() async {
    // TODO: implement getVideoFile
    throw UnimplementedError();
  }

  @override
  Future<File?> getAudioFile() {
    // TODO: implement getAudioFile
    throw UnimplementedError();
  }

  @override
  Future<bool?> localSubmitArtikel(Article article) async {
    try{
      final submitArticleToLocal = await submitLocalDatasources.localSubmitArtikel(article);
      return submitArticleToLocal;
    } catch (error) {
      return false;
    }
  }

  @override
  Future<bool?> saveToLocalArticle(ArticleRequestEntity data) async {
    try{
      final response = await submitLocalDatasources.saveToLocalArticle(data);
      return response;
    }catch (error){
      return false;
    }
  }

  @override
  Future<Box<ContributionArticle>?> getArticleLocal() async {
    try{
      final response = await submitLocalDatasources.getArticleLocal();
      return response;
    }catch (error){
      return null;
    }
  }

  @override
  Future<List<DataNewsroom>?> getArticleOnline() async {
    try{
      var listData = <DataNewsroom>[];
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final response = await contributionRemoteDatasources.getArticleOnline(prefs.getInt(KeyPreferenches.idUser), prefs.getString(KeyPreferenches.token));
      if(response != null){
        print('INI KANlll');
        if(response.rc == '0000'){
          if(response.dataNewsroom != null){
            for(var i=0; i<response.dataNewsroom!.length; i++){
              listData.add(DataNewsroom(
                  idNewsroom: response.dataNewsroom?[i].idNewsroom,
                  title: response.dataNewsroom?[i].title,
                  description: response.dataNewsroom?[i].description,
                  publish: response.dataNewsroom?[i].publish,
                  saved: response.dataNewsroom?[i].saved,
                  userIdSaved: response.dataNewsroom?[i].userIdSaved,
                  userNameSaved: response.dataNewsroom?[i].userNameSaved,
                  status: response.dataNewsroom?[i].status,
                  categoryId: response.dataNewsroom?[i].categoryId,
                  categoryName: response.dataNewsroom?[i].categoryName,
                  userIdEditor: response.dataNewsroom?[i].userIdEditor,
                  nameEditor: response.dataNewsroom?[i].nameEditor,
                  keywordId: response.dataNewsroom?[i].keywordId,
                  articleImageId: response.dataNewsroom?[i].articleImageId,
                  articleUrl: response.dataNewsroom?[i].articleUrl
              ));
            }
          }
        }
      }
      return listData;
    }catch (error){
      return null;
    }
  }

  @override
  Future<bool?> saveToServerArticle(ArticleRequestEntity data) async {
    // TODO: implement saveToServerArticle
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final response = await contributionRemoteDatasources.saveToServerArticle(data, prefs);
      return response;
    }catch (error){
      debugPrint('$error');
      return false;
    }
  }

  @override
  Future<bool?> saveUpdateToLocalArticle({required ArticleRequestEntity data, String? collectionKey}) async {
    try{
      final response = await submitLocalDatasources.saveUpdateToLocalArticle(data: data, collectionKey: collectionKey);
      return response;
    }catch (error){
      return false;
    }
  }

  @override
  Future<bool?> saveToServerArticleVideo(ArticleRequestEntity data) async {
    // TODO: implement saveToServerArticleVideo
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final response = await contributionRemoteDatasources.saveToServerArticleVideo(data, prefs);
      return response;
    }catch (error){
      debugPrint('$error');
      return false;
    }
  }

}