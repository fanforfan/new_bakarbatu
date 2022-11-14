import 'dart:io';

import 'package:new_bakarbatu/db/models/article_model.dart';

abstract class ContributionRepository {
  Future<File?> getPhotoFile();
  Future<File?> getVideoFile();
  Future<File?> getAudioFile();
  Future<bool?> localSubmitArtikel(Article article);
}