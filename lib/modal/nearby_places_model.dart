import 'dart:convert';

List<NearbyToiletsModel> nearbyToiletsModelFromJson(dynamic str) => List<NearbyToiletsModel>.from(str.map((x) => NearbyToiletsModel.fromJson(x)));

String nearbyToiletsModelToJson(List<NearbyToiletsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NearbyToiletsModel {
    final int id;
    final String latitude;
    final String longitude;
    final double distance;

    NearbyToiletsModel({
        required this.id,
        required this.latitude,
        required this.longitude,
        required this.distance,
    });

    factory NearbyToiletsModel.fromJson(Map<String, dynamic> json) => NearbyToiletsModel(
        id: json["id"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        distance: json["distance"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "latitude": latitude,
        "longitude": longitude,
        "distance": distance,
    };
}
