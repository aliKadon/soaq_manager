import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:soaqman/wedgit/ADs_item_rectangle.dart';

import '../screens/home_screen/controller/home_screen_getx_controller.dart';

class GridShowADs extends StatefulWidget {
  @override
  State<GridShowADs> createState() => _GridShowADsState();
}

class _GridShowADsState extends State<GridShowADs> {
  //controller
  final HomeScreenGetxController _homeScreenGetxController =
      Get.put(HomeScreenGetxController());

  @override
  void initState() {
    // TODO: implement initState
    _homeScreenGetxController.getAdvertising(context: context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenGetxController>(
      builder: (controller) => ListView.builder(
        shrinkWrap: false,
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        actions: [
                          Image.network(
                              controller.allAdvertising[index].image_url),
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('OK'))
                        ],
                      ));
            },
            child: ADsItemRectangle(
              controller.allAdvertising[index].image_url,
              controller.allAdvertising[index].id.toString(),
              index,
            ),
          );
        },
        itemCount: controller.allAdvertising.length,
      ),
    );
  }
}
