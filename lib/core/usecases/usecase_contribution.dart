import 'dart:io';

abstract class UsecaseContribution {
  Future<File?> getVideoFile();
  Future<File?> getPhotoFile();
  Future<File?> getAudioFile();
}