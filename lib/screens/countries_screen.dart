import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:soaqman/providers/http_providers.dart';
import 'package:soaqman/wedgit/container_emara.dart';

import '../models/country_list.dart';


class CountriesScreen extends StatefulWidget {
  final List<CountryList> countriesList;

  CountriesScreen({required this.countriesList});

  @override
  State<CountriesScreen> createState() => _CountriesScreenState();
}

class _CountriesScreenState extends State<CountriesScreen> {
  @override
  Widget build(BuildContext context) {
    // final result =
    //     ModalRoute.of(context)?.settings.arguments as Map<String, List>;
    // final jobs = Provider.of<HttpProviders>(context).getJobs;
    // final job = Provider.of<HttpProviders>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Countries'),
        actions: [
          IconButton(icon: const Icon(Icons.home),onPressed: () {
            Navigator.of(context).pushReplacementNamed('/home_screen');
          },),
          SvgPicture.asset(
            'assets/image/2.svg',
            alignment: Alignment.bottomRight,
            width: 50,
            color: Colors.white,
          )
        ],
      ),
      body: GridView.builder(
        shrinkWrap: true,

          gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,childAspectRatio: 0.5),
          itemBuilder: (context, index) {
            return ContainerEmara(widget.countriesList[index].country_name,
                widget.countriesList[index].country_url);
          },
          itemCount: widget.countriesList.length),
    );
  }
}
