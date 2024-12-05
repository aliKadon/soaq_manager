class CountryList {
  final int country_id;
  final String country_url;
  final String country_name;

  CountryList({
    required this.country_id,
    required this.country_url,
    required this.country_name,
  });

  factory CountryList.fromJson(Map<String, dynamic> json) => CountryList(
    country_id: json['country_id'],
    country_name: json['country_name'],
    country_url: json['country_url'],
  );
}
