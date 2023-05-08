import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/utils/constance.dart';

class ContactForBooking extends StatefulWidget {
  const ContactForBooking({Key? key}) : super(key: key);

  @override
  State<ContactForBooking> createState() => _ClaimedDiscountPageState();
}

class _ClaimedDiscountPageState extends State<ContactForBooking> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 700,
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(children: [
          Text(
            "Contact for booking",
            style: TextStyle(
                color: Colors.black,
                fontSize: 20.sp,
                fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 20.h,
          ),
          Text(
            "You have to contact Seagull Hotel and\nconfirm your booking. After confirming\nthe booking, claim discount and enjoy\nyour deal.",
            style: TextStyle(
                color: Color(0xff9C9C9C),
                fontSize: 14.sp,
                fontWeight: FontWeight.w400),
          ),
          SizedBox(
            height: 18.h,
          ),
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: ListTile(
              onTap: () {},
              tileColor: Colors.white12,
              leading: Icon(
                Icons.facebook_rounded,
                size: 40,
              ),
              title: Text(
                "Facebook Page",
                style: mytextstyle(Color(0xff9C9C9C), 16, FontWeight.w400),
              ),
              trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey),
            ),
          ),
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: ListTile(
              onTap: () {},
              tileColor: Colors.white12,
              leading: Icon(
                Icons.facebook_rounded,
                size: 40,
              ),
              title: Text(
                "Visit WebSite",
                style: mytextstyle(Color(0xff9C9C9C), 16, FontWeight.w400),
              ),
              trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey),
            ),
          ),
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: ListTile(
              onTap: () {},
              tileColor: Colors.white12,
              leading: Icon(
                Icons.facebook_rounded,
                size: 40,
              ),
              title: Text(
                "Send Email",
                style: mytextstyle(Color(0xff9C9C9C), 16, FontWeight.w400),
              ),
              trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Container(
            height: 1.h,
            width: double.infinity,
            color: Colors.grey,
          ),
          SizedBox(
            height: 20.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)),
                      padding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                      backgroundColor: Colors.greenAccent.shade100),
                  onPressed: () {},
                  child: Row(
                    children: [
                      Icon(
                        Icons.arrow_back,
                        color: Colors.greenAccent,
                        size: 25.sp,
                      ),
                      Text(
                        "Claim Discount",
                        style: TextStyle(
                            color: Color(0xff08BA64),
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  )),
              SizedBox(width: 50.w),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      padding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                      backgroundColor: Color(0xff08BA64)),
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Icon(
                        Icons.phone,
                        color: Colors.white,
                        size: 25.sp,
                      ),
                      Text(
                        "Call the hotel",
                        style: TextStyle(
                            fontSize: 16.sp, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ))
            ],
          )
        ]),
      ),
    );
  }
}
