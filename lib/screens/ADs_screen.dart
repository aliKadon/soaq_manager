import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../wedgit/grid_show_ADs.dart';

class ADsScreen extends StatefulWidget {
  @override
  State<ADsScreen> createState() => _ADsScreenState();
}

class _ADsScreenState extends State<ADsScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ADs'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/add_ADs_screen');
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
          )
        ],
      ),
      body: GridShowADs(),
    );
  }
}
