import 'package:hive/hive.dart';

part 'contribution_article_model.g.dart';

@HiveType(typeId: 1)
class ContributionArticle {
  @HiveField(0)
  final String? filename;

  @HiveField(1)
  final String? timeSchedule;

  @HiveField(2)
  final String? judulIndonesia;

  @HiveField(3)
  final String? captionIndonesia;

  @HiveField(4)
  final String? deskripsiIndonesia;

  @HiveField(5)
  final String? tagKabupaten;

  @HiveField(6)
  final String? tagKampung;

  @HiveField(7)
  final String? tagDistrik;

  @HiveField(8)
  final bool? hideAuthor;

  ContributionArticle({
    this.filename,
    this.timeSchedule,
    this.judulIndonesia,
    this.captionIndonesia,
    this.deskripsiIndonesia,
    this.tagKabupaten,
    this.tagKampung,
    this.tagDistrik,
    this.hideAuthor,
  });
}