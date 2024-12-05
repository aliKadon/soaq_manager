import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:soaqman/screens/home_screen/controller/home_screen_getx_controller.dart';

import '../models/jobs.dart';
import '../services/admob_service.dart';
import '../wedgit/card_details_job.dart';
import '../wedgit/item_jobs_for_jobs_details.dart';
import 'add_jobs_screen.dart';

class JobDetailScreen extends StatefulWidget {
  final int id;
  int index;

  JobDetailScreen({required this.id,required this.index});

  @override
  State<JobDetailScreen> createState() => _JobDetailScreenState();
}

class _JobDetailScreenState extends State<JobDetailScreen> {
  //controller
  late final HomeScreenGetxController _mainGetxController =
      Get.find<HomeScreenGetxController>();

  AdmobServices admobServices = AdmobServices();
  var isInit = true;
  var isLoading = false;
  BannerAd? bannerAd;

  void creeatBannerAd() {
    bannerAd = BannerAd(
        size: AdSize.banner,
        adUnitId: 'ca-app-pub-2472186831521160/8490206485',
        listener:
            BannerAdListener(onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
        }),
        request: const AdRequest())
      ..load();
  }

  @override
  void initState() {
    _mainGetxController.getJobsById(context: context, id: widget.id);
    admobServices.loadInterstitialAd();

    super.initState();
    creeatBannerAd();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GetBuilder<HomeScreenGetxController>(
          builder: (controller) => controller.isLoadingJobsById
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Text('${controller.jobsById[0].job_type}'),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/home_screen');
            },
          ),
          SvgPicture.asset(
            'assets/image/2.svg',
            alignment: Alignment.bottomRight,
            width: 50,
            color: Colors.white,
          ),
        ],
      ),
      body: GetBuilder<HomeScreenGetxController>(
        builder: (controller) => controller.isLoadingJobsById
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: double.infinity,
                        child: Image.asset(
                          'assets/image/photo_2022-11-25_21-58-44.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05),
                      Row(
                        children: [
                          Spacer(),
                          GestureDetector(
                            onTap: () {
                              controller.deleteJob(
                                  context: context, id: widget.id);
                            },
                            child: Container(
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  Text(
                                    AppLocalizations.of(context)!.delete,
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 20),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    AddJobsScreen(index: widget.index,id: widget.id,isEditing: true),
                              ));
                            },
                            child: Container(
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.edit,
                                    color: Colors.green,
                                  ),
                                  Text(
                                    AppLocalizations.of(context)!.edit,
                                    style: TextStyle(
                                        color: Colors.green, fontSize: 20),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),
                      CardDetailsJob(),
                      bannerAd == null
                          ? Container(
                              child: const Text('No ads'),
                            )
                          : Container(
                              height: 52,
                              child: AdWidget(
                                ad: bannerAd!,
                              ),
                            ),
                      const Text(
                        'Recommended jobs :',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      controller.listOfJobs.length == 0
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : Container(
                              margin: const EdgeInsets.only(top: 10),
                              height: MediaQuery.of(context).size.height * 0.25,
                              width: MediaQuery.of(context).size.width * 1,
                              child: ListView.builder(
                                // itemCount: ((jobs.length) / 2).toInt(),
                                itemCount: controller.listOfJobs.length < 10
                                    ? controller.listOfJobs.length
                                    : 10,
                                padding: EdgeInsets.all(4),

                                // shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (ctx, index) {
                                  print(
                                      '================================= id 0');
                                  print(controller.listOfJobs[index].id);
                                  Get.put<Jobs>(controller.listOfJobs[index],
                                      tag:
                                          '${controller.listOfJobs[index].id}');
                                  return Row(
                                    children: [
                                      ItemJobsForJobsDetails(
                                        tag:
                                            '${controller.listOfJobs[index].id}',
                                        index: index,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      )
                                    ],
                                  );
                                },
                              ),
                            ),
                      //   ],
                      // ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
