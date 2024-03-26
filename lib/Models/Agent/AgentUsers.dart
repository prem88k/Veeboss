class AgentUsers {
  bool? success;
  List<AgentUserList>? data;

  AgentUsers({this.success, this.data});

  AgentUsers.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <AgentUserList>[];
      json['data'].forEach((v) {
        data!.add(new AgentUserList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AgentUserList {
  String? profileImage;
  Null? coverPhoto;
  String? bio;
  String? experience;
  String? resume;
  int? id;
  String? name;
  String? email;
  String? contactNo;
  String? website;
  String? position;
  int? age;
  String? location;
  String? gender;
  Null? about;
  String? address;
  String? socialId;
  String? deviceId;
  String? platform;
  String? fcmKey;
  String? role;
  String? referenceCode;
  Null? referCode;
  int? socialLogin;
  String? fcm;
  Null? endDate;
  String? createdAt;
  String? updatedAt;

  AgentUserList(
      {this.profileImage,
        this.coverPhoto,
        this.bio,
        this.experience,
        this.resume,
        this.id,
        this.name,
        this.email,
        this.contactNo,
        this.website,
        this.position,
        this.age,
        this.location,
        this.gender,
        this.about,
        this.address,
        this.socialId,
        this.deviceId,
        this.platform,
        this.fcmKey,
        this.role,
        this.referenceCode,
        this.referCode,
        this.socialLogin,
        this.fcm,
        this.endDate,
        this.createdAt,
        this.updatedAt});

  AgentUserList.fromJson(Map<String, dynamic> json) {
    profileImage = json['profile_image'];
    coverPhoto = json['cover_photo'];
    bio = json['bio'];
    experience = json['experience'];
    resume = json['resume'];
    id = json['id'];
    name = json['name'];
    email = json['email'];
    contactNo = json['contact_no'];
    website = json['website'];
    position = json['position'];
    age = json['age'];
    location = json['location'];
    gender = json['gender'];
    about = json['about'];
    address = json['address'];
    socialId = json['social_id'];
    deviceId = json['device_id'];
    platform = json['platform'];
    fcmKey = json['fcm_key'];
    role = json['role'];
    referenceCode = json['reference_code'];
    referCode = json['refer_code'];
    socialLogin = json['social_login'];
    fcm = json['fcm'];
    endDate = json['end_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['profile_image'] = this.profileImage;
    data['cover_photo'] = this.coverPhoto;
    data['bio'] = this.bio;
    data['experience'] = this.experience;
    data['resume'] = this.resume;
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['contact_no'] = this.contactNo;
    data['website'] = this.website;
    data['position'] = this.position;
    data['age'] = this.age;
    data['location'] = this.location;
    data['gender'] = this.gender;
    data['about'] = this.about;
    data['address'] = this.address;
    data['social_id'] = this.socialId;
    data['device_id'] = this.deviceId;
    data['platform'] = this.platform;
    data['fcm_key'] = this.fcmKey;
    data['role'] = this.role;
    data['reference_code'] = this.referenceCode;
    data['refer_code'] = this.referCode;
    data['social_login'] = this.socialLogin;
    data['fcm'] = this.fcm;
    data['end_date'] = this.endDate;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}