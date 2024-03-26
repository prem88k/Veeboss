class GetAssignAllCompany {
  bool? success;
  List<CompanyUserList>? assingnCompanyUser;

  GetAssignAllCompany({this.success, this.assingnCompanyUser});

  GetAssignAllCompany.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['assingn company user'] != null) {
      assingnCompanyUser = <CompanyUserList>[];
      json['assingn company user'].forEach((v) {
        assingnCompanyUser!.add(new CompanyUserList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.assingnCompanyUser != null) {
      data['assingn company user'] =
          this.assingnCompanyUser!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CompanyUserList {
  int? id;
  int? jobId;
  String? name;
  String? email;
  String? contactNo;
  int? age;
  String? location;
  String? profileImage;
  String? resume;
  String? role;
  String? bio;
  String? experience;
  String? referenceCode;
  String? referCode;
  String? createdAt;
  String? updatedAt;
  List<Hr>? hr;
  List<Agent>? agent;

  CompanyUserList(
      {this.id,
        this.jobId,
        this.name,
        this.email,
        this.contactNo,
        this.age,
        this.location,
        this.profileImage,
        this.resume,
        this.role,
        this.bio,
        this.experience,
        this.referenceCode,
        this.referCode,
        this.createdAt,
        this.updatedAt,
        this.hr,
        this.agent});

  CompanyUserList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    jobId = json['job_id'];
    name = json['name'];
    email = json['email'];
    contactNo = json['contact_no'];
    age = json['age'];
    location = json['location'];
    profileImage = json['profile_image'];
    resume = json['resume'];
    role = json['role'];
    bio = json['bio'];
    experience = json['experience'];
    referenceCode = json['reference_code'];
    referCode = json['refer_code'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['hr'] != null) {
      hr = <Hr>[];
      json['hr'].forEach((v) {
        hr!.add(new Hr.fromJson(v));
      });
    }
    if (json['agent'] != null) {
      agent = <Agent>[];
      json['agent'].forEach((v) {
        agent!.add(new Agent.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['job_id'] = this.jobId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['contact_no'] = this.contactNo;
    data['age'] = this.age;
    data['location'] = this.location;
    data['profile_image'] = this.profileImage;
    data['resume'] = this.resume;
    data['role'] = this.role;
    data['bio'] = this.bio;
    data['experience'] = this.experience;
    data['reference_code'] = this.referenceCode;
    data['refer_code'] = this.referCode;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.hr != null) {
      data['hr'] = this.hr!.map((v) => v.toJson()).toList();
    }
    if (this.agent != null) {
      data['agent'] = this.agent!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Hr {
  int? id;
  String? name;
  String? email;
  String? contactNo;
  String? companyInfo;
  String? address;
  String? profileImage;
  String? createdAt;
  String? updatedAt;

  Hr(
      {this.id,
        this.name,
        this.email,
        this.contactNo,
        this.companyInfo,
        this.address,
        this.profileImage,
        this.createdAt,
        this.updatedAt});

  Hr.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    contactNo = json['contact_no'];
    companyInfo = json['company_info'];
    address = json['address'];
    profileImage = json['profile_image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['contact_no'] = this.contactNo;
    data['company_info'] = this.companyInfo;
    data['address'] = this.address;
    data['profile_image'] = this.profileImage;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Agent {
  int? id;
  String? name;
  String? email;
  String? contactNo;
  String? companyInfo;
  String? about;
  String? address;
  String? profileImage;
  String? referenceCode;
  String? createdAt;
  String? updatedAt;

  Agent(
      {this.id,
        this.name,
        this.email,
        this.contactNo,
        this.companyInfo,
        this.about,
        this.profileImage,
        this.address,
        this.referenceCode,
        this.createdAt,
        this.updatedAt});

  Agent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    contactNo = json['contact_no'];
    companyInfo = json['company_info'];
    profileImage = json['profileImage'];
    about = json['about'];
    address = json['address'];
    referenceCode = json['reference_code'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['profileImage'] = this.profileImage;
    data['contact_no'] = this.contactNo;
    data['company_info'] = this.companyInfo;
    data['about'] = this.about;
    data['address'] = this.address;
    data['reference_code'] = this.referenceCode;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}