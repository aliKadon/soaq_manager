import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:soaqman/screens/job_detail_screen.dart';

import '../preferences/shared_pref_controller.dart';
import '../screens/add_jobs_screen.dart';
import '../screens/home_screen/controller/home_screen_getx_controller.dart';
import '../wedgit/job_item_rectangle.dart';

class GridJobs extends StatefulWidget {
  @override
  State<GridJobs> createState() => _GridJobsState();
}

class _GridJobsState extends State<GridJobs> {
  // controller
  final HomeScreenGetxController _homeScreenGetxController =
      Get.find<HomeScreenGetxController>();

  ScrollController _scrollController = ScrollController();
  var page = 1;
  var rows = 5;

  //check if it is the bottom of grid
  void scrollListener() {
    print('you in listner');
    if (_scrollController.offset >=
        _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      print("reached the bottom");
      print('page1 : ${page + 1}');
      page = page + 1;
      rows = rows + 5;
      _homeScreenGetxController.getJobsPaging(context: context,pageNumber: page,pageSize: 20);
      // print(_layoutGetxController.productsScroll.length);

      // do something when you reach the bottom of the grid
    }
  }

  @override
  void initState() {
    _homeScreenGetxController.getJobsPaging(context: context,pageNumber: page,pageSize: 20);
    super.initState();
    _scrollController.addListener(scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    // final jobs = Provider.of<HttpProviders>(context);

    return GetBuilder<HomeScreenGetxController>(
      builder: (controller) => ListView.builder(
        controller: _scrollController,
        shrinkWrap: false,
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return SharedPrefController().lang1 == 'ar'
              ? GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => JobDetailScreen(
                        id: controller.listOfJobsPaging[index].id,index: index),
                  ));
                },
                child: JobItemRectangle(
                  controller.listOfJobsPaging[index].job_type_ar ??
                      controller.listOfJobsPaging[index].job_type,
                  controller.listOfJobsPaging[index].job_name,
                  controller.listOfJobsPaging[index].job_salary,
                  controller.listOfJobsPaging[index].id,
                  controller.listOfJobsPaging[index].job_city,
                  controller.listOfJobsPaging[index].job_country,
                ),
              )
              : GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => JobDetailScreen(
                        id: controller.listOfJobsPaging[index].id,index: index,),
                  ));
                },
                child: JobItemRectangle(
                  controller.listOfJobsPaging[index].job_type,
                  controller.listOfJobsPaging[index].job_name,
                  controller.listOfJobsPaging[index].job_salary,
                  controller.listOfJobsPaging[index].id,
                  controller.listOfJobsPaging[index].job_city,
                  controller.listOfJobsPaging[index].job_country,
                ),
              );
        },
        itemCount: controller.listOfJobsPaging.length,
      ),
    );
  }
}
