import 'package:get/get.dart';

class Jobs extends GetxController {
  final int id;
  String job_name = '';
  String job_description = '';
  String job_type = '';
  String job_country = '';
  String job_city = '';
  String job_salary = '';
  String job_nationality = '';
  String job_experience = '';
  String job_language = '';
  String job_duration_inday = '';
  String job_phonenumber = '';
  String job_email = '';
  String country_image = '';
  String update_url = '';
  String? job_type_ar;
  String? date_of_jobs;
  String? updateJob = '';



  Jobs({
    required this.id,
    required this.job_city,
    required this.job_country,
    required this.job_description,
    required this.job_duration_inday,
    required this.job_email,
    required this.job_experience,
    required this.job_language,
    required this.job_name,
    required this.job_nationality,
    required this.job_phonenumber,
    required this.job_salary,
    required this.job_type,
    required this.country_image,
    required this.update_url,
    this.job_type_ar,
    this.date_of_jobs,
    this.updateJob,
  });

  factory Jobs.fromJson(Map<String,dynamic> json) => Jobs(id: json['job_id'],
    date_of_jobs: json['date_of_jobs'],
    job_type_ar: json['job_type_ar'],
    country_image: json['country_image'],
    job_city: json['job_city'],
    job_country: json['job_country'],
    job_description: json['job_description'],
    job_duration_inday: json['job_duration_inday'],
    job_email: json['job_email'],
    job_experience: json['job_experience'],
    job_language: json['job_language'],
    job_name: json['job_name'],
    job_nationality: json['job_nationality'],
    job_phonenumber: json['job_phonenumber'],
    job_salary: json['job_salary'],
    job_type: json['job_type'],
    updateJob: json['update'],
    update_url: json['update_url'],
  );

  Map<String,dynamic> toJson() => {
    'id' : id,
    'date_of_jobs' : date_of_jobs,
    'job_type_ar' : job_type_ar,
    'country_image' : country_image,
    'job_city' : job_city,
    'job_country' :job_country,
    'job_description' :job_description,
    'job_duration_inday' :job_duration_inday,
    'job_email' :job_email,
    'job_experience' :job_experience,
    'job_language' : job_language,
    'job_name' :  job_name,
    'job_nationality' : job_nationality,
    'job_phonenumber' :job_phonenumber,
    'job_salary' : job_salary,
    'job_type' : job_type,
    'update' : updateJob,
    'update_url' : update_url,
  };
}
