import 'package:flutter/cupertino.dart';
import 'package:travel_app/CustomHttp/customhttp.dart';
import 'package:travel_app/models/hotel_model.dart';

class HotelProvider with ChangeNotifier {
  HotelModel? hotelModel;
  Rooms? rooms;
  Future<HotelModel> allHotel() async {
    hotelModel = await CustomHttpRequest.allhotel();

    return hotelModel!;
  }
}
