import 'package:flutter/cupertino.dart';
import 'package:travel_app/CustomHttp/customhttp.dart';
import 'package:travel_app/models/latest_campaign.dart';

class LatestCampaignProvider with ChangeNotifier {
  LatestCampaignModel? latestCampaignModel;
  Future<LatestCampaignModel> latestCampaign() async {
    latestCampaignModel = await CustomHttpRequest.latestCampaign();

    return latestCampaignModel!;
  }
}
