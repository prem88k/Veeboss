class GetAllRecruiterData {
  bool? success;
  List<RecruiterList>? data;

  GetAllRecruiterData({this.success, this.data});

  GetAllRecruiterData.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <RecruiterList>[];
      json['data'].forEach((v) {
        data!.add(new RecruiterList.fromJson(v));
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

class RecruiterList {
  int? id;
  String? name;
  String? email;
  String? profileImage;
  String? contactNo;
  String? companyInfo;
  String? about;
  String? address;
  String? referenceCode;
  String? createdAt;
  String? updatedAt;

  RecruiterList(
      {this.id,
        this.name,
        this.email,
        this.profileImage,
        this.contactNo,
        this.companyInfo,
        this.about,
        this.address,
        this.referenceCode,
        this.createdAt,
        this.updatedAt});

  RecruiterList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    profileImage = json['profile_image'];
    contactNo = json['contact_no'];
    companyInfo = json['company_info'];
    about = json['about'];
    address = json['address'];
    referenceCode = json['reference_code'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['profile_image'] = this.profileImage;
    data['contact_no'] = this.contactNo;
    data['company_info'] = this.companyInfo;
    data['about'] = this.about;
    data['address'] = this.address;
    data['reference_code'] = this.referenceCode;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}