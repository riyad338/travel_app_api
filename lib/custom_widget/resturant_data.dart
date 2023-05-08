import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/providers/hotel_provider.dart';
import 'package:travel_app/providers/resturant_provider.dart';
import 'package:travel_app/screens/hotel_detils_pge.dart';
import 'package:travel_app/screens/resturant_details_page.dart';

class ResturantData extends StatefulWidget {
  const ResturantData({Key? key}) : super(key: key);

  @override
  State<ResturantData> createState() => _HotelDataState();
}

class _HotelDataState extends State<ResturantData> {
  late ResturantProvider resturantProvider;

  void didChangeDependencies() {
    resturantProvider = Provider.of<ResturantProvider>(context);
    resturantProvider.allResturant();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 430.h,
      child: FutureBuilder(
          future: resturantProvider.allResturant(),
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
                shrinkWrap: true,
                itemCount: resturantProvider
                    .resturantModel!.restaurantsWithMenusAndRating!.length,
                itemBuilder: (context, index) {
                  var data = resturantProvider
                      .resturantModel!.restaurantsWithMenusAndRating![index];
                  var name = resturantProvider.resturantModel!
                      .restaurantsWithMenusAndRating![index].name;
                  var id = resturantProvider
                      .resturantModel!.restaurantsWithMenusAndRating![index].id;

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                            context, ResturantDetailsPage.routeName,
                            arguments: [data, name, id]);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
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
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                ),
                                Text("${data.description}"),
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
