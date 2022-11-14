import 'package:hive/hive.dart';

part 'article_model.g.dart';

@HiveType(typeId: 0)
class Article {
  @HiveField(0)
  final String? filename;

  @HiveField(1)
  final String? title;

  @HiveField(2)
  final String? description;

  @HiveField(3)
  final String? hideauthor;

  Article({
    this.filename,
    this.title,
    this.description,
    this.hideauthor});
}