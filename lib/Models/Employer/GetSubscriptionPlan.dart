class GetSubscriptionPlan {
  bool? isError;
  List<SubscriptionPlanList>? data;
  String? message;
  String? pageCount;

  GetSubscriptionPlan({this.isError, this.data, this.message, this.pageCount});

  GetSubscriptionPlan.fromJson(Map<String, dynamic> json) {
    isError = json['is_error'];
    if (json['data'] != null) {
      data = <SubscriptionPlanList>[];
      json['data'].forEach((v) {
        data!.add(new SubscriptionPlanList.fromJson(v));
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

class SubscriptionPlanList {
  int? id;
  String? name;
  String? price;
  int? months;
  Null? image;

  SubscriptionPlanList({this.id, this.name, this.price, this.months, this.image});

  SubscriptionPlanList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    months = json['months'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['months'] = this.months;
    data['image'] = this.image;
    return data;
  }
}