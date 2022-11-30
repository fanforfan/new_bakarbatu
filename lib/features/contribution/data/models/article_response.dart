class ArticleResponse {
  String? rc;
  String? message;
  String? requestTime;
  List<DataNewsroom>? dataNewsroom;

  ArticleResponse({this.rc, this.message, this.requestTime, this.dataNewsroom});

  ArticleResponse.fromJson(Map<String, dynamic> json) {
    rc = json['rc'];
    message = json['message'];
    requestTime = json['request_time'];
    if (json['data_newsroom'] != null) {
      dataNewsroom = <DataNewsroom>[];
      json['data_newsroom'].forEach((v) {
        dataNewsroom!.add(new DataNewsroom.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rc'] = this.rc;
    data['message'] = this.message;
    data['request_time'] = this.requestTime;
    if (this.dataNewsroom != null) {
      data['data_newsroom'] =
          this.dataNewsroom!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataNewsroom {
  int? idNewsroom;
  String? title;
  String? description;
  String? publish;
  String? saved;
  int? userIdSaved;
  String? userNameSaved;
  String? status;
  int? categoryId;
  String? categoryName;
  int? userIdEditor;
  String? nameEditor;
  String? keywordId;
  int? articleImageId;
  String? articleUrl;

  DataNewsroom(
      {this.idNewsroom,
        this.title,
        this.description,
        this.publish,
        this.saved,
        this.userIdSaved,
        this.userNameSaved,
        this.status,
        this.categoryId,
        this.categoryName,
        this.userIdEditor,
        this.nameEditor,
        this.keywordId,
        this.articleImageId,
        this.articleUrl});

  DataNewsroom.fromJson(Map<String, dynamic> json) {
    idNewsroom = json['id_newsroom'];
    title = json['title'];
    description = json['description'];
    publish = json['publish'];
    saved = json['saved'];
    userIdSaved = json['user_id_saved'];
    userNameSaved = json['user_name_saved'];
    status = json['status'];
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    userIdEditor = json['user_id_editor'];
    nameEditor = json['name_editor'];
    keywordId = json['keyword_id'];
    articleImageId = json['article_image_id'];
    articleUrl = json['article_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_newsroom'] = this.idNewsroom;
    data['title'] = this.title;
    data['description'] = this.description;
    data['publish'] = this.publish;
    data['saved'] = this.saved;
    data['user_id_saved'] = this.userIdSaved;
    data['user_name_saved'] = this.userNameSaved;
    data['status'] = this.status;
    data['category_id'] = this.categoryId;
    data['category_name'] = this.categoryName;
    data['user_id_editor'] = this.userIdEditor;
    data['name_editor'] = this.nameEditor;
    data['keyword_id'] = this.keywordId;
    data['article_image_id'] = this.articleImageId;
    data['article_url'] = this.articleUrl;
    return data;
  }
}