class GetAreaData {
  bool? success;
  List<AreaList>? data;

  GetAreaData({this.success, this.data});

  GetAreaData.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <AreaList>[];
      json['data'].forEach((v) {
        data!.add(new AreaList.fromJson(v));
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

class AreaList {
  int? id;
  int? cityId;
  String? area;
  String? createdAt;
  String? updatedAt;

  AreaList({this.id, this.cityId, this.area, this.createdAt, this.updatedAt});

  AreaList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cityId = json['city_id'];
    area = json['area'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['city_id'] = this.cityId;
    data['area'] = this.area;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}