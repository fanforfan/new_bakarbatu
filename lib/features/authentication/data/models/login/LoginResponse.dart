class LoginResponse {
  DataUser? dataUser;
  String? token;
  String? message;
  String? rc;
  DataError? dataError;


  LoginResponse({this.dataUser, this.token, this.message, this.rc, this.dataError});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    dataUser = json['data_user'] != null
        ? DataUser.fromJson(json['data_user'])
        : null;
    token = json['token'];
    message = json['message'];
    rc = json['rc'];
    dataError = json['errors'] != null
        ? DataError.fromJson(json['errors'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dataUser != null) {
      data['data_user'] = this.dataUser!.toJson();
    }
    data['token'] = this.token;
    data['message'] = this.message;
    data['rc'] = this.rc;
    return data;
  }
}

class DataError {
  String? errorEmail;
  String? errorPassword;

  DataError({this.errorEmail, this.errorPassword});

  DataError.fromJson(Map<String, dynamic> json) {
    errorEmail = json['email'][0];
    errorPassword = json['password'];
  }
}

class DataUser {
  int? id;
  String? username;
  String? email;
  Null? photo;
  String? phone;
  String? ttl;
  String? gender;
  String? provinsi;
  String? kabupaten;
  String? kecamatan;
  String? kelurahan;
  String? alamat;
  String? savedDate;
  int? userRegisterBy;
  int? status;
  String? lastLogin;
  int? komunitasId;
  String? nameKomunitas;

  DataUser(
      {this.id,
        this.username,
        this.email,
        this.photo,
        this.phone,
        this.ttl,
        this.gender,
        this.provinsi,
        this.kabupaten,
        this.kecamatan,
        this.kelurahan,
        this.alamat,
        this.savedDate,
        this.userRegisterBy,
        this.status,
        this.lastLogin,
        this.komunitasId,
        this.nameKomunitas});

  DataUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    photo = json['photo'];
    phone = json['phone'];
    ttl = json['ttl'];
    gender = json['gender'];
    provinsi = json['provinsi'];
    kabupaten = json['kabupaten'];
    kecamatan = json['kecamatan'];
    kelurahan = json['kelurahan'];
    alamat = json['alamat'];
    savedDate = json['saved_date'];
    userRegisterBy = json['user_register_by'];
    status = json['status'];
    lastLogin = json['last_login'];
    komunitasId = json['komunitas_id'];
    nameKomunitas = json['name_komunitas'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['email'] = this.email;
    data['photo'] = this.photo;
    data['phone'] = this.phone;
    data['ttl'] = this.ttl;
    data['gender'] = this.gender;
    data['provinsi'] = this.provinsi;
    data['kabupaten'] = this.kabupaten;
    data['kecamatan'] = this.kecamatan;
    data['kelurahan'] = this.kelurahan;
    data['alamat'] = this.alamat;
    data['saved_date'] = this.savedDate;
    data['user_register_by'] = this.userRegisterBy;
    data['status'] = this.status;
    data['last_login'] = this.lastLogin;
    data['komunitas_id'] = this.komunitasId;
    data['name_komunitas'] = this.nameKomunitas;
    return data;
  }
}