class GetShowAppliedUser {
  bool? isError;
  List<AppliedUserList>? data;
  String? message;

  GetShowAppliedUser({this.isError, this.data, this.message});

  GetShowAppliedUser.fromJson(Map<String, dynamic> json) {
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
  int? userId;
  String? description;
  String? post;
  Null? skills;
  Null? ageCriteria;
  String? state;
  Null? pincode;
  int? vacancy;
  int? isClosed;
  String? city;
  String? createdAt;
  File? file;
  List<AppliedUser>? appliedUser;

  AppliedUserList(
      {this.id,
        this.userId,
        this.description,
        this.post,
        this.skills,
        this.ageCriteria,
        this.state,
        this.pincode,
        this.vacancy,
        this.isClosed,
        this.city,
        this.createdAt,
        this.file,
        this.appliedUser});

  AppliedUserList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    description = json['description'];
    post = json['post'];
    skills = json['skills'];
    ageCriteria = json['age_criteria'];
    state = json['state'];
    pincode = json['pincode'];
    vacancy = json['vacancy'];
    isClosed = json['is_closed'];
    city = json['city'];
    createdAt = json['created_at'];
    file = json['file'] != null ? new File.fromJson(json['file']) : null;
    if (json['Applied User'] != null) {
      appliedUser = <AppliedUser>[];
      json['Applied User'].forEach((v) {
        appliedUser!.add(new AppliedUser.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['description'] = this.description;
    data['post'] = this.post;
    data['skills'] = this.skills;
    data['age_criteria'] = this.ageCriteria;
    data['state'] = this.state;
    data['pincode'] = this.pincode;
    data['vacancy'] = this.vacancy;
    data['is_closed'] = this.isClosed;
    data['city'] = this.city;
    data['created_at'] = this.createdAt;
    if (this.file != null) {
      data['file'] = this.file!.toJson();
    }
    if (this.appliedUser != null) {
      data['Applied User'] = this.appliedUser!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class File {
  int? id;
  String? fileName;
  String? mainImageUrl;
  String? thumbImageUrl;

  File({this.id, this.fileName, this.mainImageUrl, this.thumbImageUrl});

  File.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fileName = json['file_name'];
    mainImageUrl = json['main_image_url'];
    thumbImageUrl = json['thumb_image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['file_name'] = this.fileName;
    data['main_image_url'] = this.mainImageUrl;
    data['thumb_image_url'] = this.thumbImageUrl;
    return data;
  }
}

class AppliedUser {
  int? id;
  String? name;
  String? email;
  String? contactNo;
  Null? website;
  Null? position;
  int? age;
  Null? location;
  String? gender;
  Null? about;
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

  AppliedUser(
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
        this.userDescription});

  AppliedUser.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}