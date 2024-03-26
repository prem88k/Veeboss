class GetProfileInformation {
  bool? success;
  List<Data>? data;

  GetProfileInformation({this.success, this.data});

  GetProfileInformation.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
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

class Data {
  String? profileImage;
  String? coverPhoto;
  String? bio;
  String? experience;
  String? resume;
  int? id;
  String? name;
  String? email;
  String? contactNo;
  int? age;
  String? location;
  String? gender;
  String? about;
  String? address;
  String? role;
  String? referenceCode;
  String? referCode;
  String? endDate;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.profileImage,
        this.coverPhoto,
        this.bio,
        this.experience,
        this.resume,
        this.id,
        this.name,
        this.email,
        this.contactNo,
        this.age,
        this.location,
        this.gender,
        this.about,
        this.address,
        this.role,
        this.referenceCode,
        this.referCode,
        this.endDate,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    profileImage = json['profile_image'];
    coverPhoto = json['cover_photo'];
    bio = json['bio'];
    experience = json['experience'];
    resume = json['resume'];
    id = json['id'];
    name = json['name'];
    email = json['email'];
    contactNo = json['contact_no'];
    age = json['age'];
    location = json['location'];
    gender = json['gender'];
    about = json['about'];
    address = json['address'];
    role = json['role'];
    referenceCode = json['reference_code'];
    referCode = json['refer_code'];
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
    data['age'] = this.age;
    data['location'] = this.location;
    data['gender'] = this.gender;
    data['about'] = this.about;
    data['address'] = this.address;
    data['role'] = this.role;
    data['reference_code'] = this.referenceCode;
    data['refer_code'] = this.referCode;
    data['end_date'] = this.endDate;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}