import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:soaqman/screens/add_jobs_screen.dart';

import '../wedgit/grid_jobs.dart';
import 'home_screen/controller/home_screen_getx_controller.dart';

class LatestJobScreen extends StatefulWidget {
  @override
  State<LatestJobScreen> createState() => _LatestJobScreenState();
}

class _LatestJobScreenState extends State<LatestJobScreen> {
  // controller
  final HomeScreenGetxController _homeScreenGetxController =
      Get.find<HomeScreenGetxController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jobs'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => AddJobsScreen(isEditing: false),
              ));
            },
            icon: const Icon(Icons.add),
          ),
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
      body: GridJobs(),
    );
  }
}
