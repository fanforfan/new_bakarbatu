import 'dart:io';

class ArticleRequestEntity {
  final File? articleFile;
  final int? jenisFile;
  final String? timeSchedule;
  final String? judulIndonesia;
  final String? captionIndonesia;
  final String? deskripsiIndonesia;
  final String? tagKabupaten;
  final String? tagKampung;
  final String? tagDistrik;
  final bool? hideAuthor;

  ArticleRequestEntity({
    this.articleFile,
    this.jenisFile,
    this.timeSchedule,
    this.judulIndonesia,
    this.captionIndonesia,
    this.deskripsiIndonesia,
    this.tagKabupaten,
    this.tagKampung,
    this.tagDistrik,
    this.hideAuthor
  });
}