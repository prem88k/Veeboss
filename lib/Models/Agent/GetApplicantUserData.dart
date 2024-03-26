class GetApplicantUserData {
  bool? isError;
  List<AppliedUserList>? data;
  String? message;

  GetApplicantUserData({this.isError, this.data, this.message});

  GetApplicantUserData.fromJson(Map<String, dynamic> json) {
    isError = json['is_error'];
    if (json['data'] != null) {
      data = <AppliedUserList>[];
      json['data'].forEach((v) {
        data!.add(new AppliedUserList.fromJson(v));
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

class AppliedUserList {
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
  String? language;
  String? callFeedback;

  AppliedUserList(
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
        this.language,
        this.compayStatus,
        this.callFeedback});


  AppliedUserList.fromJson(Map<String, dynamic> json) {
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
    language = json['language'];
    callFeedback = json['call_feedback'];
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
    data['language'] = this.language;
    data['call_feedback'] = this.callFeedback;
    return data;
  }
}
