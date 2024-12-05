import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:soaqman/models/country_list.dart';
import 'package:soaqman/models/new_jobs.dart';

import '../../../models/api_response.dart';
import '../../../models/image_ads.dart';
import '../../../models/image_type.dart';
import '../../../models/jobs.dart';
import '../api_helper.dart';

class ApiController with ApiHelper {
  Future<List<Jobs>> getJobs({int? pageSize, int? pageNumber}) async {
    var url = Uri.parse(
        'http://soaq.a2hosted.com/v1/getalljobs?page_size=$pageSize&page_number=$pageNumber');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      return List<Jobs>.from(jsonData['data'].map((x) => Jobs.fromJson(x)));
    }
    return [];
  }

  Future<List<Jobs>> getJobsByCity({required String city}) async {
    var url = Uri.parse('http://soaq.a2hosted.com/v1/getjobsbycity/$city');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      return List<Jobs>.from(jsonData['data'].map((x) => Jobs.fromJson(x)));
    }
    return [];
  }

  Future<List<CountryList>> getCountriesData() async {
    var url = Uri.parse("http://soaq.a2hosted.com/v1/addimagecountry");
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      return List<CountryList>.from(
          jsonData["data"].map((x) => CountryList.fromJson(x)));
    }
    return [];
  }

  Future<List<ImageType>> getJobsType() async {
    var url = Uri.parse('http://soaq.a2hosted.com/v1/addimagetype');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      return List<ImageType>.from(
          jsonData['data'].map((x) => ImageType.fromJson(x)));
    }
    return [];
  }

  Future<List<Jobs>> getJobsById({required int id}) async {
    var url = Uri.parse('http://soaq.a2hosted.com/v1/getjobsbyid/$id');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      return List<Jobs>.from(jsonData['data'].map((x) => Jobs.fromJson(x)));
    }
    return [];
  }

  Future<List<Jobs>> getJobsByCountry({required String country}) async {
    var url =
        Uri.parse('http://soaq.a2hosted.com/v1/getjobsbycountry/$country');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      return List<Jobs>.from(jsonData['data'].map((x) => Jobs.fromJson(x)));
    }
    return [];
  }

  Future<List<Jobs>> getJobsByType({required String type}) async {
    var url = Uri.parse('http://soaq.a2hosted.com/v1/getalljobs/$type');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      return List<Jobs>.from(jsonData['data'].map((x) => Jobs.fromJson(x)));
    }
    return [];
  }

  Future<List<Jobs>> getJobsByNationality({required String nationality}) async {
    var url =
        Uri.parse('http://soaq.a2hosted.com/v1/getJobNationality/$nationality');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      return List<Jobs>.from(jsonData['data'].map((x) => Jobs.fromJson(x)));
    }
    return [];
  }

  Future<List<ImageAds>> getAdvertising() async {
    var url = Uri.parse('http://soaq.a2hosted.com/v1/getadvertising/');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      return List<ImageAds>.from(
          jsonData['data'].map((x) => ImageAds.fromJson(x)));
    }
    return [];
  }

  Future<ApiResponse> deleteJob({required int id}) async {
    var url = Uri.parse('http://soaq.a2hosted.com//v1/getalljobs/$id');
    var response = await http.delete(url);

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      return ApiResponse(
          message: jsonData['status'], status: response.statusCode);
    }
    return failedResponse;
  }

  Future<ApiResponse> updateJob(
      {required int id, required NewJobs newJobs}) async {
    var url = Uri.parse('http://soaq.a2hosted.com/v1/getalljobs/$id');
    var response = await http.put(url,
        headers: headers,
        body: jsonEncode({
          "job_name": newJobs.job_name,
          "job_description": newJobs.job_description,
          "job_type": newJobs.job_type,
          "job_country": newJobs.job_country,
          "job_city": newJobs.job_city,
          "job_salary": newJobs.job_salary,
          "job_nationality": newJobs.job_nationality,
          "job_experience": newJobs.job_experience,
          "job_language": newJobs.job_language,
          "job_duration_inday": newJobs.job_duration_inday,
          "job_phonenumber": newJobs.job_phonenumber,
          "job_email": newJobs.job_email,
          "country_image": newJobs.country_image,
          "update": newJobs.update,
          "update_url": newJobs.update_url,
          "job_type_ar": newJobs.job_name_ar,
          "date_of_jobs": DateTime.now().toString(),
        }));

    print('=================== update jobs');
    print(newJobs.job_name_ar);
    print(response.body);

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      return ApiResponse(
          message: jsonData['status'], status: response.statusCode);
    }
    return failedResponse;
  }

  Future<ApiResponse> addNewJob(
      {required BuildContext context, required NewJobs newJobs}) async {
    var url = Uri.parse('http://soaq.a2hosted.com/v1/addjobs');
    var response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(
        {
          "job_name": newJobs.job_name,
          "job_description": newJobs.job_description,
          "job_type": newJobs.job_type,
          "job_country": newJobs.job_country,
          "job_city": newJobs.job_city,
          "job_salary": newJobs.job_salary,
          "job_nationality": newJobs.job_nationality,
          "job_experience": newJobs.job_experience,
          "job_language": newJobs.job_language,
          "job_duration_inday": newJobs.job_duration_inday,
          "job_phonenumber": newJobs.job_phonenumber,
          "job_email": newJobs.job_email,
          "country_image": newJobs.country_image,
          "update": newJobs.update,
          "update_url": newJobs.update_url,
          "job_type_ar": newJobs.job_name_ar,
          "date_of_jobs": DateTime.now().toString(),
        },
      ),
    );
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      if (jsonData["status"] == "success") {
        return ApiResponse(message: jsonData["status"], status: 200);
      }
    }
    return failedResponse;
  }
}
