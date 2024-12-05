import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:soaqman/screens/cv_request/controller/cv_request_getx_controller.dart';

class CvRequetScreen extends StatefulWidget {
  @override
  State<CvRequetScreen> createState() => _CvRequetScreenState();
}

class _CvRequetScreenState extends State<CvRequetScreen> {
  final CvRequestGetXController _cvRequestGetXController = Get.find<CvRequestGetXController>();
  @override
  void initState() {
    _cvRequestGetXController.getCvRequest(context: context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CV Requests"),
      ),
      body: GetBuilder<CvRequestGetXController>(
        builder: (controller) => ListView.builder(
          itemCount: controller.cvRequest.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Stack(
              alignment: Alignment.topRight,
              children: [
                controller.cvRequest[index].isOpen!
                    ? Container()
                    : Container(
                        margin: EdgeInsets.only(top: 20.w, right: 20.w),
                        height: 5.w,
                        width: 5.w,
                        decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(50.r)),
                      ),
                GestureDetector(
                  onTap: () {
                    print(" i am tapping now!!!");
                    controller.markAsRead(id: controller.cvRequest[index].id!);
                  },
                  child: Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.r), color: Colors.purple.withOpacity(0.05)),
                    padding: EdgeInsets.all(5.w),
                    margin: EdgeInsets.all(15.w),
                    child: Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(controller.cvRequest[index].fullName ?? ""),
                            Text(
                              controller.cvRequest[index].email ?? "",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                        const Spacer(),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ))
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
