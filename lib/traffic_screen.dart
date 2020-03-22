import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:sg_traffic_flutter/traffic.dart';
import 'camera_data.dart';
import 'package:intl/intl.dart';
import 'dart:convert';

class TrafficScreen extends StatefulWidget {
  @override
  _TrafficScreenState createState() => _TrafficScreenState();
}

class _TrafficScreenState extends State<TrafficScreen> {
  String _currentTiming = '2020-01-01T00:00:00';
  final List<String> _cameraImage = <String>[];
  final List<double> _latitude = <double>[];
  final List<double> _longitude = <double>[];
  final List<String> _cameraID = <String>[];
  final List<int> _imgHeight = <int>[];
  final List<int> _imgWidth = <int>[];

  @override
  void initState() {
    super.initState();
    _currentTime();
  }

  String _currentTime() {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedTime = DateFormat('HH:mm:ss').format(now);
    String formattedDate = formatter.format(now);
    _currentTiming = formattedDate + 'T' + formattedTime;
    //print(_currentTiming);
    return _currentTiming;
  }

  void _cameraInfoListRest() {
    _cameraImage.clear();
    _latitude.clear();
    _longitude.clear();
    _imgHeight.clear();
    _imgWidth.clear();
  }

  Future<dynamic> _getTrafficData() async {
    var _trafficData = await TrafficModel().getTrafficInfo(_currentTime());
//    print(_trafficData);
//    _currentTiming = _trafficData['items'][0]['timestamp'];
//    print('TimeStamp: $_currentTiming');
//    _status = _trafficData['api_info']['status'];
//    print('api_info: $_status');

    String _cameraImages = jsonEncode(_trafficData);
    CameraData cameraData = CameraData.fromJson(json.decode(_cameraImages));

    return cameraData;
  }

  void updateUI(dynamic cameraData) {
    _cameraInfoListRest();
    for (int i = 0; i < cameraData.items.elementAt(0).cameras.length; i++) {
//      print('CameraID: ' +
//          cameraData.items.elementAt(0).cameras.elementAt(i).cameraId);
//      print('CameraImage: ' +
//          cameraData.items.elementAt(0).cameras.elementAt(i).image);
//      print('CameraLocation: \n');
//      print('Latitude: ' +
//          cameraData.items
//              .elementAt(0)
//              .cameras
//              .elementAt(i)
//              .location
//              .latitude
//              .toString());
//      print('Longitude: ' +
//          cameraData.items
//              .elementAt(0)
//              .cameras
//              .elementAt(i)
//              .location
//              .longitude
//              .toString());
//      print('ImgHeight: ' +
//          cameraData.items
//              .elementAt(0)
//              .cameras
//              .elementAt(i)
//              .imageMetadata
//              .height
//              .toString());
//      print('ImgWidth: ' +
//          cameraData.items
//              .elementAt(0)
//              .cameras
//              .elementAt(i)
//              .imageMetadata
//              .width
//              .toString());

      setState(() {
        _cameraImage
            .add(cameraData.items.elementAt(0).cameras.elementAt(i).image);
        _cameraID
            .add(cameraData.items.elementAt(0).cameras.elementAt(i).cameraId);
        _latitude.add(cameraData.items
            .elementAt(0)
            .cameras
            .elementAt(i)
            .location
            .latitude);
        _longitude.add(cameraData.items
            .elementAt(0)
            .cameras
            .elementAt(i)
            .location
            .longitude);
        _imgHeight.add(cameraData.items
            .elementAt(0)
            .cameras
            .elementAt(i)
            .imageMetadata
            .height);
        _imgWidth.add(cameraData.items
            .elementAt(0)
            .cameras
            .elementAt(i)
            .imageMetadata
            .width);
      });
    }
  }

  Widget _getCard(String url, String id, double lat, double long, int count,
      int imgHeight, int imgWidth) {
    return Card(
        child: Container(
      height: 270,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'Time: $_currentTiming',
            //style: Theme.of(context).textTheme.display1,
          ),
          Text(
            '($count) Camera_ID: $id',
          ),
          Text(
            'Latitude: $lat , Longitude: $long',
          ),
          Container(
            height: 200,
            width: double.infinity,
            child: Image.network(
              '$url',
              fit: BoxFit.fill,
              height: imgHeight.toDouble(),
              width: imgWidth.toDouble(),
            ),
          )
        ],
      ),
    ));
  }

//  Widget _getImages() {
//    return ListView.builder(
//        padding: const EdgeInsets.all(0),
//        //physics: FixedExtentScrollPhysics(),
//        itemBuilder: (BuildContext _context, int _position) {
//          final int index = _position ~/ 2;
//          if (_position.isOdd) {
//            return Divider();
//          }
//
//          if (_cameraImage.length == 0) {
//            return Card(
//                child: Container(
//              height: 320,
//              child: Column(
//                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                  crossAxisAlignment: CrossAxisAlignment.stretch,
//                  children: <Widget>[
//                    Text(
//                      'No Image, Please press update button.',
//                    ),
//                    Image.asset(
//                      'images/no_photo.png',
//                      fit: BoxFit.cover,
//                    ),
//                  ]),
//            ));
//          } else if (index >= _cameraImage.length) {
//            //If you've reached the end of the list of cameraImages,
//            print('End of images num: $index, Position num: $_position');
//            return Card(
//                child: Container(
//              height: 420,
//              child: Column(
//                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                  crossAxisAlignment: CrossAxisAlignment.stretch,
//                  children: <Widget>[
//                    Text(
//                      'No More Images, Please press update button again.',
//                      //style: Theme.of(context).textTheme.display1,
//                    ),
//                    Image.asset(
//                      'images/no_more.jpg',
//                      fit: BoxFit.cover,
//                    ),
//                  ]),
//            ));
//          }
//
//          return _getCard(
//              _cameraImage[index],
//              _cameraID[index],
//              _latitude[index],
//              _longitude[index],
//              index + 1,
//              _imgHeight[index],
//              _imgWidth[index]);
//        });
//  }

  Widget _getImages() {
    if (_cameraImage.length == 0) {
      return Card(
          child: Container(
        height: 320,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'No Image, Please press update button.',
                //style: Theme.of(context).textTheme.display1,
              ),
              Image.asset(
                'images/no_photo.png',
                fit: BoxFit.cover,
              ),
            ]),
      ));
    } else if (_cameraImage.length < 86) {
      return ListView.builder(
          padding: const EdgeInsets.all(0),
          //physics: FixedExtentScrollPhysics(),
          itemBuilder: (BuildContext _context, int _position) {
            final int index = _position ~/ 2;
            if (_position.isOdd) {
              return Divider();
            }
            return _getCard(
                _cameraImage[index],
                _cameraID[index],
                _latitude[index],
                _longitude[index],
                index + 1,
                _imgHeight[index],
                _imgWidth[index]);
          });
    } else if (_cameraImage.length > 86) {
      //If you've reached the end of the list of cameraImages,
      return Card(
          child: Container(
        height: 420,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'No More Images, Please press update button again.',
                //style: Theme.of(context).textTheme.display1,
              ),
              Image.asset(
                'images/no_more.jpg',
                fit: BoxFit.cover,
              ),
            ]),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 SG Traffic Images 💀'),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              height: 30.0,
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: 2.0),
              color: Colors.orange,
              child: FloatingActionButton.extended(
                onPressed: () async {
                  var cameraData = await _getTrafficData();
                  updateUI(cameraData);
                },
                tooltip: 'Download Photos',
                icon: Icon(Icons.visibility),
                label: Text("UPDATE"),
              ),
            ),
            Expanded(
              child: _getImages(),
            ),
          ]),
    );
  }
}
