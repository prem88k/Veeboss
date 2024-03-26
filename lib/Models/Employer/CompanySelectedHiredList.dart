class CompanySelectedHiredList {
  bool? success;
  List<CompanyHiredSList>? data;
  String? message;

  CompanySelectedHiredList({this.success, this.data, this.message});

  CompanySelectedHiredList.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <CompanyHiredSList>[];
      json['data'].forEach((v) {
        data!.add(new CompanyHiredSList.fromJson(v));
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

class CompanyHiredSList {
  int? jobId;
  int? id;
  String? companyName;
  String? companyEmail;
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
  String? callFeedback;
  String? hiring_time;

  CompanyHiredSList(
      {this.jobId,
        this.id,
        this.companyName,
        this.companyEmail,
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
        this.callFeedback,
        this.hiring_time});

  CompanyHiredSList.fromJson(Map<String, dynamic> json) {
    jobId = json['job_id'];
    id = json['id'];
    companyName = json['company_name'];
    companyEmail = json['company_email'];
    hiringStatus = json['hiring_status'];
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
    referenceCode = json['reference_code'];
    referCode = json['refer_code'];
    bio = json['bio'];
    experience = json['experience'];
    profileImage = json['profile_image'];
    resume = json['resume'];
    callFeedback = json['call_feedback'];
    hiring_time = json['hiring_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['job_id'] = this.jobId;
    data['id'] = this.id;
    data['company_name'] = this.companyName;
    data['company_email'] = this.companyEmail;
    data['hiring_status'] = this.hiringStatus;
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
    data['call_feedback'] = this.callFeedback;
    data['hiring_time'] = this.hiring_time;
    return data;
  }
}