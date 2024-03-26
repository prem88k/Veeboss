class GetAllHiredUserData {
  bool? isError;
  List<HiredUserList>? data;
  String? message;

  GetAllHiredUserData({this.isError, this.data, this.message});

  GetAllHiredUserData.fromJson(Map<String, dynamic> json) {
    isError = json['is_error'];
    if (json['data'] != null) {
      data = <HiredUserList>[];
      json['data'].forEach((v) {
        data!.add(new HiredUserList.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['is_error'] = this.isError;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class HiredUserList {
  int? id;
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
  String? voiceNote;
  String? expectedSalary;
  String? userDescription;
  String? qualification;
  String? compayStatus;
  String? callFeedback;
  String? hiring_status;
  String? hiring_time;
  String? appliedTime;
  String? comShortlistStatus;
  String? companyShortlistTime;
  String? hrTime;

  HiredUserList(
      {this.id,
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
        this.voiceNote,
        this.expectedSalary,
        this.userDescription,
        this.qualification,
        this.compayStatus,
        this.callFeedback,
        this.hiring_status,
        this.appliedTime,
        this.comShortlistStatus,
        this.hiring_time,
        this.companyShortlistTime,
        this.hrTime });


  HiredUserList.fromJson(Map<String, dynamic> json) {
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
    referenceCode = json['reference_code'];
    referCode = json['refer_code'];
    bio = json['bio'];
    experience = json['experience'];
    profileImage = json['profile_image'];
    resume = json['resume'];
    voiceNote = json['voice_note'];
    expectedSalary = json['expected_salary'];
    userDescription = json['user description'];
    qualification = json['qualification'];
    compayStatus = json['compay_status'];
    callFeedback = json['call_feedback'];
    hiring_status = json['hiring_status'];
    hiring_time = json['hiring_time'];
    appliedTime = json['applied_time'];
    comShortlistStatus = json['com_shortlist_status'];
    companyShortlistTime = json['company_shortlist_time'];
    hrTime = json['hr_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
    data['reference_code'] = this.referenceCode;
    data['refer_code'] = this.referCode;
    data['bio'] = this.bio;
    data['experience'] = this.experience;
    data['profile_image'] = this.profileImage;
    data['resume'] = this.resume;
    data['voice_note'] = this.voiceNote;
    data['expected_salary'] = this.expectedSalary;
    data['user description'] = this.userDescription;
    data['qualification'] = this.qualification;
    data['compay_status'] = this.compayStatus;
    data['call_feedback'] = this.callFeedback;
    data['hiring_status'] = this.hiring_status;
    data['hiring_time'] = this.hiring_time;
    data['applied_time'] = this.appliedTime;
    data['com_shortlist_status'] = this.comShortlistStatus;
    data['company_shortlist_time'] = this.companyShortlistTime;
    data ['hr_time'] = this.hrTime;
    return data;
  }
}
