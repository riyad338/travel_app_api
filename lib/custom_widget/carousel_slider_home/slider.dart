import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/custom_widget/carousel_slider_home/item.dart';
import 'package:travel_app/providers/latest_camp.dart';

class CompanyList extends StatefulWidget {
  const CompanyList({super.key});

  @override
  State<CompanyList> createState() => _CompanyListState();
}

class _CompanyListState extends State<CompanyList> {
  LatestCampaignProvider? latestCampaignProvider;

  @override
  void didChangeDependencies() {
    latestCampaignProvider = Provider.of<LatestCampaignProvider>(context);
    latestCampaignProvider!.latestCampaign();
    latestCampaignProvider!.latestCampaignModel!.campaign;
    setState(() {});
    ;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280,
      width: 500,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => CompanyItem(
              latestCampaignProvider!.latestCampaignModel!.campaign![index]),
          separatorBuilder: (_, index) => SizedBox(
                width: 10,
              ),
          itemCount:
              latestCampaignProvider!.latestCampaignModel!.campaign!.length),
    );
  }
}
