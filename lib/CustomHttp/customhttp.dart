import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_app/models/hotel_model.dart';
import 'package:travel_app/models/latest_campaign.dart';
import 'package:travel_app/models/popular_deals.dart';
import 'package:travel_app/models/resturant_model.dart';
import 'package:travel_app/models/user_model.dart';
import 'package:travel_app/utils/constance.dart';

class CustomHttpRequest {
  static Future<Map<String, String>> getHeaderWithToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var header = {
      "Accept": "application/json",
      "Authorization": "Bearer ${sharedPreferences.getString("token")}"
    };
    return header;
  }

  static Future<dynamic> popularDeal() async {
    PopularDealsModel? popularDealsModel;
    final url = "${baseUrl}popular_deals_hotel";

    try {
      final response = await http.get(Uri.parse(url),
          headers: await CustomHttpRequest.getHeaderWithToken());
      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        popularDealsModel = PopularDealsModel.fromJson(data);
      }
      return popularDealsModel!;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  static Future<UserModel> userdata() async {
    UserModel? userModel;
    final url = "${baseUrl}user";

    try {
      final response = await http.get(Uri.parse(url),
          headers: await CustomHttpRequest.getHeaderWithToken());
      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        userModel = UserModel.fromJson(data);
      }
      return userModel!;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  static Future<HotelModel> allhotel() async {
    HotelModel? hotelModel;
    final url = "${baseUrl}all-hotel";

    try {
      final response = await http.get(Uri.parse(url),
          headers: await CustomHttpRequest.getHeaderWithToken());
      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        hotelModel = HotelModel.fromJson(data);
      }
      return hotelModel!;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  static Future<ResturantModel> allResturant() async {
    ResturantModel? resturantModel;
    final url = "${baseUrl}all-restaurant";

    try {
      final response = await http.get(Uri.parse(url),
          headers: await CustomHttpRequest.getHeaderWithToken());
      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        resturantModel = ResturantModel.fromJson(data);
      }
      return resturantModel!;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  static Future<LatestCampaignModel> latestCampaign() async {
    LatestCampaignModel? latestCampaignModel;
    final url = "${baseUrl}latest-campaign";

    try {
      final response = await http.get(Uri.parse(url),
          headers: await CustomHttpRequest.getHeaderWithToken());
      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        latestCampaignModel = LatestCampaignModel.fromJson(data);
      }
      return latestCampaignModel!;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}
