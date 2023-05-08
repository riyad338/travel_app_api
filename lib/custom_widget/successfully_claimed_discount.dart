import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SuccessfullyClaimed extends StatefulWidget {
  const SuccessfullyClaimed({Key? key}) : super(key: key);

  @override
  State<SuccessfullyClaimed> createState() => _ClaimedDiscountPageState();
}

class _ClaimedDiscountPageState extends State<SuccessfullyClaimed> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 900,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Text(
              "Successfully Claimed!",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 15.h,
            ),
            Container(
              height: 1.h,
              width: 100.w,
              color: Color(0xffD0D0D0),
            ),
            SizedBox(
              height: 15.h,
            ),
            Image.asset(""),
            SizedBox(
              height: 18.h,
            ),
            Text(
              "You have successfully claimed the\ndiscount through DD Travel. To enjoy the\ndiscount, call Seagull Hotel and provide\nyour discount id. You will get this amazing\ndiscount!",
              style: TextStyle(
                  color: Color(0xff9C9C9C),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400),
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
                        backgroundColor: Colors.grey.shade200),
                    onPressed: () {},
                    child: Row(
                      children: [
                        Text(
                          "My Discounts",
                          style: TextStyle(
                              color: Color(0xffD0D0D0),
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400),
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
          ],
        ),
      ),
    );
  }
}
