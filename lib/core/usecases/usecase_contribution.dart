import 'dart:io';

import 'package:new_bakarbatu/db/models/article_model.dart';

abstract class UsecaseContribution {
  Future<File?> getVideoFile();
  Future<File?> getPhotoFile();
  Future<File?> getAudioFile();
  Future<bool?> localSubmitArtikel(Article article);
}