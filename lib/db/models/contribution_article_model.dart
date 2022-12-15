import 'package:hive/hive.dart';

part 'contribution_article_model.g.dart';

@HiveType(typeId: 1)
class ContributionArticle {
  @HiveField(0)
  final String? collectionKey;

  @HiveField(1)
  final String? filename;

  @HiveField(2)
  final String? timeSchedule;

  @HiveField(3)
  final String? judulIndonesia;

  @HiveField(4)
  final String? captionIndonesia;

  @HiveField(5)
  final String? deskripsiIndonesia;

  @HiveField(6)
  final String? tagKabupaten;

  @HiveField(7)
  final String? tagKampung;

  @HiveField(8)
  final String? tagDistrik;

  @HiveField(9)
  final bool? hideAuthor;

  @HiveField(10)
  final int? jenisFile;

  ContributionArticle({
    this.collectionKey,
    this.filename,
    this.timeSchedule,
    this.judulIndonesia,
    this.captionIndonesia,
    this.deskripsiIndonesia,
    this.tagKabupaten,
    this.tagKampung,
    this.tagDistrik,
    this.hideAuthor,
    this.jenisFile
  });
}