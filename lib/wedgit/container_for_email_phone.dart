import 'package:flutter/material.dart';
import 'package:soaqman/services/admob_service.dart';

class ContainerForEmailAndPhone extends StatelessWidget {
  String name;
  IconData icons;

  ContainerForEmailAndPhone(this.name, this.icons);

  AdmobServices admobServices = AdmobServices();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 15,
      height: 40,
      decoration: const BoxDecoration(),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: Colors.blue,
        elevation: 3,
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(
            icons,
            color: Colors.white,
          ),
          const SizedBox(
            width: 15,
          ),
          Text(
            name,
            style: const TextStyle(color: Colors.white),
          )
        ]),
      ),
    );
  }
}
