import 'package:flutter/cupertino.dart';
import 'package:travel_app/CustomHttp/customhttp.dart';
import 'package:travel_app/models/popular_deals.dart';
import 'package:travel_app/models/user_model.dart';

class HomePageProvider with ChangeNotifier {
  PopularDealsModel? popularDealsModel;
  UserModel? userModel;

  Future<PopularDealsModel> popularDeal() async {
    popularDealsModel = await CustomHttpRequest.popularDeal();

    return popularDealsModel!;
  }

  Future<UserModel> userdata() async {
    userModel = await CustomHttpRequest.userdata();

    return userModel!;
  }
}
