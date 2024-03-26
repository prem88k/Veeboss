class ApplicantsData {
  bool? isError;
  Data? data;
  String ?message;
  String? pageCount;

  ApplicantsData({this.isError, this.data, this.message, this.pageCount});

  ApplicantsData.fromJson(Map<String, dynamic> json) {
    isError = json['is_error'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
    pageCount = json['page_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['is_error'] = this.isError;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    data['page_count'] = this.pageCount;
    return data;
  }
}

class Data {
  int? id;
  int ?userId;
  String ?description;
  String? post;
  int ?vacancy;
  List<Users>? users;

  Data(
      {this.id,
        this.userId,
        this.description,
        this.post,
        this.vacancy,
        this.users});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    description = json['description'];
    post = json['post'];
    vacancy = json['vacancy'];
    if (json['users'] != null) {
      users = <Users>[];
      json['users'].forEach((v) {
        users!.add(new Users.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['description'] = this.description;
    data['post'] = this.post;
    data['vacancy'] = this.vacancy;
    if (this.users != null) {
      data['users'] = this.users!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Users {
  String? name;
  String? email;
  String ?contactNo;
  String ?status;

  Users({this.name, this.email, this.contactNo, this.status});

  Users.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    contactNo = json['contact_no'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['contact_no'] = this.contactNo;
    data['status'] = this.status;
    return data;
  }
}