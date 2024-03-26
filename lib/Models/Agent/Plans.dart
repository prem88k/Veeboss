class PlansList {
  bool ?isError;
  List<PlansListItem> ?data;
  String ?message;
  String ?pageCount;

  PlansList({this.isError, this.data, this.message, this.pageCount});

  PlansList.fromJson(Map<String, dynamic> json) {
    isError = json['is_error'];
    if (json['data'] != null) {
      data = <PlansListItem>[];
      json['data'].forEach((v) {
        data!.add(new PlansListItem.fromJson(v));
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

class PlansListItem {
  int? id;
  String? name;
  String ?price;
  Image ?image1;

  PlansListItem({this.id, this.name, this.price, this.image1});

  PlansListItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    image1 = json['image'] != null ? new Image.fromJson(json['image']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    if (this.image1 != null) {
      data['image'] = this.image1!.toJson();
    }
    return data;
  }
}

class Image {
  int? id;
  String ?fileName;
  String ?mainImageUrl;
  String ?thumbImageUrl;

  Image({this.id, this.fileName, this.mainImageUrl, this.thumbImageUrl});

  Image.fromJson(Map<String, dynamic> json) {
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