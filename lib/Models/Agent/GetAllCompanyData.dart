class GetAllCompanyData {
  bool? success;
  List<CompanyList>? data;

  GetAllCompanyData({this.success, this.data});

  GetAllCompanyData.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <CompanyList>[];
      json['data'].forEach((v) {
        data!.add(new CompanyList.fromJson(v));
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

class CompanyList {
  int? id;
  String? name;
  String? email;
  String? contactNo;
  String? location;
  String? profileImage;
  String? role;
  String? referCode;
  String? createdAt;
  String? updatedAt;
  String? profilePhoto;

  CompanyList(
      {this.id,
        this.name,
        this.email,
        this.contactNo,
        this.location,
        this.profileImage,
        this.role,
        this.referCode,
        this.createdAt,
        this.updatedAt,
        this.profilePhoto});

  CompanyList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    contactNo = json['contact_no'];
    location = json['location'];
    profileImage = json['profile_image'];
    role = json['role'];
    referCode = json['refer_code'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    profilePhoto = json['profile_photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['contact_no'] = this.contactNo;
    data['location'] = this.location;
    data['profile_image'] = this.profileImage;
    data['role'] = this.role;
    data['refer_code'] = this.referCode;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['profile_photo'] = this.profilePhoto;
    return data;
  }
}