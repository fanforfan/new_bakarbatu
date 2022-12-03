import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:new_bakarbatu/features/contribution/data/models/article_response.dart';
import 'package:http/http.dart' as http;
import 'package:new_bakarbatu/features/contribution/domain/entities/article_request_entity.dart';
import 'package:new_bakarbatu/shared/common/key_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ContributuionRemoteDatasources {
  Future<ArticleResponse?> getArticleOnline(int? idUser, String? token);

  Future saveToServerArticle(ArticleRequestEntity data, SharedPreferences prefs);
}

class ContributuionRemoteRepositoryImpl extends ContributuionRemoteDatasources {
  final http.Client client;

  ContributuionRemoteRepositoryImpl({required this.client});

  @override
  Future<ArticleResponse?> getArticleOnline(int? idUser, String? token) async {
    try{
      ArticleResponse? dataArticle;
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
      var request = http.Request('POST', Uri.parse('http://api.bakarbatu.id/api/list_newsroom'));
      request.bodyFields = {
        'id_user': '$idUser'
      };

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        // debugPrint('HALOO : ${await response.stream.bytesToString()}');
        var data = await response.stream.bytesToString();
        debugPrint('HALOONJEWNG : $data');
        dataArticle = ArticleResponse.fromJson(json.decode(data));
      }
      else {
        debugPrint(response.reasonPhrase);
      }

      return dataArticle;
    }catch (error){
      return null;
    }
  }

  @override
  Future saveToServerArticle(ArticleRequestEntity data, SharedPreferences prefs) async {
    // TODO: implement saveToServerArticle
    try{
      var token = prefs.getString(KeyPreferenches.token);

      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
      var request = http.MultipartRequest('POST', Uri.parse('http://api.bakarbatu.id/api/list_newsroom'));
      request.headers.addAll(headers);
      request.fields['id_user'] = '${prefs.getString(KeyPreferenches.idUser)}';
      request.fields['title'] = '${data.judulIndonesia}';
      request.fields['caption'] = '${data.captionIndonesia}';
      request.fields['description'] = '${data.deskripsiIndonesia}';
      request.fields['open_public'] = '1';
      request.fields['kabuten'] = '${data.tagKabupaten}';
      request.fields['distrik'] = '${data.tagDistrik}';
      request.fields['kampung'] = '${data.tagKampung}';
      request.files.add(await http.MultipartFile.fromPath('file_upload', data.articleFile!.path));
      request.fields['time_publish'] = '${data.timeSchedule}';
      request.fields['hidden_article'] = '${data.hideAuthor! ? 1 : 0}';

      var response = await http.Response.fromStream(await request.send());

    }catch (error){
      debugPrint('DATASOURCES : $error');
    }
  }
}