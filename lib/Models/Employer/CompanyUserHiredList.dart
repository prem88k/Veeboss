class CompanyUserHiredList {
  bool? success;
  List<CompanyHiredList>? data;
  String? message;

  CompanyUserHiredList({this.success, this.data, this.message});

  CompanyUserHiredList.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <CompanyHiredList>[];
      json['data'].forEach((v) {
        data!.add(new CompanyHiredList.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class CompanyHiredList {
  String? createName;
  String? createEmail;
  int? id;
  int? jobId;
  String? hiringStatus;
  String? name;
  String? email;
  String? contactNo;
  String? website;
  String? position;
  int? age;
  String? location;
  String? gender;
  String? about;
  String? address;
  String? referenceCode;
  String? referCode;
  String? bio;
  String? experience;
  String? profileImage;
  String? resume;
  String? com_shortlist_status;
  String? hiring_status;

  CompanyHiredList(
      {
        this.createName,
        this.createEmail,
        this.jobId,
        this.id,
        this.hiringStatus,
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
        this.referenceCode,
        this.referCode,
        this.bio,
        this.experience,
        this.profileImage,
        this.resume,
        this.com_shortlist_status,
        this.hiring_status});

  CompanyHiredList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    jobId = json['job_id'];
    createName = json['create_name'];
    createEmail = json['create_email'];
    name = json['name'];
    email = json['email'];
    contactNo = json['contact_no'];
    website = json['website'];
    hiringStatus = json['hiring_status'];
    position = json['position'];
    age = json['age'];
    location = json['location'];
    gender = json['gender'];
    about = json['about'];
    address = json['address'];
    referenceCode = json['reference_code'];
    referCode = json['refer_code'];
    bio = json['bio'];
    experience = json['experience'];
    profileImage = json['profile_image'];
    resume = json['resume'];
    com_shortlist_status = json['com_shortlist_status'];
    hiring_status = json['hiring_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['job_id'] = this.jobId;
    data['hiring_status'] = this.hiringStatus;
    data['create_name'] = this.createName;
    data['create_email'] = this.createEmail;
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
    data['reference_code'] = this.referenceCode;
    data['refer_code'] = this.referCode;
    data['bio'] = this.bio;
    data['experience'] = this.experience;
    data['profile_image'] = this.profileImage;
    data['resume'] = this.resume;
    data['com_shortlist_status'] = this.com_shortlist_status;
    data['hiring_status'] = this.hiring_status;
    return data;
  }
}