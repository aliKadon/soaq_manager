import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:soaqman/models/country_list.dart';
import 'package:soaqman/models/jobs.dart';
import 'package:soaqman/models/new_jobs.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/image_ads.dart';
import '../models/image_type.dart';
import '../models/new_ADs.dart';

class HttpProviders with ChangeNotifier {
  List<Jobs> _allJobs = [];
  List<ImageAds> _allADS = [];
  List<Jobs> _jobByID = [];
  List<Jobs> _jobByType = [];
  List<Jobs> _jobByCountry = [];
  List<Jobs> _jobByCity = [];
  List<ImageType> _imageType = [];
  List<Jobs> _jobByNationality = [];
  List<CountryList> _countryList = [];

  List<Jobs> get getJobs {
    return [..._allJobs];
  }

  List<ImageAds> get getADS {
    return [..._allADS];
  }

  List<Jobs> get getJobByID {
    return [..._jobByID];
  }

  List<Jobs> get getJobByType {
    return [..._jobByType];
  }

  List<Jobs> get getJobByCountry {
    return [..._jobByCountry];
  }

  List<Jobs> get getJobByCity {
    return [..._jobByCity];
  }

  List<ImageType> get getImageType {
    return [..._imageType];
  }

  List<Jobs> get getJobByNationality {
    return [..._jobByNationality];
  }

  List<CountryList> get getCountryList {
    return [..._countryList];
  }

  //get all countries image and name
  Future<void> getAllCountriesImageAndName() async {
    
    final url =
        Uri.parse('http://soaq.a2hosted.com/v1/addimagecountry');
    final response = await http.get(url).catchError((error) {
      throw error;
    });
    List typeList = json.decode(response.body)['data'];
    List<CountryList> imageType = [];
    for (int i = 0; i < typeList.length; i++) {
      imageType.add(CountryList(
          country_id: typeList[i]['country_id'],
          country_url: typeList[i]['country_url'],
          country_name: typeList[i]['country_name']));
    }
    _countryList = imageType;
    notifyListeners();
  }

  //get all types with images
  Future<void> getAllImageType() async {
    final url =
        Uri.parse('http://soaq.a2hosted.com/v1/addimagetype');
    final response = await http.get(url).catchError((error) {
      throw error;
    });
    List typeList = json.decode(response.body)['data'];
    List<ImageType> imageType = [];
    for (int i = 0; i < typeList.length; i++) {
      imageType.add(ImageType(
          id: typeList[i]['id'],
          url: typeList[i]['url'],
          name: typeList[i]['name'],
          description: typeList[i]['description'],
      namear: typeList[i]['namear']));
    }
    _imageType = imageType;
    notifyListeners();
  }

  // post new ADs
  Future<void> postNewADs(NewADs newADs) {
    final url =
        Uri.parse('http://soaq.a2hosted.com/v1/addadvertising');
    return http.post(url, body: {
      'image_url': newADs.image_url,
      'webpage_url': newADs.webpage_url,
    }).catchError((error) {
      throw error;
    });
  }

  // add new jobs
  Future<void> postNewJob(NewJobs newJobs) {
    final url = Uri.parse('http://soaq.a2hosted.com/v1/addjobs');
    return http.post(url, body: {
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
      "job_type_ar" : newJobs.job_name_ar,
      "date_of_jobs" :DateTime.now().toString(),
    }).catchError((error) {
      throw error;
    });
  }

  //get all jobs from database
  Future<void> getAllJobs() async {
    final url =
        Uri.parse('http://soaq.a2hosted.com/v1/getalljobs/');
    final response = await http.get(url).catchError((error) {
      throw error;
    });
    List jobsList = json.decode(response.body)['data'];
    List<Jobs> jobs = [];
    for (int i = 0; i < jobsList.length; i++) {
      jobs.insert(
          0,
          Jobs(
            id: jobsList[i]['job_id'],
            job_city: jobsList[i]['job_city'],
            job_country: jobsList[i]['job_country'],
            job_description: jobsList[i]['job_description'],
            job_duration_inday: jobsList[i]['job_duration_inday'],
            job_email: jobsList[i]['job_email'],
            job_experience: jobsList[i]['job_experience'],
            job_language: jobsList[i]['job_language'],
            job_name: jobsList[i]['job_name'],
            job_nationality: jobsList[i]['job_nationality'],
            job_phonenumber: jobsList[i]['job_phonenumber'],
            job_salary: jobsList[i]['job_salary'],
            job_type: jobsList[i]['job_type'],
            country_image: jobsList[i]['country_image'],
              updateJob: jobsList[i]['update'],
            update_url: jobsList[i]['update_url'],
            job_type_ar: jobsList[i]['job_type_ar']
          ));
    }
    _allJobs = jobs;

    notifyListeners();
  }

  // delete job
  Future<void> deleteJob(String id) {
    final url =
        Uri.parse('http://soaq.a2hosted.com//v1/getalljobs/$id');
    return http.delete(url).catchError((error) {
      throw error;
    });
  }

  // delete ADs
  Future<void> deleteADs(String id) {
    final url = Uri.parse(
        'http://soaq.a2hosted.com/v1/getadvertising/$id');
    return http.delete(url).catchError((error) {
      throw error;
    });
  }

  // get job by id from database
  Future<void> getJobById(int id) async {
    final url =
        Uri.parse('http://soaq.a2hosted.com/v1/getjobsbyid/$id');
    final response = await http.get(url).catchError((error) {
      throw error;
    });
    List list = json.decode(response.body)['data'];
    final List<Jobs> jobList = [];
    for (int i = 0; i < list.length; i++) {
      jobList.add(Jobs(
        id: id,
        job_city: list[i]['job_city'],
        job_country: list[i]['job_country'],
        job_description: list[i]['job_description'],
        job_duration_inday: list[i]['job_duration_inday'],
        job_email: list[i]['job_email'],
        job_experience: list[i]['job_experience'],
        job_language: list[i]['job_language'],
        job_name: list[i]['job_name'],
        job_nationality: list[i]['job_nationality'],
        job_phonenumber: list[i]['job_phonenumber'],
        job_salary: list[i]['job_salary'],
        job_type: list[i]['job_type'],
        country_image: list[i]['country_image'],
        updateJob: list[i]['update'],
        update_url: list[i]['update_url'],
      ));
    }
    _jobByID = jobList;
    notifyListeners();
  }

  // get job by nationality from database
  Future<void> getJobByNationalityFun(String nationality) async {
    try {
      final url = Uri.parse(
          'http://soaq.a2hosted.com/v1/getJobNationality/$nationality');
      final response = await http.get(url).catchError((error) {
        throw error;
      });
      List list = json.decode(response.body)['data'];

      final List<Jobs> jobList = [];
      for (int i = 0; i < list.length; i++) {
        jobList.add(Jobs(
          id: list[i]['job_id'],
          job_city: list[i]['job_city'],
          job_country: list[i]['job_country'],
          job_description: list[i]['job_description'],
          job_duration_inday: list[i]['job_duration_inday'],
          job_email: list[i]['job_email'],
          job_experience: list[i]['job_experience'],
          job_language: list[i]['job_language'],
          job_name: list[i]['job_name'],
          job_nationality: list[i]['job_nationality'],
          job_phonenumber: list[i]['job_phonenumber'],
          job_salary: list[i]['job_salary'],
          job_type: list[i]['job_type'],
          country_image: list[i]['country_image'],
          updateJob: list[i]['update'],
          update_url: list[i]['update_url'],
        ));
      }
      _jobByNationality = jobList;
      print(_jobByNationality);
      notifyListeners();
    } catch (err) {
      _jobByNationality = [];
      notifyListeners();
      throw err;
    }
  }

  // get job by country name from database
  Future<void> getJobByCountryFun(String country) async {
    final url = Uri.parse(
        'http://soaq.a2hosted.com/v1/getjobsbycountry/$country');
    final response = await http.get(url);
    List list = json.decode(response.body)['data'];
    final List<Jobs> jobList = [];
    for (int i = 0; i < list.length; i++) {
      jobList.add(Jobs(
        id: list[i]['job_id'],
        job_city: list[i]['job_city'],
        job_country: list[i]['job_country'],
        job_description: list[i]['job_description'],
        job_duration_inday: list[i]['job_duration_inday'],
        job_email: list[i]['job_email'],
        job_experience: list[i]['job_experience'],
        job_language: list[i]['job_language'],
        job_name: list[i]['job_name'],
        job_nationality: list[i]['job_nationality'],
        job_phonenumber: list[i]['job_phonenumber'],
        job_salary: list[i]['job_salary'],
        job_type: list[i]['job_type'],
        country_image: list[i]['country_image'],
        updateJob: list[i]['update'],
        update_url: list[i]['update_url'],
      ));
    }
    _jobByCountry = jobList;
    notifyListeners();
  }

  // get job by city name from database
  Future<void> getJobByCityFun(String city) async {
    final url = Uri.parse(
        'http://soaq.a2hosted.com/v1/getjobsbycity/$city');
    final response = await http.get(url);
    List list = json.decode(response.body)['data'];
    final List<Jobs> jobList = [];
    for (int i = 0; i < list.length; i++) {
      jobList.add(Jobs(
        id: list[i]['job_id'],
        job_city: list[i]['job_city'],
        job_country: list[i]['job_country'],
        job_description: list[i]['job_description'],
        job_duration_inday: list[i]['job_duration_inday'],
        job_email: list[i]['job_email'],
        job_experience: list[i]['job_experience'],
        job_language: list[i]['job_language'],
        job_name: list[i]['job_name'],
        job_nationality: list[i]['job_nationality'],
        job_phonenumber: list[i]['job_phonenumber'],
        job_salary: list[i]['job_salary'],
        job_type: list[i]['job_type'],
        country_image: list[i]['country_image'],
        updateJob: list[i]['update'],
        update_url: list[i]['update_url'],
      ));
    }
    _jobByCity = jobList;
    notifyListeners();
  }

  // get job by type
  Future<void> getJobByTypeFun(String type) async {
    try {
      final url = Uri.parse(
          'http://soaq.a2hosted.com/v1/getalljobs/$type');
      final response = await http.get(url);
      List list = json.decode(response.body)['data'];

      final List<Jobs> jobList = [];
      for (int i = 0; i < list.length; i++) {
        jobList.add(Jobs(
          id: list[i]['job_id'],
          job_city: list[i]['job_city'],
          job_country: list[i]['job_country'],
          job_description: list[i]['job_description'],
          job_duration_inday: list[i]['job_duration_inday'],
          job_email: list[i]['job_email'],
          job_experience: list[i]['job_experience'],
          job_language: list[i]['job_language'],
          job_name: list[i]['job_name'],
          job_nationality: list[i]['job_nationality'],
          job_phonenumber: list[i]['job_phonenumber'],
          job_salary: list[i]['job_salary'],
          job_type: list[i]['job_type'],
          country_image: list[i]['country_image'],
          updateJob: list[i]['update'],
          update_url: list[i]['update_url'],
        ));
      }
      _jobByType = jobList;
      print(_jobByType);
      notifyListeners();
    } catch (err) {
      _jobByType = [];
      notifyListeners();
      throw err;
    }
  }

  // list of types from Countries
  List<String> listOfTypesFromCountries(List<Jobs> listOfJobs, String country) {
    List<String> types = [];

    for (int i = 0; i < listOfJobs.length; i++) {
      if (listOfJobs[i].job_country == country) {
        types.add(listOfJobs[i].job_type);
      }
    }
    return types.toSet().toList();
  }

  //list of jobs by type and countries
  List<Jobs> listOfTypeAndCountries(
      List<Jobs> listOfJobs, String type, String country) {
    List<Jobs> jobs = [];

    for (int i = 0; i < listOfJobs.length; i++) {
      if (listOfJobs[i].job_country == country &&
          listOfJobs[i].job_type == type) {
        jobs.add(listOfJobs[i]);
      }
    }
    return jobs;
  }

  // list the types of jobs
  List<String> listOfType(List<Jobs> listOfJobs) {
    List<String> types = [];

    for (int i = 0; i < listOfJobs.length; i++) {
      types.insert(0, listOfJobs[i].job_type);
    }
    //remove the same item in the list
    var list = types.toSet().toList();
    return list;
  }

  //list of cities
  List<String> listOfCity(List<Jobs> listOfJobs, String country) {
    List<String> cities = [];

    for (int i = 0; i < listOfJobs.length; i++) {
      if (listOfJobs[i].job_country == country) {
        cities.insert(0, listOfJobs[i].job_city);
      }
    }

    var list = cities.toSet().toList();
    return list;
  }

  List<String> listOfCountryImage(List<Jobs> listOfJobs) {
    List<String> images = [];

    for (int i = 0; i < listOfJobs.length; i++) {
      images.insert(0, listOfJobs[i].country_image);
    }
    var list = images.toSet().toList();
    List<String> list2 = [];
    for (String s in list) {
      if (s[0] == 'h') {
        list2.add(s);
      }
    }
    return list2;
  }

  // list the countries of jobs
  List<String> listOfCountry(List<Jobs> listOfJobs) {
    List<String> countries = [];

    for (int i = 0; i < listOfJobs.length; i++) {
      countries.insert(0, listOfJobs[i].job_country);
    }
    //remove the same item in the list
    var list = countries.toSet().toList();
    return list;
  }

  getWebpage(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'an error occurred';
    }
  }

  // get all the image of advertising
  Future<void> getAllAdvertising() async {
    final url =
        Uri.parse("http://soaq.a2hosted.com/v1/getadvertising/");
    final response = await http.get(url).catchError((error) {
      throw error;
    });
    List imageList = json.decode(response.body)['data'];
    List<ImageAds> ads = [];
    for (int i = 0; i < imageList.length; i++) {
      ads.add(
        ImageAds(
          id: imageList[i]['image_id'],
          webpage_url: imageList[i]['image_url'],
          image_url: imageList[i]['webpage_url'],
        ),
      );
    }
    _allADS = ads;

    notifyListeners();
  }
}
