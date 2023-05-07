class UserModel {
  UserInfo? userInfo;

  UserModel({this.userInfo});

  UserModel.fromJson(Map<String, dynamic> json) {
    userInfo = json['User Info'] != null
        ? new UserInfo.fromJson(json['User Info'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userInfo != null) {
      data['User Info'] = this.userInfo!.toJson();
    }
    return data;
  }
}

class UserInfo {
  int? id;
  String? name;
  String? role;
  String? email;
  String? phone;
  String? gender;
  String? dob;
  String? image;
  String? address;
  String? prefer;
  String? status;
  String? emailVerifiedAt;
  String? createdAt;
  String? updatedAt;

  UserInfo(
      {this.id,
      this.name,
      this.role,
      this.email,
      this.phone,
      this.gender,
      this.dob,
      this.image,
      this.address,
      this.prefer,
      this.status,
      this.emailVerifiedAt,
      this.createdAt,
      this.updatedAt});

  UserInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    role = json['role'];
    email = json['email'];
    phone = json['phone'];
    gender = json['gender'];
    dob = json['dob'];
    image = json['image'];
    address = json['address'];
    prefer = json['prefer'];
    status = json['status'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['role'] = this.role;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['gender'] = this.gender;
    data['dob'] = this.dob;
    data['image'] = this.image;
    data['address'] = this.address;
    data['prefer'] = this.prefer;
    data['status'] = this.status;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
