class NewJobs {
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
  String update = '';
  String update_url = '';
  String? job_name_ar;
  String? date_of_jobs;

  NewJobs({
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
    required this.update,
    required this.update_url,
    this.job_name_ar,
    this.date_of_jobs,
  });
}
