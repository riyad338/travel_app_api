class ResturantModel {
  int? i0;
  List<RestaurantsWithMenusAndRating>? restaurantsWithMenusAndRating;

  ResturantModel({this.i0, this.restaurantsWithMenusAndRating});

  ResturantModel.fromJson(Map<String, dynamic> json) {
    i0 = json['0'];
    if (json['Restaurants with menus and Rating'] != null) {
      restaurantsWithMenusAndRating = <RestaurantsWithMenusAndRating>[];
      json['Restaurants with menus and Rating'].forEach((v) {
        restaurantsWithMenusAndRating!
            .add(new RestaurantsWithMenusAndRating.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['0'] = this.i0;
    if (this.restaurantsWithMenusAndRating != null) {
      data['Restaurants with menus and Rating'] =
          this.restaurantsWithMenusAndRating!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RestaurantsWithMenusAndRating {
  int? id;
  String? name;
  String? divisionId;
  String? location;
  String? description;
  String? discount;
  String? latitude;
  String? longitude;
  String? contactNo;
  String? facebookPage;
  String? websiteLink;
  String? youtubeLink;
  String? photo;
  String? tags;
  String? popularDeal;
  String? status;
  String? createdAt;
  String? updatedAt;
  List<RestaurantMenu>? restaurantMenu;
  Restaurantrating? restaurantrating;

  RestaurantsWithMenusAndRating(
      {this.id,
      this.name,
      this.divisionId,
      this.location,
      this.description,
      this.discount,
      this.latitude,
      this.longitude,
      this.contactNo,
      this.facebookPage,
      this.websiteLink,
      this.youtubeLink,
      this.photo,
      this.tags,
      this.popularDeal,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.restaurantMenu,
      this.restaurantrating});

  RestaurantsWithMenusAndRating.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    divisionId = json['division_id'];
    location = json['location'];
    description = json['description'];
    discount = json['discount'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    contactNo = json['contact_no'];
    facebookPage = json['facebook_page'];
    websiteLink = json['website_link'];
    youtubeLink = json['youtube_link'];
    photo = json['photo'];
    tags = json['tags'];
    popularDeal = json['popular_deal'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['restaurant_menu'] != null) {
      restaurantMenu = <RestaurantMenu>[];
      json['restaurant_menu'].forEach((v) {
        restaurantMenu!.add(new RestaurantMenu.fromJson(v));
      });
    }
    restaurantrating = json['restaurantrating'] != null
        ? new Restaurantrating.fromJson(json['restaurantrating'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['division_id'] = this.divisionId;
    data['location'] = this.location;
    data['description'] = this.description;
    data['discount'] = this.discount;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['contact_no'] = this.contactNo;
    data['facebook_page'] = this.facebookPage;
    data['website_link'] = this.websiteLink;
    data['youtube_link'] = this.youtubeLink;
    data['photo'] = this.photo;
    data['tags'] = this.tags;
    data['popular_deal'] = this.popularDeal;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.restaurantMenu != null) {
      data['restaurant_menu'] =
          this.restaurantMenu!.map((v) => v.toJson()).toList();
    }
    if (this.restaurantrating != null) {
      data['restaurantrating'] = this.restaurantrating!.toJson();
    }
    return data;
  }
}

class RestaurantMenu {
  int? id;
  String? restaurantId;
  String? name;
  String? description;
  String? discount;
  String? photo;
  String? tags;
  String? status;
  Null? createdAt;
  String? updatedAt;

  RestaurantMenu(
      {this.id,
      this.restaurantId,
      this.name,
      this.description,
      this.discount,
      this.photo,
      this.tags,
      this.status,
      this.createdAt,
      this.updatedAt});

  RestaurantMenu.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    restaurantId = json['restaurant_id'];
    name = json['name'];
    description = json['description'];
    discount = json['discount'];
    photo = json['photo'];
    tags = json['tags'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['restaurant_id'] = this.restaurantId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['discount'] = this.discount;
    data['photo'] = this.photo;
    data['tags'] = this.tags;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Restaurantrating {
  int? id;
  String? restaurantId;
  Null? feedback;
  String? star;
  String? createdAt;
  String? updatedAt;

  Restaurantrating(
      {this.id,
      this.restaurantId,
      this.feedback,
      this.star,
      this.createdAt,
      this.updatedAt});

  Restaurantrating.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    restaurantId = json['restaurant_id'];
    feedback = json['feedback'];
    star = json['star'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['restaurant_id'] = this.restaurantId;
    data['feedback'] = this.feedback;
    data['star'] = this.star;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
