import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/custom_widget/contact_for_booking.dart';
import 'package:travel_app/custom_widget/successfully_claimed_discount.dart';

class ClaimedDiscountPage extends StatefulWidget {
  const ClaimedDiscountPage({Key? key}) : super(key: key);

  @override
  State<ClaimedDiscountPage> createState() => _ClaimedDiscountPageState();
}

class _ClaimedDiscountPageState extends State<ClaimedDiscountPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 700,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Grab The offer",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 50.w),
            Row(
              children: [
                Text(
                  "Amount",
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff9C9C9C)),
                ),
                SizedBox(width: 50.w),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        padding: EdgeInsets.symmetric(vertical: 8),
                        backgroundColor: Color(0xffD0D0D0)),
                    onPressed: () {},
                    child: Text(
                      "+",
                      style: TextStyle(fontSize: 16.sp),
                    )),
                SizedBox(width: 50.w),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        padding: EdgeInsets.symmetric(vertical: 8),
                        backgroundColor: Color(0xffD0D0D0)),
                    onPressed: () {},
                    child: Text(
                      "-",
                      style: TextStyle(fontSize: 16.sp),
                    )),
              ],
            ),
            SizedBox(height: 50.w),
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
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (builder) {
                            return ContactForBooking();
                          });
                    },
                    child: Text(
                      "Contact For booking",
                      style: TextStyle(
                          color: Color(0xff08BA64),
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500),
                    )),
                SizedBox(width: 50.w),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        padding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                        backgroundColor: Color(0xff08BA64)),
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (builder) {
                            return SuccessfullyClaimed();
                          });
                    },
                    child: Text(
                      "Claim Discount",
                      style: TextStyle(
                          fontSize: 16.sp, fontWeight: FontWeight.w500),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
