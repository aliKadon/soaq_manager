import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:soaqman/providers/http_providers.dart';

import '../screens/home_screen/controller/home_screen_getx_controller.dart';

class SliderImage extends StatefulWidget {
  @override
  State<SliderImage> createState() => _SliderImageState();
}

class _SliderImageState extends State<SliderImage> {

  // controller
  final HomeScreenGetxController _homeScreenGetxController =
  Get.find<HomeScreenGetxController>();

  @override
  void initState() {
    // Provider.of<HttpProviders>(context, listen: false).getAllAdvertising();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final jobs = Provider.of<HttpProviders>(context);

    return _homeScreenGetxController.allAdvertising.isNotEmpty ? ImageSlideshow(
      indicatorRadius: 4,
      isLoop: true,
      autoPlayInterval: 4500,
      children: List<Widget>.generate(
        _homeScreenGetxController.allAdvertising.length,
        (index) {
          return GestureDetector(
            onTap: () {
              jobs.getWebpage(_homeScreenGetxController.allAdvertising[index].webpage_url);
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                _homeScreenGetxController.allAdvertising[index].image_url,
                fit: BoxFit.scaleDown,
              ),
            ),
          );
        },
      ),
    ) : ImageSlideshow(
      indicatorRadius: 4,
      isLoop: true,
      autoPlayInterval: 3500,
      children: List<Widget>.generate(
        1,
            (index) {
          return GestureDetector(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                'assets/image/filter_image.jpeg',
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}
