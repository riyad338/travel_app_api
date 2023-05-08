import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/providers/hotel_provider.dart';
import 'package:travel_app/screens/hotel_detils_pge.dart';
import 'package:travel_app/utils/constance.dart';

class HotelData extends StatefulWidget {
  const HotelData({Key? key}) : super(key: key);

  @override
  State<HotelData> createState() => _HotelDataState();
}

class _HotelDataState extends State<HotelData> {
  late HotelProvider hotelProvider;

  void didChangeDependencies() {
    hotelProvider = Provider.of<HotelProvider>(context);
    hotelProvider.allHotel();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 430,
      child: FutureBuilder(
          future: hotelProvider.allHotel(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: SpinKitFadingCircle(
                  color: Colors.greenAccent,
                ),
              );
            } else if (snapshot.hasError) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.data == null) {
              return Text("snapshot data are null");
            }
            return ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: hotelProvider.hotelModel!.hotelList!.length,
                itemBuilder: (context, index) {
                  var data = hotelProvider.hotelModel!.hotelList![index];
                  var name = hotelProvider.hotelModel!.hotelList![index].name;
                  var id = hotelProvider.hotelModel!.hotelList![index].id;

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, HotelDetailsPage.routeName,
                            arguments: [data, name, id]);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white70,
                            borderRadius: BorderRadius.circular(20)),
                        height: 150,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: double.infinity,
                              width: 100,
                              child: CachedNetworkImage(
                                imageUrl:
                                    "https://ddtravels.safafirm.com/${data.photo}",
                                width: double.infinity,
                                height: 250,
                                fit: BoxFit.cover,
                                placeholder: (context, url) =>
                                    SpinKitFadingCircle(
                                  color: Colors.greenAccent,
                                ),
                                errorWidget: (context, url, error) =>
                                    Image.asset(
                                  "images/hote.jpg",
                                  fit: BoxFit.cover,
                                ),
                              ),

                              // NetworkImage(
                              //     "https://ddtravels.safafirm.com/${data.photo}"),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${data.name}",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.location_on,
                                          size: 14,
                                        ),
                                        Text(
                                          "${data.location}",
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Color(0xff9C9C9C)),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                        height: 20.h,
                                        width: 40.w,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            color: Colors.grey.shade300),
                                        child: Center(
                                            child: Text("Hotel",
                                                style: mytextstyle(
                                                    Color(0xff9C9C9C),
                                                    13.sp,
                                                    FontWeight.w400)))),
                                    SizedBox(
                                      width: 4.w,
                                    ),
                                    Container(
                                        height: 20.h,
                                        width: 80.w,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            color: Colors.grey.shade300),
                                        child: Center(
                                            child: Text("Restaurent",
                                                style: mytextstyle(
                                                    Color(0xff9C9C9C),
                                                    13.sp,
                                                    FontWeight.w400)))),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color: Color(0xffF4B806),
                                        ),
                                        Icon(
                                          Icons.star,
                                          color: Color(0xffF4B806),
                                        ),
                                        Icon(
                                          Icons.star,
                                          color: Color(0xffF4B806),
                                        ),
                                        Icon(
                                          Icons.star,
                                          color: Color(0xffF4B806),
                                        ),
                                        Icon(
                                          Icons.star,
                                          color: Color(0xffF4B806),
                                        ),
                                      ],
                                    ),
                                    Text("Riview")
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage("images/offershap.png"),
                                      fit: BoxFit.fitHeight,
                                    ),
                                  ),
                                  height: 40,
                                  width: 40,
                                  child: Center(
                                    child: Text(
                                      "${data.discount}%",
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                                Column(
                                  children: [
                                    Text("available offer"),
                                    Text(
                                      "${data.offerPrice}\$",
                                      style: mytextstyle(
                                        Color(0xff08BA64),
                                        15.sp,
                                        FontWeight.w700,
                                      ),
                                    ),
                                    Text(
                                      "${data.price}\$",
                                      style: TextStyle(
                                        decoration: TextDecoration.lineThrough,
                                        color: Color(0xff08BA64),
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                });
          }),
    );
  }
}
