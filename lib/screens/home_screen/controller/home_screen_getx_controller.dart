import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soaqman/app/helper.dart';
import 'package:soaqman/models/api_response.dart';
import 'package:soaqman/models/country_list.dart';
import 'package:soaqman/models/new_jobs.dart';

import '../../../app/data/api_controller/api_controller.dart';
import '../../../models/image_ads.dart';
import '../../../models/image_type.dart';
import '../../../models/jobs.dart';
import '../../latest_job_screen.dart';

class HomeScreenGetxController extends GetxController with Helper {
  List<Jobs> listOfJobs = [];
  List<Jobs> jobsByCity = [];
  List<Jobs> jobsById = [];
  List<Jobs> jobsByType = [];
  List<Jobs> listOfJobsPaging = [];
  List<ImageAds> allAdvertising = [];
  List<Jobs> jobsByNationality = [];
  List<Jobs> jobsByCountry = [];
  List<ImageType> jobsType = [];
  List<Jobs> newlyAdded = [];
  List<CountryList> countryList = [];
  late ApiResponse apiResponse;
  late ApiResponse apiResponseAddNewJob;
  var isLoadingGetx = true;
  var isLoadingJobsById = true;
  final ApiController _apiController = ApiController();

  void getCountryList({required BuildContext context}) async {
    try {
      countryList = await _apiController.getCountriesData();
      update();
    }catch (e) {
      print(e);
    }
  }

  void getJobsPaging(
      {required BuildContext context, int? pageSize = 0, int? pageNumber = 0}) async {
    try {
      List<Jobs> jobs = [];
      List<Jobs> jobs1 = [];

      jobs =
      await _apiController.getJobs(pageNumber: pageNumber, pageSize: pageSize);
      jobs1.addAll(jobs);
      listOfJobsPaging.addAll(jobs1.reversed.toList());
      print("paging : ${listOfJobsPaging[0].job_country}");

      isLoadingGetx = false;
      update();
    } catch (e) {
      Get.showSnackbar(GetSnackBar(
        title: e.toString(),
        backgroundColor: Colors.red,
      ));
    }
  }

  void getJobs({required BuildContext context}) async {
    try {
      List<Jobs> jobs = [];
      List<Jobs> newJobs = [];
      var todayDate = (DateTime.now().toString()).substring(0, 10);
      jobs = await _apiController.getJobs();
      listOfJobs = jobs.reversed.toList();
      for (Jobs jobs in listOfJobs) {
        if (jobs.date_of_jobs != null) {
          if ((jobs.date_of_jobs!).substring(0, 10) == todayDate) {
            newJobs.add(jobs);
          }
        }
      }
      newlyAdded = newJobs.toSet().toList();
      print('===================newly added');
      print(newlyAdded);
      isLoadingGetx = false;
      update();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
        backgroundColor: Colors.red,
      ));
    }
  }

  void getJobsByCity(
      {required BuildContext context, required String city}) async {
    try {
      jobsByCity = await _apiController.getJobsByCity(city: city);
      update();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
        backgroundColor: Colors.red,
      ));
    }
  }

  void getJobsType({required BuildContext context}) async {
    // jobsType = await _apiController.getJobsType();
    // update();
    try {
      jobsType = await _apiController.getJobsType();
      update();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
        backgroundColor: Colors.red,
      ));
    }
  }

  void getJobsById({required BuildContext context, required int id}) async {
    try {
      jobsById = await _apiController.getJobsById(id: id);
      isLoadingJobsById = false;
      update();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
        backgroundColor: Colors.red,
      ));
    }
  }

  void getJobsByCountry(
      {required BuildContext context, required String country}) async {
    try {
      jobsByCountry = await _apiController.getJobsByCountry(country: country);
      update();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
        backgroundColor: Colors.red,
      ));
    }
  }

  void getJobsByType(
      {required BuildContext context, required String type}) async {
    try {
      List<Jobs> list = [];
      list = await _apiController.getJobsByType(type: type);
      jobsByType = list.reversed.toList();
      update();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
        backgroundColor: Colors.red,
      ));
    }
  }


  // list the countries of jobs
  List<String> listOfCountry(List<Jobs> listOfJobs) {
    List<String> countries = [];
    List<String> images = [];
    Map<String, dynamic> countriesWithImage = {};

    for (int i = 0; i < listOfJobs.length; i++) {
      countries.insert(0, listOfJobs[i].job_country);
      images.insert(0, listOfJobs[i].country_image);
    }
    //remove the same item in the list
    var list = countries.toSet().toList();
    var list1 = images.toSet().toList();
    List<Map> list2 = [];
    for (int i = 0; i < list.length; i++) {
      countriesWithImage.assign('name', list1[i]);
      list2.add(countriesWithImage);
    }
    print('======================================name of countries 1');
    print(countriesWithImage);
    print(list2);
    return list;
  }

  List<String> listOfCountryImage(List<Jobs> listOfJobs) {
    List<String> images = [];

    for (int i = 0; i < listOfJobs.length; i++) {
      images.insert(0, listOfJobs[i].country_image);
    }
    var list = images.toSet().toList();
    // list.removeAt(1);
    List<String> list2 = [];
    for (String s in list) {
      if (s[0] == 'h') {
        list2.add(s);
      }
    }
    return list2;
  }

  void getJobsByNationality(
      {required BuildContext context, required String nationality}) async {
    try {
      jobsByNationality =
          await _apiController.getJobsByNationality(nationality: nationality);
      update();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
        backgroundColor: Colors.red,
      ));
    }
  }

  void getAdvertising({required BuildContext context}) async {
    try {
      allAdvertising = await _apiController.getAdvertising();
      update();
    } catch (e) {
      Get.snackbar('Error', e.toString(), backgroundColor: Colors.red);
    }
  }

  void deleteJob({required BuildContext context, required int id}) async {
    showLoadingDialog(context: context, title: 'Loading...');
    try {
      apiResponse = await _apiController.deleteJob(id: id);
      Navigator.of(context).pop();
      Navigator.of(context).pop('sss');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(apiResponse.message),
        backgroundColor: Colors.green,
      ));
      update();
    } catch (e) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
        backgroundColor: Colors.red,
      ));
    }
  }

  void updateJobs(
      {required BuildContext context,
      required int id,
      required NewJobs newJobs}) async {
    apiResponse = await _apiController.updateJob(id: id, newJobs: newJobs);
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => LatestJobScreen()));
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(apiResponse.message),
      backgroundColor: Colors.green,
    ));
    // Get.snackbar(apiResponse.message, apiResponse.status.toString(),backgroundColor: Colors.green);
    update();

    // try {
    //   apiResponse = await _apiController.updateJob(id: id,newJobs: newJobs);
    //   Navigator.of(context).push(MaterialPageRoute(builder: (
    //       context) => LatestJobScreen()));
    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(apiResponse.message),backgroundColor: Colors.green,));
    //   // Get.snackbar(apiResponse.message, apiResponse.status.toString(),backgroundColor: Colors.green);
    //   update();
    // }catch (e) {
    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString()),backgroundColor: Colors.red,));
    //
    //   // Get.snackbar('Error', e.toString(),backgroundColor: Colors.red);
    // }
  }
  void addNewJob({required BuildContext context , required NewJobs newJobs}) async {
    try {
      showLoadingDialog(context: context,title: "loading...");
      apiResponseAddNewJob = await _apiController.addNewJob(context: context, newJobs: newJobs);
      if (apiResponseAddNewJob.status == 200) {
        Navigator.of(context).pop();
        Get.snackbar("success", apiResponseAddNewJob.message);
      }else {
        Navigator.of(context).pop();
        Get.snackbar("error", apiResponseAddNewJob.message,backgroundColor: Colors.red);
      }
    }catch (e) {
      Navigator.of(context).pop();
      Get.snackbar("error", e.toString(),backgroundColor: Colors.red);
    }

  }
}
