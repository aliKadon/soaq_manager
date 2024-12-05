import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soaqman/app/helper.dart';
import 'package:soaqman/screens/job_detail_screen.dart';
import 'package:soaqman/services/admob_service.dart';

class JobItemFilterType extends StatefulWidget {
  String jobType;
  String jobName;
  String jobSalary;
  int id;
  String jobCountry;
  String jobCity;
  int index;

  JobItemFilterType(this.jobType, this.jobName, this.jobSalary, this.id,
      this.jobCountry, this.jobCity,this.index);

  @override
  State<JobItemFilterType> createState() => _JobItemFilterTypeState();
}

class _JobItemFilterTypeState extends State<JobItemFilterType> with Helper {
  @override
  void initState() {
    // admobServices.loadInterstitialAd();
    super.initState();
  }

  AdmobServices admobServices = AdmobServices();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
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
                  widget.jobType,
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
              title: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  widget.jobName,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              subtitle: Row(
                children: [
                  Container(
                    width: 70.w,
                    child: Text(
                      widget.jobSalary,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(width: 5.w,),
                  Container(
                    width: 73.w,
                    child: Text(
                      '${widget.jobCity},${widget.jobCountry}',
                      overflow: TextOverflow.ellipsis,
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
                  child: const Text(
                    'More',
                    style: TextStyle(
                        color: Colors.cyan, fontWeight: FontWeight.bold),
                  ),
                  onTap: () async{
                    showLoadingDialog(context: context,title: 'Loading...');
                    admobServices.loadInterstitialAd1(widget.id, context,widget.index);
                    // Navigator.of(context).pop();
                    // admobServices.showInterstitialAd(widget.id, context,widget.index);
                    // Navigator.of(context).push(MaterialPageRoute(builder: (context) => JobDetailScreen(id: widget.id, index: widget.index),));
                    // admobServices.showInterstitialAd(widget.id, context,widget.index);
                  },
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
