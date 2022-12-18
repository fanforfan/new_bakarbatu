
import 'dart:math';

import 'package:hive/hive.dart';
import 'package:new_bakarbatu/db/models/article_model.dart';
import 'package:new_bakarbatu/db/models/contribution_article_model.dart';
import 'package:new_bakarbatu/features/contribution/domain/entities/article_request_entity.dart';

abstract class SubmitLocalDatasources {
  Future<bool?> localSubmitArtikel(Article article);

  Future<bool?> saveToLocalArticle(ArticleRequestEntity data);

  Future<Box<ContributionArticle>?> getArticleLocal();

  Future<bool?> saveUpdateToLocalArticle({required ArticleRequestEntity data, String? collectionKey});

  Future<bool?> deleteLocalArticle({String? collectionKey});
}

class SubmitLocalDatasourcesImpl extends SubmitLocalDatasources {
  @override
  Future<bool?> localSubmitArtikel(Article article) async {
    try{
      var boxx = await Hive.openBox<Article>('articleBakarbatu');
      await boxx.add(article);
      return true;
    } catch (error) {
      return false;
    }
  }

  @override
  Future<bool?> saveToLocalArticle(ArticleRequestEntity data) async {
    try{
      var tblContributionBoxx = await Hive.openBox<ContributionArticle>('ContributionArticle');
      const chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
      Random rnd = Random();
      String collectionKey = String.fromCharCodes(
          Iterable.generate(
              10,
              (_) => chars.codeUnitAt(
                  rnd.nextInt(
                      chars.length
                  )
              )
          )
      );

      await tblContributionBoxx.put(
          collectionKey,
          ContributionArticle(
            collectionKey: collectionKey,
            filename: data.articleFile?.path,
            timeSchedule: data.timeSchedule,
            judulIndonesia: data.judulIndonesia,
            captionIndonesia: data.captionIndonesia,
            deskripsiIndonesia: data.deskripsiIndonesia,
            tagKabupaten: data.tagKabupaten,
            tagKampung: data.tagKampung,
            tagDistrik: data.tagDistrik,
            hideAuthor: data.hideAuthor,
            jenisFile: data.jenisFile
          )
      );

      // await tblContributionBoxx.add(ContributionArticle(
      //   collectionKey: collectionKey,
      //   filename: data.articleFile?.path,
      //   timeSchedule: data.timeSchedule,
      //   judulIndonesia: data.judulIndonesia,
      //   captionIndonesia: data.captionIndonesia,
      //   deskripsiIndonesia: data.deskripsiIndonesia,
      //   tagKabupaten: data.tagKabupaten,
      //   tagKampung: data.tagKampung,
      //   tagDistrik: data.tagDistrik,
      //   hideAuthor: data.hideAuthor,
      //   jenisFile: data.jenisFile
      // ));
      return true;
    }catch (error){
      return false;
    }
  }

  @override
  Future<bool?> saveUpdateToLocalArticle({required ArticleRequestEntity data, String? collectionKey}) async {
    try{
      var tblContributionBoxx = await Hive.openBox<ContributionArticle>('ContributionArticle');

      await tblContributionBoxx.put(
          collectionKey,
          ContributionArticle(
              collectionKey: collectionKey,
              filename: data.articleFile?.path,
              timeSchedule: data.timeSchedule,
              judulIndonesia: data.judulIndonesia,
              captionIndonesia: data.captionIndonesia,
              deskripsiIndonesia: data.deskripsiIndonesia,
              tagKabupaten: data.tagKabupaten,
              tagKampung: data.tagKampung,
              tagDistrik: data.tagDistrik,
              hideAuthor: data.hideAuthor,
              jenisFile: data.jenisFile
          )
      );
      return true;
    }catch (error){
      return false;
    }
  }

  @override
  Future<Box<ContributionArticle>?> getArticleLocal() async {
    try{
      var tblContributionBoxx = await Hive.openBox<ContributionArticle>('ContributionArticle');
      return tblContributionBoxx;
    }catch (error){
      return null;
    }
  }

  @override
  Future<bool?> deleteLocalArticle({String? collectionKey}) async {
    // TODO: implement deleteLocalArticle
    try{
      var tblContributionBoxx = await Hive.openBox<ContributionArticle>('ContributionArticle');
      await tblContributionBoxx.delete('$collectionKey');
      return true;
    }catch (error){
      return null;
    }
  }

}