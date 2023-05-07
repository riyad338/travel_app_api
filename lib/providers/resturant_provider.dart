import 'package:flutter/cupertino.dart';
import 'package:travel_app/CustomHttp/customhttp.dart';
import 'package:travel_app/models/hotel_model.dart';
import 'package:travel_app/models/resturant_model.dart';

class ResturantProvider with ChangeNotifier {
  ResturantModel? resturantModel;
  Future<ResturantModel> allResturant() async {
    resturantModel = await CustomHttpRequest.allResturant();

    return resturantModel!;
  }
}
