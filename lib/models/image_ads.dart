class ImageAds {
  final int id;
  String image_url;
  final String webpage_url;

  ImageAds({required this.id, required this.image_url, required this.webpage_url});

  factory ImageAds.fromJson(Map<String, dynamic> json) => ImageAds(
    id: json['image_id'],
    image_url: json['image_url'],
    webpage_url: json['webpage_url'],
  );

  Map<String,dynamic> toJson() => {
    'image_id' : id,
    'image_url' : image_url,
    'webpage_url' : webpage_url,
  };
}
