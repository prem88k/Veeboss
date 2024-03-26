class GetBannerData {
  bool? success;
  List<BannerList>? data;

  GetBannerData({this.success, this.data});

  GetBannerData.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <BannerList>[];
      json['data'].forEach((v) {
        data!.add(new BannerList.fromJson(v));
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

class BannerList {
  int? id;
  String? images;
  String? createdAt;
  String? updatedAt;

  BannerList({this.id, this.images, this.createdAt, this.updatedAt});

  BannerList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    images = json['images'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['images'] = this.images;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}