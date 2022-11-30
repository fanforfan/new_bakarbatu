import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:new_bakarbatu/features/contribution/data/models/article_response.dart';
import 'package:http/http.dart' as http;

abstract class ContributuionRemoteDatasources {
  Future<ArticleResponse?> getArticleOnline(int? idUser, String? token);
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
}