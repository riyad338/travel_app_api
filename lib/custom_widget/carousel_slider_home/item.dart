import 'package:flutter/material.dart';
import 'package:travel_app/models/latest_campaign.dart';

class CompanyItem extends StatefulWidget {
  @override
  Campaign campaign;
  CompanyItem(this.campaign);
  State<CompanyItem> createState() => _CompanyItemState();
}

class _CompanyItemState extends State<CompanyItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      width: 300,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Image.network("${widget.campaign.photo}"),
    );
  }
}
