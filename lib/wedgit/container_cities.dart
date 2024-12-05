import 'package:flutter/material.dart';

class ContainerCities extends StatefulWidget {
  final String cityName;

  final bool visibilty;

  ContainerCities(this.cityName, this.visibilty);

  @override
  State<ContainerCities> createState() => _ContainerCitiesState();
}

class _ContainerCitiesState extends State<ContainerCities> {
  @override
  Widget build(BuildContext context) {
    return Offstage(
      offstage: false,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          width: 100,
          height: 100,
          child: Card(
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            color: Colors.white,
            child: Container(
              child: Center(
                child: TextButton(
                  child: Text(
                    widget.cityName,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed('/filter_country_screen', arguments: {
                      'country': widget.cityName,
                    });
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
