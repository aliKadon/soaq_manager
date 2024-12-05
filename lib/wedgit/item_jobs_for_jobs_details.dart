import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:soaqman/app/helper.dart';
import 'package:soaqman/services/admob_service.dart';

import '../models/jobs.dart';

class ItemJobsForJobsDetails extends StatefulWidget {
  final String tag;
  final int index;

  ItemJobsForJobsDetails({required this.tag, required this.index});

  @override
  State<ItemJobsForJobsDetails> createState() => _ItemJobsForJobsDetailsState();
}

class _ItemJobsForJobsDetailsState extends State<ItemJobsForJobsDetails> with Helper {
  //controller
  late final Jobs _jobs = Get.find<Jobs>(tag: widget.tag);

  AdmobServices admobServices = AdmobServices();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.height * 0.2,
      // child: Text('data'),
      child: Container(
        padding: const EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Colors.blue, Colors.cyan],
            ),
            borderRadius: BorderRadius.circular(15)),
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(7),
            child: FittedBox(
              child: Text(
                '${_jobs.job_type}',
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    color: Colors.white),
              ),
            ),
          ),
          Container(
            height: 1,
            color: Colors.black,
          ),
          ListTile(
            title: Text(
              softWrap: true,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              '${_jobs.job_name}',
              style: const TextStyle(color: Colors.white),
            ),
            subtitle: Row(
              children: [
                Expanded(
                  child: Text(
                    '${_jobs.job_salary}',
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(
                  width: 4.w,
                ),
                Expanded(
                  child: Text(
                    textAlign: TextAlign.end,
                    overflow: TextOverflow.ellipsis,
                    '${_jobs.job_city}, ${_jobs.job_country}',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.3,
            height: MediaQuery.of(context).size.height * 0.05,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Center(
              child: GestureDetector(
                child: Text(
                  '${AppLocalizations.of(context)!.more}',
                  style: TextStyle(
                      color: Colors.cyan, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  showLoadingDialog(context: context,title: 'Loading...');
                  admobServices.loadInterstitialAd1(_jobs.id!, context,widget.index);
                },
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
