import 'package:sg_traffic_flutter/networking.dart';

//https://api.data.gov.sg/v1/transport/traffic-images?date_time=2020-03-08T17:30:00
const trafficImagesURL = 'https://api.data.gov.sg/v1/transport/traffic-images';

class TrafficModel {
  Future<dynamic> getTrafficInfo(String dateTime) async {
    NetworkHelper networkHelper =
        NetworkHelper(url: '$trafficImagesURL?date_time=$dateTime');

    var trafficData = await networkHelper.getData();

    return trafficData;
  }
}
