import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:soaqman/providers/http_providers.dart';
import 'package:soaqman/wedgit/job_item_rectangle.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'home_screen/controller/home_screen_getx_controller.dart';
import 'job_detail_screen.dart';


class JobsOfTypeOfCoutryScreen extends StatefulWidget {
  @override
  State<JobsOfTypeOfCoutryScreen> createState() =>
      _JobsOfTypeOfCoutryScreenState();
}

class _JobsOfTypeOfCoutryScreenState extends State<JobsOfTypeOfCoutryScreen> {


  // controller
  final HomeScreenGetxController _homeScreenGetxController =
  Get.find<HomeScreenGetxController>();


  BannerAd? _ad;

  @override
  void initState() {
    Provider.of<HttpProviders>(context, listen: false).getAllJobs();
    _ad = BannerAd(
      adUnitId: 'ca-app-pub-3940256099942544/6300978111',
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {},
        onAdFailedToLoad: (ad, error) {
          // Releases an ad resource when it fails to load
          ad.dispose();
        },
      ),
    )..load();
    super.initState();
  }

  @override
  void dispose() {
    _ad?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final jobs = Provider.of<HttpProviders>(context).getJobs;
    final results =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final listOfJobsCountry = Provider.of<HttpProviders>(context)
        .listOfTypeAndCountries(
            jobs, results['typeName']!, results['countryName']!);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jobs'),
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
      body: Column(
        children: [
          Container(
            height: 52,
            child: AdWidget(
              ad: _ad!,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: listOfJobsCountry.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () async{
                    var result = await Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => JobDetailScreen(
                          id: listOfJobsCountry[index].id,index: index),
                    ));
                    setState(() {
                      var x = result;
                    });
                    // Navigator.of(context).pushNamed('/job_details', arguments: {
                    //   'id': listOfJobsCountry[index].id,
                    // });
                  },
                  child: JobItemRectangle(
                    listOfJobsCountry[index].job_type,
                    listOfJobsCountry[index].job_name,
                    listOfJobsCountry[index].job_salary,
                    listOfJobsCountry[index].id,
                    listOfJobsCountry[index].job_city,
                    listOfJobsCountry[index].job_country,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
