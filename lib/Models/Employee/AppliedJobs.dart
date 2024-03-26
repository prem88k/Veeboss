class UserAppliedJobs {
  bool? isError;
  List<Jobs>? data;
  String? message;

  UserAppliedJobs({this.isError, this.data, this.message});

  UserAppliedJobs.fromJson(Map<String, dynamic> json) {
    isError = json['is_error'];
    if (json['data'] != null) {
      data = <Jobs>[];
      json['data'].forEach((v) {
        data!.add(new Jobs.fromJson(v));
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

class Jobs {
  String? expectedSalary;
  String? userDescription;
  String? qualification;
  String? experience;
  String? hrStatus;
  String? time;
  String? companyStatus;
  String? hiringStatus;
  String? comShortlistStatus;
  String? language;
  String? appliedTime;
  String? hrTime;
  String? companyShortlistTime;
  String? hiringTime;
  int? id;
  int? userId;
  String? description;
  String? post;
  int? vacancy;
  String? skills;
  String? ageCriteria;
  String? state;
  String? companyAddress;
  String? companyInfo;
  String? shift;
  String? communicationCategory;
  int? isClosed;
  String? city;
  String? location;
  String? profilePhoto;
  String? createdAt;
  Null? file;

  Jobs(
      {this.expectedSalary,
        this.userDescription,
        this.qualification,
        this.experience,
        this.hrStatus,
        this.time,
        this.companyStatus,
        this.hiringStatus,
        this.comShortlistStatus,
        this.language,
        this.appliedTime,
        this.hrTime,
        this.companyShortlistTime,
        this.hiringTime,
        this.id,
        this.userId,
        this.description,
        this.post,
        this.vacancy,
        this.skills,
        this.ageCriteria,
        this.state,
        this.companyAddress,
        this.companyInfo,
        this.shift,
        this.communicationCategory,
        this.isClosed,
        this.city,
        this.location,
        this.profilePhoto,
        this.createdAt,
        this.file});

  Jobs.fromJson(Map<String, dynamic> json) {
    expectedSalary = json['expected_salary'];
    userDescription = json['user description'];
    qualification = json['qualification'];
    experience = json['experience'];
    hrStatus = json['hr_status'];
    time = json['time'];
    companyStatus = json['company_status'];
    hiringStatus = json['hiring_status'];
    comShortlistStatus = json['com_shortlist_status'];
    language = json['language'];
    appliedTime = json['applied_time'];
    hrTime = json['hr_time'];
    companyShortlistTime = json['company_shortlist_time'];
    hiringTime = json['hiring_time'];
    id = json['id'];
    userId = json['user_id'];
    description = json['description'];
    post = json['post'];
    vacancy = json['vacancy'];
    skills = json['skills'];
    ageCriteria = json['age_criteria'];
    state = json['state'];
    companyAddress = json['company_address'];
    companyInfo = json['company_info'];
    shift = json['shift'];
    communicationCategory = json['communication_category'];
    isClosed = json['is_closed'];
    city = json['city'];
    location = json['location'];
    profilePhoto = json['profile_photo'];
    createdAt = json['created_at'];
    file = json['file'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['expected_salary'] = this.expectedSalary;
    data['user description'] = this.userDescription;
    data['qualification'] = this.qualification;
    data['experience'] = this.experience;
    data['hr_status'] = this.hrStatus;
    data['time'] = this.time;
    data['company_status'] = this.companyStatus;
    data['hiring_status'] = this.hiringStatus;
    data['com_shortlist_status'] = this.comShortlistStatus;
    data['language'] = this.language;
    data['applied_time'] = this.appliedTime;
    data['hr_time'] = this.hrTime;
    data['company_shortlist_time'] = this.companyShortlistTime;
    data['hiring_time'] = this.hiringTime;
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['description'] = this.description;
    data['post'] = this.post;
    data['vacancy'] = this.vacancy;
    data['skills'] = this.skills;
    data['age_criteria'] = this.ageCriteria;
    data['state'] = this.state;
    data['company_address'] = this.companyAddress;
    data['company_info'] = this.companyInfo;
    data['shift'] = this.shift;
    data['communication_category'] = this.communicationCategory;
    data['is_closed'] = this.isClosed;
    data['city'] = this.city;
    data['location'] = this.location;
    data['profile_photo'] = this.profilePhoto;
    data['created_at'] = this.createdAt;
    data['file'] = this.file;
    return data;
  }
}