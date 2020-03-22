class CameraData {
  List<Items> items;
  ApiInfo apiInfo;

  CameraData({this.items, this.apiInfo});

  CameraData.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = new List<Items>();
      json['items'].forEach((v) {
        items.add(new Items.fromJson(v));
      });
    }
    apiInfo = json['api_info'] != null
        ? new ApiInfo.fromJson(json['api_info'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.items != null) {
      data['items'] = this.items.map((v) => v.toJson()).toList();
    }
    if (this.apiInfo != null) {
      data['api_info'] = this.apiInfo.toJson();
    }
    return data;
  }
}

class Items {
  String timestamp;
  List<Cameras> cameras;

  Items({this.timestamp, this.cameras});

  Items.fromJson(Map<String, dynamic> json) {
    timestamp = json['timestamp'];
    if (json['cameras'] != null) {
      cameras = new List<Cameras>();
      json['cameras'].forEach((v) {
        cameras.add(new Cameras.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['timestamp'] = this.timestamp;
    if (this.cameras != null) {
      data['cameras'] = this.cameras.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Cameras {
  String timestamp;
  String image;
  Location location;
  String cameraId;
  ImageMetadata imageMetadata;

  Cameras(
      {this.timestamp,
      this.image,
      this.location,
      this.cameraId,
      this.imageMetadata});

  Cameras.fromJson(Map<String, dynamic> json) {
    timestamp = json['timestamp'];
    image = json['image'];
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    cameraId = json['camera_id'];
    imageMetadata = json['image_metadata'] != null
        ? new ImageMetadata.fromJson(json['image_metadata'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['timestamp'] = this.timestamp;
    data['image'] = this.image;
    if (this.location != null) {
      data['location'] = this.location.toJson();
    }
    data['camera_id'] = this.cameraId;
    if (this.imageMetadata != null) {
      data['image_metadata'] = this.imageMetadata.toJson();
    }
    return data;
  }
}

class Location {
  double latitude;
  double longitude;

  Location({this.latitude, this.longitude});

  Location.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}

class ImageMetadata {
  int height;
  int width;
  String md5;

  ImageMetadata({this.height, this.width, this.md5});

  ImageMetadata.fromJson(Map<String, dynamic> json) {
    height = json['height'];
    width = json['width'];
    md5 = json['md5'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['height'] = this.height;
    data['width'] = this.width;
    data['md5'] = this.md5;
    return data;
  }
}

class ApiInfo {
  String status;

  ApiInfo({this.status});

  ApiInfo.fromJson(Map<String, dynamic> json) {
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    return data;
  }
}
