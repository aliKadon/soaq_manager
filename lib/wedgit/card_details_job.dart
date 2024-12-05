import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soaqman/app/helper.dart';

import 'package:soaqman/screens/home_screen/controller/home_screen_getx_controller.dart';

import '../services/admob_service.dart';
import 'container_for_email_phone.dart';

class CardDetailsJob extends StatefulWidget {
  @override
  State<CardDetailsJob> createState() => _CardDetailsJobState();
}

class _CardDetailsJobState extends State<CardDetailsJob> with Helper {
  AdmobServices admobServices = AdmobServices();
  Color color = Colors.blue;



  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenGetxController>(
      builder: (controller) => Container(
        padding: const EdgeInsets.all(10),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 5,
          child: Column(
            children: [
              Container(
                child: ListTile(
                  title: Text(controller.jobsById[0].job_name!,
                      style: const TextStyle(
                          fontSize: 27, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center),
                  subtitle: Padding(
                    padding: const EdgeInsets.all(15),
                    child: ExpandableText(
                      controller.jobsById[0].job_description ?? '',
                      style: const TextStyle(fontSize: 17),
                      textAlign: TextAlign.center,
                      expandText: 'show more',
                      collapseText: 'show less',
                      maxLines: 4,
                      linkColor: Colors.blue,
                    ),
                  ),
                  contentPadding: const EdgeInsets.all(10),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        controller.jobsById[0].job_salary ?? '',
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          '${controller.jobsById[0].job_country} , ${controller.jobsById[0].job_city}',
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Flex(
                direction: Axis.horizontal,
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            controller.jobsById[0].job_email == null ||
                                    controller.jobsById[0].job_email!.isEmpty
                                ? Container()
                                : Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        showLoadingDialog(context: context,title: 'Loading...');
                                        admobServices.loadRewardAdEmail(controller.jobsById[0].job_email,context);

                                      },
                                      child: ContainerForEmailAndPhone(
                                          'Email',
                                          Icons.email,),
                                    ),
                                  ),
                            controller.jobsById[0].job_phonenumber == null ||
                                    controller
                                        .jobsById[0].job_phonenumber!.isEmpty
                                ? Container()
                                : Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        showLoadingDialog(context: context,title: 'Loading...');
                                        admobServices.loadRewardAdPhoneNumber(controller
                                            .jobsById[0].job_phonenumber,context);
                                      },
                                      child: ContainerForEmailAndPhone(
                                          'Phone number',
                                          Icons.phone_android,),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
