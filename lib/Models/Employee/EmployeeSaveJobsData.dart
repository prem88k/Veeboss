class EmployeeSaveJobsData {
  bool? isError;
  List<SaveJobsList>? data;
  String? message;

  EmployeeSaveJobsData({this.isError, this.data, this.message});

  EmployeeSaveJobsData.fromJson(Map<String, dynamic> json) {
    isError = json['is_error'];
    if (json['data'] != null) {
      data = <SaveJobsList>[];
      json['data'].forEach((v) {
        data!.add(new SaveJobsList.fromJson(v));
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

class SaveJobsList {
  int? id;
  int? userId;
  String? description;
  String? post;
  int? vacancy;
  int? isClosed;
  String? city;
  String? profile_photo;
  String? createdAt;
  File? file;

  SaveJobsList(
      {this.id,
        this.userId,
        this.description,
        this.post,
        this.vacancy,
        this.isClosed,
        this.city,
        this.profile_photo,
        this.createdAt,
        this.file});

  SaveJobsList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    description = json['description'];
    post = json['post'];
    vacancy = json['vacancy'];
    profile_photo = json['profile_photo'];
    isClosed = json['is_closed'];
    city = json['city'];
    createdAt = json['created_at'];
    file = json['file'] != null ? new File.fromJson(json['file']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['description'] = this.description;
    data['post'] = this.post;
    data['profile_photo'] = this.profile_photo;
    data['vacancy'] = this.vacancy;
    data['is_closed'] = this.isClosed;
    data['city'] = this.city;
    data['created_at'] = this.createdAt;
    if (this.file != null) {
      data['file'] = this.file!.toJson();
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