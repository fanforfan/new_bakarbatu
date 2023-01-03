class AuthenticationDataEntity {
  String? message;
  int? id;
  String? username;
  String? email;
  String? photo;
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
  String? token;
  String? responseCode;

  AuthenticationDataEntity(
      {this.message,
        this.id,
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
        this.nameKomunitas,
        this.token,
        this.responseCode});

  AuthenticationDataEntity.fromJson(Map<String, dynamic> json) {
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
    responseCode = json['rc'];
  }
  //
  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['id'] = this.id;
  //   data['username'] = this.username;
  //   data['email'] = this.email;
  //   data['photo'] = this.photo;
  //   data['phone'] = this.phone;
  //   data['ttl'] = this.ttl;
  //   data['gender'] = this.gender;
  //   data['provinsi'] = this.provinsi;
  //   data['kabupaten'] = this.kabupaten;
  //   data['kecamatan'] = this.kecamatan;
  //   data['kelurahan'] = this.kelurahan;
  //   data['alamat'] = this.alamat;
  //   data['saved_date'] = this.savedDate;
  //   data['user_register_by'] = this.userRegisterBy;
  //   data['status'] = this.status;
  //   data['last_login'] = this.lastLogin;
  //   data['komunitas_id'] = this.komunitasId;
  //   data['name_komunitas'] = this.nameKomunitas;
  //   return data;
  // }
}