class GetAllSearchJobPosts {
  bool? isError;
  List<SearchJobList>? data;
  String? message;

  GetAllSearchJobPosts({this.isError, this.data, this.message});

  GetAllSearchJobPosts.fromJson(Map<String, dynamic> json) {
    isError = json['is_error'];
    if (json['data'] != null) {
      data = <SearchJobList>[];
      json['data'].forEach((v) {
        data!.add(new SearchJobList.fromJson(v));
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

class SearchJobList {
  int? id;
  int? userId;
  String? description;
  String? post;
  int? vacancy;
  String? skills;
  Null? ageCriteria;
  String? state;
  String? companyAddress;
  String? companyInfo;
  String? shift;
  String? communicationCategory;
  Null? website;
  Null? position;
  String? gender;
  String? qualification;
  String? salary;
  String? language;
  String? workingDays;
  String? shiftTiming;
  Null? facility;
  String? salaryEnd;
  Null? jobType;
  String? maxExp;
  String? minExp;
  String? jobbenefits;
  String? jobSTime;
  String? jobETime;
  int? isClosed;
  String? location;
  String? isSave;
  String? isApply;
  String? createdAt;
  File? file;
  Null? profilePhoto;

  SearchJobList(
      {this.id,
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
        this.website,
        this.position,
        this.gender,
        this.qualification,
        this.salary,
        this.language,
        this.workingDays,
        this.shiftTiming,
        this.facility,
        this.salaryEnd,
        this.jobType,
        this.maxExp,
        this.minExp,
        this.jobbenefits,
        this.jobSTime,
        this.jobETime,
        this.isClosed,
        this.location,
        this.isSave,
        this.isApply,
        this.createdAt,
        this.file,
        this.profilePhoto});

  SearchJobList.fromJson(Map<String, dynamic> json) {
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
    website = json['website'];
    position = json['position'];
    gender = json['gender'];
    qualification = json['qualification'];
    salary = json['salary'];
    language = json['language'];
    workingDays = json['working_days'];
    shiftTiming = json['shift_timing'];
    facility = json['facility'];
    salaryEnd = json['salaryEnd'];
    jobType = json['job_type'];
    maxExp = json['maxExp'];
    minExp = json['minExp'];
    jobbenefits = json['jobbenefits'];
    jobSTime = json['jobSTime'];
    jobETime = json['jobETime'];
    isClosed = json['is_closed'];
    location = json['location'];
    isSave = json['is_save'];
    isApply = json['is_apply'];
    createdAt = json['created_at'];
    file = json['file'] != null ? new File.fromJson(json['file']) : null;
    profilePhoto = json['profile_photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
    data['website'] = this.website;
    data['position'] = this.position;
    data['gender'] = this.gender;
    data['qualification'] = this.qualification;
    data['salary'] = this.salary;
    data['language'] = this.language;
    data['working_days'] = this.workingDays;
    data['shift_timing'] = this.shiftTiming;
    data['facility'] = this.facility;
    data['salaryEnd'] = this.salaryEnd;
    data['job_type'] = this.jobType;
    data['maxExp'] = this.maxExp;
    data['minExp'] = this.minExp;
    data['jobbenefits'] = this.jobbenefits;
    data['jobSTime'] = this.jobSTime;
    data['jobETime'] = this.jobETime;
    data['is_closed'] = this.isClosed;
    data['location'] = this.location;
    data['is_save'] = this.isSave;
    data['is_apply'] = this.isApply;
    data['created_at'] = this.createdAt;
    if (this.file != null) {
      data['file'] = this.file!.toJson();
    }
    data['profile_photo'] = this.profilePhoto;
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