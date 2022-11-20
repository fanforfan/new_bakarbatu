
import 'package:hive/hive.dart';
import 'package:new_bakarbatu/db/models/article_model.dart';
import 'package:new_bakarbatu/db/models/contribution_article_model.dart';
import 'package:new_bakarbatu/features/contribution/domain/entities/article_request_entity.dart';

abstract class SubmitLocalDatasources {
  Future<bool?> localSubmitArtikel(Article article);

  Future<bool?> saveToLocalArticle(ArticleRequestEntity data);

  Future<Box<ContributionArticle>?> getArticleLocal();
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
      await tblContributionBoxx.add(ContributionArticle(
        filename: data.articleFile?.path,
        timeSchedule: data.timeSchedule,
        judulIndonesia: data.judulIndonesia,
        captionIndonesia: data.captionIndonesia,
        deskripsiIndonesia: data.deskripsiIndonesia,
        tagKabupaten: data.tagKabupaten,
        tagKampung: data.tagKampung,
        tagDistrik: data.tagDistrik,
        hideAuthor: data.hideAuthor
      ));
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

}