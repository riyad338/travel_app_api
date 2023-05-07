class PopularDealsModel {
  int? i0;
  List<PopularDeals>? popularDeals;

  PopularDealsModel({this.i0, this.popularDeals});

  PopularDealsModel.fromJson(Map<String, dynamic> json) {
    i0 = json['0'];
    if (json['popular_Deals'] != null) {
      popularDeals = <PopularDeals>[];
      json['popular_Deals'].forEach((v) {
        popularDeals!.add(new PopularDeals.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['0'] = this.i0;
    if (this.popularDeals != null) {
      data['popular_Deals'] =
          this.popularDeals!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PopularDeals {
  int? id;
  String? name;
  String? divisionId;
  String? location;
  String? description;
  String? price;
  String? offerPrice;
  String? discount;
  String? latitude;
  String? longitude;
  String? contactNo;
  String? facebookPage;
  String? websiteLink;
  String? youtubeLink;
  String? photo;
  String? tags;
  String? services;
  String? status;
  String? popularDeal;
  Null? createdAt;
  String? updatedAt;

  PopularDeals(
      {this.id,
      this.name,
      this.divisionId,
      this.location,
      this.description,
      this.price,
      this.offerPrice,
      this.discount,
      this.latitude,
      this.longitude,
      this.contactNo,
      this.facebookPage,
      this.websiteLink,
      this.youtubeLink,
      this.photo,
      this.tags,
      this.services,
      this.status,
      this.popularDeal,
      this.createdAt,
      this.updatedAt});

  PopularDeals.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    divisionId = json['division_id'];
    location = json['location'];
    description = json['description'];
    price = json['price'];
    offerPrice = json['offer_price'];
    discount = json['discount'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    contactNo = json['contact_no'];
    facebookPage = json['facebook_page'];
    websiteLink = json['website_link'];
    youtubeLink = json['youtube_link'];
    photo = json['photo'];
    tags = json['tags'];
    services = json['services'];
    status = json['status'];
    popularDeal = json['popular_deal'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['division_id'] = this.divisionId;
    data['location'] = this.location;
    data['description'] = this.description;
    data['price'] = this.price;
    data['offer_price'] = this.offerPrice;
    data['discount'] = this.discount;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['contact_no'] = this.contactNo;
    data['facebook_page'] = this.facebookPage;
    data['website_link'] = this.websiteLink;
    data['youtube_link'] = this.youtubeLink;
    data['photo'] = this.photo;
    data['tags'] = this.tags;
    data['services'] = this.services;
    data['status'] = this.status;
    data['popular_deal'] = this.popularDeal;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
