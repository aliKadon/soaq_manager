import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:soaqman/providers/http_providers.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class TypesOfCountriesScreen extends StatefulWidget {
  @override
  State<TypesOfCountriesScreen> createState() => _TypesOfCountriesScreenState();
}

class _TypesOfCountriesScreenState extends State<TypesOfCountriesScreen> {
  BannerAd? _ad;

  var isLoading = true;

  @override
  void initState() {
    Provider.of<HttpProviders>(context, listen: false).getAllJobs();
    super.initState();
    _ad = BannerAd(
      adUnitId: 'ca-app-pub-3940256099942544/6300978111',
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {},
        onAdFailedToLoad: (ad, error) {
          // Releases an ad resource when it fails to load
          ad.dispose();
          print('Ad load failed (code=${error.code} message=${error.message})');
        },
      ),
    )..load();
  }

  @override
  void dispose() {
    _ad?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final jobs = Provider.of<HttpProviders>(context);
    final results =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
        actions: [
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
      body: Column(
        children: [
          Container(
            height: 52,
            child: AdWidget(
              ad: _ad!,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                          '/jobs_of_type_of_country_screen',
                          arguments: {
                            'countryName': results['countryName'],
                            'typeName': jobs.listOfTypesFromCountries(
                                jobs.getJobs, results['countryName']!)[index],
                          });
                    },
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.black,
                              style: BorderStyle.solid,
                            ),
                          ),
                          child: Center(
                            child: Text(jobs.listOfTypesFromCountries(
                                jobs.getJobs, results['countryName']!)[index]),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  );
                },
                itemCount: jobs
                    .listOfTypesFromCountries(
                        jobs.getJobs, results['countryName']!)
                    .length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
