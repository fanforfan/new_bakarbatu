import 'dart:io';

import 'package:new_bakarbatu/db/models/article_model.dart';
import 'package:new_bakarbatu/features/contribution/data/datasources/submit_local_datasources.dart';
import 'package:new_bakarbatu/features/contribution/domain/repositories/contribution_repository.dart';

class ContributionRepositoryImpl implements ContributionRepository {
  final SubmitLocalDatasources submitLocalDatasources;

  ContributionRepositoryImpl({required this.submitLocalDatasources});

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

}