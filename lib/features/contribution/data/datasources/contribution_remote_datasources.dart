import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:new_bakarbatu/features/contribution/data/models/article_response.dart';
import 'package:http/http.dart' as http;
import 'package:new_bakarbatu/features/contribution/domain/entities/article_request_entity.dart';
import 'package:new_bakarbatu/shared/common/key_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ContributuionRemoteDatasources {
  Future<ArticleResponse?> getArticleOnline(int? idUser, String? token);

  Future saveToServerArticle(ArticleRequestEntity data, SharedPreferences prefs);

  Future saveToServerArticleVideo(ArticleRequestEntity data, SharedPreferences prefs);
}

class ContributuionRemoteRepositoryImpl extends ContributuionRemoteDatasources {
  final http.Client client;

  ContributuionRemoteRepositoryImpl({required this.client});

  @override
  Future<ArticleResponse?> getArticleOnline(int? idUser, String? token) async {
    try{
      Response response;
      var dio = Dio();
      ArticleResponse? dataArticle;
      var headers = {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token'
      };

      response = await dio.post(
        'http://api.bakarbatu.id/api/list_newsroom',
        data: {
          'id_user': '$idUser'
        },
        options: Options(
          headers: headers,
        ),
      );

      print('JALAN KAN YAK $idUser ${response.statusCode} ${response.data} $headers ');

      if (response.statusCode == 200) {
        dataArticle = ArticleResponse.fromJson(response.data);
      }
      else {
        debugPrint(response.statusMessage);
      }

      print('DATAART : ${dataArticle?.dataNewsroom}');

      return dataArticle;
    }catch (error){
      return null;
    }
  }

  @override
  Future saveToServerArticle(ArticleRequestEntity data, SharedPreferences prefs) async {
    // TODO: implement saveToServerArticle
    try{
      Response response;
      var dio = Dio();

      var token = prefs.getString(KeyPreferenches.token);

      var headers = {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token'
      };

      String fileName = data.articleFile!.path.split('/').last;
      FormData formData = FormData.fromMap({
        'id_user': '${prefs.getInt(KeyPreferenches.idUser)}',
        'tittle': '${data.judulIndonesia}',
        'caption': '${data.captionIndonesia}',
        'description': '${data.deskripsiIndonesia}',
        'open_public': '1',
        'kabupaten': '${data.tagKabupaten}',
        'distrik': '${data.tagDistrik}',
        'kampung': '${data.tagKampung}',
        'file_upload': await MultipartFile.fromFile(data.articleFile!.path, filename:fileName),
        'time_publish': '${data.timeSchedule}',
        'hidden_article': '${data.hideAuthor! ? 1 : 0}',
        'komunitasid': '${prefs.getInt(KeyPreferenches.komunitasId)}'
      });

      response = await dio.post(
        'http://api.bakarbatu.id/api/newsroom/new_article',
        data: formData,
        options: Options(
          headers: headers,
        ),
      );

      print('INI LHOO : ${response.statusCode} ${response.data}');

      if(response.statusCode == 200){
        if(response.data['message'] == 'Success Saved Data on!'){
          return true;
        }else{
          return false;
        }
      }else{
        return false;
      }

    }catch (error){
      debugPrint('DATASOURCES : $error');
      return false;
    }
  }

  @override
  Future saveToServerArticleVideo(ArticleRequestEntity data, SharedPreferences prefs) async {
    // TODO: implement saveToServerArticleVideo
    try{
      Response response;
      var dio = Dio();

      var token = prefs.getString(KeyPreferenches.token);

      var headers = {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token'
      };

      String fileName = data.articleFile!.path.split('/').last;
      print('HARUSNYA INI ${data.articleFile!.path} - $fileName');
      FormData formData = FormData.fromMap({
        'id_user': '${prefs.getInt(KeyPreferenches.idUser)}',
        'tittle': '${data.judulIndonesia}',
        'caption': '${data.captionIndonesia}',
        'description': '${data.deskripsiIndonesia}',
        'open_public': '1',
        'kabupaten': '${data.tagKabupaten}',
        'distrik': '${data.tagDistrik}',
        'kampung': '${data.tagKampung}',
        'file_upload': await MultipartFile.fromFile(data.articleFile!.path, filename:fileName),
        'time_publish': '${data.timeSchedule}',
        'hidden_article': '${data.hideAuthor! ? 1 : 0}',
        'komunitasid': '${prefs.getInt(KeyPreferenches.komunitasId)}'
      });

      response = await dio.post(
        'http://api.bakarbatu.id/api/newsroom/new_article',
        data: formData,
        options: Options(
          headers: headers,
        ),
      );

      print('INI LHOO : ${response.statusCode} ${response.data}');

      if(response.statusCode == 200){
        if(response.data['message'] == 'Success Saved Data on!'){
          return true;
        }else{
          return false;
        }
      }else{
        return false;
      }

    }catch (error){
      debugPrint('DATASOURCES : $error');
      return false;
    }
  }
}