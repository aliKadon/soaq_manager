class ImageType {
  int id;
  String url = '';
  String name = '';
  String description = '';
  String? namear;

  ImageType({
    required this.id,
    required this.url,
    required this.name,
    required this.description,
    this.namear,
  });

  factory ImageType.fromJson(Map<String, dynamic> json) => ImageType(
    namear: json['namear'],
    id: json['id'],
    name: json['name'],
    description: json['description'],
    url: json['url'],
  );

  Map<String, dynamic> toJson() => {
    'namear' : namear,
    'id' : id,
    'name' : name,
    'description' : description,
    'url' : url,
  };
}
