import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

String baseUrl = "https://ddtravels.safafirm.com/api/";

String getFormattedDate(DateTime dateTime, String format) {
  return DateFormat(format).format(dateTime);
}

mytextstyle(Color clr, double size, FontWeight fw) {
  return TextStyle(color: clr, fontSize: size, fontWeight: fw);
}

var spinkit = SpinKitFadingCircle(
  color: Colors.greenAccent,
);
showInToast(String text) {
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black54,
      textColor: Colors.white,
      fontSize: 16.0);
}
