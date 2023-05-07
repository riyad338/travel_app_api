class LatestCampaignModel {
  int? i0;
  List<Campaign>? campaign;

  LatestCampaignModel({this.i0, this.campaign});

  LatestCampaignModel.fromJson(Map<String, dynamic> json) {
    i0 = json['0'];
    if (json['campaign'] != null) {
      campaign = <Campaign>[];
      json['campaign'].forEach((v) {
        campaign!.add(new Campaign.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['0'] = this.i0;
    if (this.campaign != null) {
      data['campaign'] = this.campaign!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Campaign {
  int? id;
  String? title;
  String? type;
  String? startDate;
  String? endDate;
  String? photo;
  String? onTop;
  String? createdAt;
  String? updatedAt;

  Campaign(
      {this.id,
      this.title,
      this.type,
      this.startDate,
      this.endDate,
      this.photo,
      this.onTop,
      this.createdAt,
      this.updatedAt});

  Campaign.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    type = json['type'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    photo = json['photo'];
    onTop = json['on_top'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['type'] = this.type;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['photo'] = this.photo;
    data['on_top'] = this.onTop;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
