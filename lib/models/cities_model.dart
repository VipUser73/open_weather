class Cities {
  final String city;
  final double lon;
  final double lat;

  Cities({
    required this.city,
    required this.lon,
    required this.lat,
  });

  Map<String, dynamic> toJson() => {
        "name": city,
        "coord": {"lat": lat, "lon": lon},
      };

  factory Cities.fromJson(Map<String, dynamic> json) {
    return Cities(
      city: json['name'] as String,
      lon: json['coord']['lon'] as double,
      lat: json['coord']['lat'] as double,
    );
  }
  factory Cities.fromDB(Map<String, dynamic> data) => Cities(
        city: data["city"] ?? '',
        lon: data["lon"] ?? 0.0,
        lat: data["lat"] ?? 0.0,
      );
}
