class GetCityData {
  bool? success;
  List<CityList>? data;

  GetCityData({this.success, this.data});

  GetCityData.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <CityList>[];
      json['data'].forEach((v) {
        data!.add(new CityList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CityList {
  int? id;
  String? brandName;
  int? job_counts;
  String? createdAt;
  String? updatedAt;

  CityList({this.id, this.brandName, this.job_counts, this.createdAt, this.updatedAt});

  CityList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    brandName = json['brand_name'];
    job_counts = json['job_counts'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['brand_name'] = this.brandName;
    data['job_counts'] = this.job_counts;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}