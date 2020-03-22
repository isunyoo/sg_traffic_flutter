import 'dart:convert';
import 'package:http/http.dart' as http;

class NetworkHelper {
  NetworkHelper({this.url});

  final String url;

  Future<dynamic> getData() async {
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      String data = response.body.toString();
      //print(data);
      //print(jsonDecode(data).toString());
      //print(data.length);

      return jsonDecode(data);
    } else {
      print(response.statusCode);
      throw Exception('Failed to load CameraData');
    }
  }
}
