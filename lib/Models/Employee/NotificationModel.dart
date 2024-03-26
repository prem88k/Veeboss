class NotificationData {
  bool? isError;
  List<NotificationList>? data;
  String? message;
  String? pageCount;

  NotificationData({this.isError, this.data, this.message, this.pageCount});

  NotificationData.fromJson(Map<String, dynamic> json) {
    isError = json['is_error'];
    if (json['data'] != null) {
      data = <NotificationList>[];
      json['data'].forEach((v) {
        data!.add(new NotificationList.fromJson(v));
      });
    }
    message = json['message'];
    pageCount = json['page_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['is_error'] = this.isError;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    data['page_count'] = this.pageCount;
    return data;
  }
}

class NotificationList {
  int? id;
  String? userId;
  int? jobId;
  String? title;
  String? message;
  String? createdAt;
  String? updatedAt;

  NotificationList(
      {this.id,
        this.userId,
        this.jobId,
        this.title,
        this.message,
        this.createdAt,
        this.updatedAt});

  NotificationList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    title = json['title'];
    jobId=json['job_id'];
    message = json['message'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['title'] = this.title;
    data['message'] = this.message;
    data['job_id']=this.jobId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}