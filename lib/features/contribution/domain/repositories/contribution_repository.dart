import 'dart:io';

abstract class ContributionRepository {
  Future<File?> getPhotoFile();
  Future<File?> getVideoFile();
}