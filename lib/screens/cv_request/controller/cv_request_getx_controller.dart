import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soaqman/app/data/api_controller/cv_request_api_controller.dart';

import '../../../models/cv_req_model.dart';

class CvRequestGetXController extends GetxController {
  final CvRequestApiController _cvRequestApiController = CvRequestApiController();
  final CvReqModel _cvReqModel = Get.put(CvReqModel());
  List<CvReqModel> cvRequest = [];
  bool isNewCvReq = false;

  void getCvRequest({required BuildContext context}) async {
    try {
      cvRequest = await _cvRequestApiController.getCvRequest();
      for (var i in cvRequest) {
        if (i.isOpen == false) {
          isNewCvReq = true;
          break;
        }
      }
      update();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
        backgroundColor: Colors.red,
      ));
    }
  }

  void markAsRead({required int id}) async {
    try {
      _cvReqModel.toggleRead();
      await _cvRequestApiController.makeAsRead(id: id);
    } catch (e) {
      _cvReqModel.isOpen = false;
      update();
      print("this is the error in mark as read : $e");
    }
  }
}
