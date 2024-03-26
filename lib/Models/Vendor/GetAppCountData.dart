class GetAppCountData {
  bool? isError;
  List<CountList>? data;
  String? message;

  GetAppCountData({this.isError, this.data, this.message});

  GetAppCountData.fromJson(Map<String, dynamic> json) {
    isError = json['is_error'];
    if (json['data'] != null) {
      data = <CountList>[];
      json['data'].forEach((v) {
        data!.add(new CountList.fromJson(v));
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

class CountList {
  int? applied;
  int? sortlisted;
  int? rejected;
  int? hired;
  int? totalJobs;

  CountList(
      {this.applied,
        this.sortlisted,
        this.rejected,
        this.hired,
        this.totalJobs});

  CountList.fromJson(Map<String, dynamic> json) {
    applied = json['applied'];
    sortlisted = json['sortlisted'];
    rejected = json['rejected'];
    hired = json['hired'];
    totalJobs = json['total_jobs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['applied'] = this.applied;
    data['sortlisted'] = this.sortlisted;
    data['rejected'] = this.rejected;
    data['hired'] = this.hired;
    data['total_jobs'] = this.totalJobs;
    return data;
  }
}