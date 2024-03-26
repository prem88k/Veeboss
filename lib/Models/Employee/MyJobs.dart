class GetAllMyJobPosts {
  bool? isError;
  int? activeCount;
  int? inactiveCount;
  List<jobList>? data;
  String? message;

  GetAllMyJobPosts({this.isError,   this.activeCount, this.inactiveCount, this.data, this.message});

  GetAllMyJobPosts.fromJson(Map<String, dynamic> json) {
    isError = json['is_error'];
    activeCount = json['active_count'];
    inactiveCount = json['inactive_count'];
    if (json['data'] != null) {
      data = <jobList>[];
      json['data'].forEach((v) {
        data!.add(new jobList.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['is_error'] = this.isError;
    data['active_count'] = this.activeCount;
    data['inactive_count'] = this.inactiveCount;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class jobList {
  int? id;
  int? userId;
  String? description;
  String? post;
  int? vacancy;
  String? skills;
  String? ageCriteria;
  String?  state;
  String? companyAddress;
  String? companyInfo;
  String? website;
  String? position;
  int? isClosed;
  String? city;
  String? gender;
  String? qualification;
  String? salary;
  String? language;
  String? workingDays;
  String? shiftTiming;
  String? facility;
  String? salaryEnd;
  String? jobType;
  String? maxExp;
  String? minExp;
  String? jobbenefits;
  String? jobSTime;
  String? jobETime;
  String? isSave;
  String? isApply;
  String? createdAt;
  ImageFile? file;
  String? profile_photo;
  String? location;
  String? shift;
  String? communicationCategory;

  jobList(
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
        this.website,
        this.position,
        this.isClosed,
        this.city,
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
        this.isSave,
        this.isApply,
        this.createdAt,
        this.file,
        this.location,
        this.profile_photo,
        this.shift,
        this.communicationCategory,});

  jobList.fromJson(Map<String, dynamic> json) {
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
    website = json['website'];
    position = json['position'];
    isClosed = json['is_closed'];
    city = json['city'];
    gender = json['gender'];
    qualification = json['qualification'];
    salary = json['salary'];
    language = json['language'];
    workingDays = json['working_days'];
    shiftTiming = json['shift_timing'];
    facility = json['facility'];
    salaryEnd = json['salaryEnd'];
    jobType = json['job_type'];
    location = json['location'];
    maxExp = json['maxExp'];
    minExp = json['minExp'];
    jobbenefits = json['jobbenefits'];
    jobSTime = json['jobSTime'];
    jobETime = json['jobETime'];
    isSave = json['is_save'];
    isApply = json['is_apply'];
    createdAt = json['created_at'];
    shift = json['shift'];
    communicationCategory = json['communication_category'];
    file = json['file'] != null ? new ImageFile.fromJson(json['file']) : null;
    profile_photo = json['profile_photo'];
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
    data['website'] = this.website;
    data['position'] = this.position;
    data['is_closed'] = this.isClosed;
    data['city'] = this.city;
    data['gender'] = this.gender;
    data['qualification'] = this.qualification;
    data['salary'] = this.salary;
    data['language'] = this.language;
    data['working_days'] = this.workingDays;
    data['shift_timing'] = this.shiftTiming;
    data['facility'] = this.facility;
    data['salaryEnd'] = this.salaryEnd;
    data['job_type'] = this.jobType;
    data['location'] = this.location;
    data['maxExp'] = this.maxExp;
    data['minExp'] = this.minExp;
    data['jobbenefits'] = this.jobbenefits;
    data['jobSTime'] = this.jobSTime;
    data['jobETime'] = this.jobETime;
    data['is_save'] = this.isSave;
    data['is_apply'] = this.isApply;
    data['created_at'] = this.createdAt;
    data['shift'] = this.shift;
    data['communication_category'] = this.communicationCategory;
    if (this.file != null) {
      data['file'] = this.file!.toJson();
    }
    data['profile_photo'] = this.profile_photo;
    return data;
  }
}

class ImageFile {
  int? id;
  String? fileName;
  String? mainImageUrl;
  String? thumbImageUrl;

  ImageFile({this.id, this.fileName, this.mainImageUrl, this.thumbImageUrl});

  ImageFile.fromJson(Map<String, dynamic> json) {
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