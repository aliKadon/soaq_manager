import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:soaqman/screens/cv_request/controller/cv_request_getx_controller.dart';
import 'package:soaqman/screens/cv_request/cv_requet_screen.dart';
import 'package:soaqman/screens/home_screen/controller/home_screen_getx_controller.dart';
import 'package:soaqman/wedgit/container_job_categories.dart';
import 'package:soaqman/wedgit/main_drawer.dart';

import '../../preferences/shared_pref_controller.dart';
import '../../wedgit/container_emara.dart';
import '../../wedgit/job_item_rectangle.dart';
import '../../wedgit/slider_image.dart';
import '../countries_screen.dart';
import '../job_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // controller
  final HomeScreenGetxController _homeScreenGetxController = Get.put(HomeScreenGetxController());
  final CvRequestGetXController _cvRequestGetXController = Get.put(CvRequestGetXController());

  var isLoading = false;
  var isInit = true;
  var isVisible = true;

  //this var to store the name of country when user click on it
  var nameCountry = '';

  BannerAd? bannerAd;
  BannerAd? bnd;

  void creeatBannerAd() {
    bannerAd = BannerAd(
        size: AdSize.banner,
        adUnitId: 'ca-app-pub-3940256099942544/6300978111',
        listener: BannerAdListener(onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
        }),
        request: const AdRequest())
      ..load();
    bnd = BannerAd(
        size: AdSize.banner,
        adUnitId: 'ca-app-pub-3940256099942544/6300978111',
        listener: BannerAdListener(onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
        }),
        request: const AdRequest())
      ..load();
  }

  final ScrollController _scrollController = ScrollController();
  var page = 1;
  var rows = 5;

  //check if it is the bottom of grid
  void scrollListener() {
    debugPrint('you in listner');
    if (_scrollController.offset >= _scrollController.position.maxScrollExtent && !_scrollController.position.outOfRange) {
      debugPrint("reached the bottom");
      debugPrint('page1 : ${page + 1}');
      page = page + 1;
      rows = rows + 5;
      _homeScreenGetxController.getJobsPaging(context: context, pageNumber: page, pageSize: 20);
      // print(_layoutGetxController.productsScroll.length);

      // do something when you reach the bottom of the grid
    }
  }

  @override
  void initState() {
    // _homeScreenGetxController.getJobs(context: context,);
    _cvRequestGetXController.getCvRequest(context: context);
    _homeScreenGetxController.getJobsPaging(context: context, pageNumber: page, pageSize: 20);
    _homeScreenGetxController.getAdvertising(context: context);
    _homeScreenGetxController.getJobsType(context: context);
    _homeScreenGetxController.getCountryList(context: context);
    super.initState();
    creeatBannerAd();
    _scrollController.addListener(scrollListener);
  }

  @override
  void dispose() {
    bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            AppLocalizations.of(context)!.home,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: [
            Stack(
              alignment: Alignment.topRight,
              children: [
                GetBuilder<CvRequestGetXController>(
                  builder:(controller) =>controller.isNewCvReq ? Container(
                    margin: EdgeInsets.only(right: 15.w,top: 12.w),
                    height: 5.w,
                    width: 5.w,
                    decoration: BoxDecoration(color: Colors.red,borderRadius: BorderRadius.circular(30.r)),
                  ) : Container(),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CvRequetScreen(),
                    ));
                  },
                  icon: const Icon(Icons.notifications),
                ),
              ],
            ),
            SvgPicture.asset('assets/image/2.svg', alignment: Alignment.bottomRight, width: 50, color: Colors.white),
          ],
        ),
        drawer: MainDrawer(),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Scrollbar(
                child: GetBuilder<HomeScreenGetxController>(
                  builder: (controller) => SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(top: 15),
                          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                            Text(
                              AppLocalizations.of(context)!.hi_there,
                              style: const TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            const Icon(
                              Icons.waving_hand_rounded,
                              color: Colors.yellow,
                            )
                          ]),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(AppLocalizations.of(context)!.find_the_perfect_job_for_you, style: const TextStyle(fontSize: 20)),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('ADs', style: TextStyle(fontSize: 22)),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pushNamed('/ADs_screen');
                                },
                                child: Text(AppLocalizations.of(context)!.more),
                              )
                            ],
                          ),
                        ),
                        GetBuilder<HomeScreenGetxController>(
                          builder: (controller) => SizedBox(
                            height: MediaQuery.of(context).size.height * 1.3,
                            child: Column(
                              children: [
                                Container(padding: const EdgeInsets.all(10), child: SliderImage()),
                                Container(
                                  padding: const EdgeInsets.only(left: 10, right: 10),
                                  width: MediaQuery.of(context).size.width,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(AppLocalizations.of(context)!.countries, style: const TextStyle(fontSize: 22)),
                                      TextButton(
                                        onPressed: () {
                                          // Navigator.of(context).pushNamed(
                                          //     '/countries_screen',
                                          //     arguments: {
                                          //       'listOfCountries': controller
                                          //           .listOfCountry(controller.listOfJobsPaging),
                                          //     });
                                          Navigator.of(context).push(MaterialPageRoute(
                                            builder: (context) => CountriesScreen(countriesList: controller.countryList),
                                          ));
                                        },
                                        child: Text(AppLocalizations.of(context)!.more),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height * 0.3,
                                  width: MediaQuery.of(context).size.width,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (ctx, index) {
                                      return ContainerEmara(
                                        controller.countryList[index].country_name,
                                        controller.countryList[index].country_url,
                                      );
                                    },
                                    itemCount: controller.countryList.length,
                                  ),
                                ),

                                // add ads
                                bannerAd == null
                                    ? Container()
                                    : SizedBox(
                                        height: 52,
                                        child: AdWidget(
                                          ad: bannerAd!,
                                          // key: UniqueKey(),
                                        ),
                                      ),

                                Container(
                                  padding: const EdgeInsets.only(left: 10, right: 10),
                                  width: MediaQuery.of(context).size.width,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(AppLocalizations.of(context)!.categories, style: const TextStyle(fontSize: 22)),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pushNamed('/categories_screen');
                                        },
                                        child: Text(AppLocalizations.of(context)!.more),
                                      )
                                    ],
                                  ),
                                ),
                                GetBuilder<HomeScreenGetxController>(
                                  builder: (controller) => Container(
                                    height: 150,
                                    child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          return SharedPrefController().lang1 == 'ar'
                                              ? ContainerJobCategories(controller.jobsType[index].url, controller.jobsType[index].namear!, controller.jobsType[index].name)
                                              : ContainerJobCategories(controller.jobsType[index].url, controller.jobsType[index].name, controller.jobsType[index].name);
                                        },
                                        itemCount: controller.jobsType.length),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(left: 10, right: 10),
                                  width: MediaQuery.of(context).size.width,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(AppLocalizations.of(context)!.the_latest_jobs, style: const TextStyle(fontSize: 22)),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pushNamed('/latest_job_screen');
                                        },
                                        child: Text(AppLocalizations.of(context)!.more),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                    child: Expanded(
                                        child: GetBuilder<HomeScreenGetxController>(
                                  builder: (controller) => ListView.builder(
                                    controller: _scrollController,
                                    shrinkWrap: false,
                                    physics: const BouncingScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return SharedPrefController().lang1 == 'ar'
                                          ? GestureDetector(
                                              onTap: () {
                                                Navigator.of(context).push(MaterialPageRoute(
                                                  builder: (context) => JobDetailScreen(id: controller.listOfJobsPaging[index].id, index: index),
                                                ));
                                              },
                                              child: JobItemRectangle(
                                                controller.listOfJobsPaging[index].job_type_ar ?? controller.listOfJobsPaging[index].job_type,
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
                                                    id: controller.listOfJobsPaging[index].id,
                                                    index: index,
                                                  ),
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
                                ))),
                              ],
                            ),
                          ),
                        ),
                        //AD Container
                        bnd == null
                            ? Container()
                            : Container(
                                height: 52,
                                child: AdWidget(
                                  ad: bnd!,
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
