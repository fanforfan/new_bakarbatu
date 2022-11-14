
import 'package:hive/hive.dart';
import 'package:new_bakarbatu/db/models/article_model.dart';

abstract class SubmitLocalDatasources {
  Future<bool?> localSubmitArtikel(Article article);
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

}