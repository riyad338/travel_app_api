class HotelModel {
  int? i0;
  List<HotelList>? hotelList;

  HotelModel({this.i0, this.hotelList});

  HotelModel.fromJson(Map<String, dynamic> json) {
    i0 = json['0'];
    if (json['hotel_list'] != null) {
      hotelList = <HotelList>[];
      json['hotel_list'].forEach((v) {
        hotelList!.add(new HotelList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['0'] = this.i0;
    if (this.hotelList != null) {
      data['hotel_list'] = this.hotelList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HotelList {
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
  String? createdAt;
  String? updatedAt;
  List<Rooms>? rooms;
  HotelRating? hotelRating;

  HotelList(
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
      this.updatedAt,
      this.rooms,
      this.hotelRating});

  HotelList.fromJson(Map<String, dynamic> json) {
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
    if (json['rooms'] != null) {
      rooms = <Rooms>[];
      json['rooms'].forEach((v) {
        rooms!.add(new Rooms.fromJson(v));
      });
    }
    hotelRating = json['hotel_rating'] != null
        ? new HotelRating.fromJson(json['hotel_rating'])
        : null;
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
    if (this.rooms != null) {
      data['rooms'] = this.rooms!.map((v) => v.toJson()).toList();
    }
    if (this.hotelRating != null) {
      data['hotel_rating'] = this.hotelRating!.toJson();
    }
    return data;
  }
}

class Rooms {
  int? id;
  String? hotelId;
  String? title;
  String? subtitle;
  String? description;
  String? offerStartDate;
  String? offerEndDate;
  String? beds;
  String? baths;
  String? price;
  String? discount;
  String? discountPrice;
  String? maxOccupancy;
  String? privatePolicy;
  String? info;
  String? image;
  String? createdAt;
  String? updatedAt;

  Rooms(
      {this.id,
      this.hotelId,
      this.title,
      this.subtitle,
      this.description,
      this.offerStartDate,
      this.offerEndDate,
      this.beds,
      this.baths,
      this.price,
      this.discount,
      this.discountPrice,
      this.maxOccupancy,
      this.privatePolicy,
      this.info,
      this.image,
      this.createdAt,
      this.updatedAt});

  Rooms.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    hotelId = json['hotel_id'];
    title = json['title'];
    subtitle = json['subtitle'];
    description = json['description'];
    offerStartDate = json['offer_start_date'];
    offerEndDate = json['offer_end_date'];
    beds = json['beds'];
    baths = json['baths'];
    price = json['price'];
    discount = json['discount'];
    discountPrice = json['discount_price'];
    maxOccupancy = json['max_occupancy'];
    privatePolicy = json['private_policy'];
    info = json['info'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['hotel_id'] = this.hotelId;
    data['title'] = this.title;
    data['subtitle'] = this.subtitle;
    data['description'] = this.description;
    data['offer_start_date'] = this.offerStartDate;
    data['offer_end_date'] = this.offerEndDate;
    data['beds'] = this.beds;
    data['baths'] = this.baths;
    data['price'] = this.price;
    data['discount'] = this.discount;
    data['discount_price'] = this.discountPrice;
    data['max_occupancy'] = this.maxOccupancy;
    data['private_policy'] = this.privatePolicy;
    data['info'] = this.info;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class HotelRating {
  int? id;
  String? hotelId;
  Null? feedback;
  String? star;
  String? createdAt;
  String? updatedAt;

  HotelRating(
      {this.id,
      this.hotelId,
      this.feedback,
      this.star,
      this.createdAt,
      this.updatedAt});

  HotelRating.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    hotelId = json['hotel_id'];
    feedback = json['feedback'];
    star = json['star'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['hotel_id'] = this.hotelId;
    data['feedback'] = this.feedback;
    data['star'] = this.star;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
