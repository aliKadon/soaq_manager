import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soaqman/providers/http_providers.dart';

class ContainerEmara extends StatefulWidget {
  final String countryName;

  final String image_url;

  ContainerEmara(this.countryName, this.image_url);

  @override
  State<ContainerEmara> createState() => _ContainerEmaraState();
}

class _ContainerEmaraState extends State<ContainerEmara> {
  @override
  void initState() {
    Provider.of<HttpProviders>(context, listen: false).getAllJobs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context)
                .pushNamed('/types_of_country_screen', arguments: {
              'countryName': widget.countryName,
            });
          },
          child: Container(
            padding: const EdgeInsets.all(10),
            height: 220,
            width: 150,
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                        widget.image_url,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(widget.countryName,
                        style: const TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
