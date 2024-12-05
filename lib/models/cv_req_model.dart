import 'package:get/get.dart';

class CvReqModel extends GetxController{
  String? fullName;
  String? email;
  String? body;
  String? extraData;
  int? id;
  bool? isOpen;
  String? date;

  CvReqModel({
    this.email,
    this.id,
    this.body,
    this.extraData,
    this.fullName,
    this.isOpen,
    this.date,
  });

  void toggleRead() async {
    if (isOpen == false) isOpen = true;
    update();
  }

  factory CvReqModel.fromJson(Map<String, dynamic> json) => CvReqModel(
        email: json["email"],
        id: json["id"],
        body: json["body"],
        extraData: json["extra_data"],
        date: json["date"],
        fullName: json["full_name"],
        isOpen: json["is_open"],
      );
}
