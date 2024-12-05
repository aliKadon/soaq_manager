import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:soaqman/providers/http_providers.dart';
import 'package:soaqman/wedgit/job_item_filter_type.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class FilterCountryScreen extends StatefulWidget {
  @override
  State<FilterCountryScreen> createState() => _FilterCountryScreenState();
}

class _FilterCountryScreenState extends State<FilterCountryScreen> {
  var isInit = true;
  var isLoading = false;

  @override
  void didChangeDependencies() {
    if (isInit) {
      final result =
          ModalRoute.of(context)?.settings.arguments as Map<String, String>;
      Provider.of<HttpProviders>(context).getJobByCityFun(result['country']!);
      setState(() {
        isInit = false;
      });
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final jobs = Provider.of<HttpProviders>(context);

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/home_screen');
            },
          ),
          SvgPicture.asset('assets/image/2.svg',
              alignment: Alignment.bottomRight, width: 50, color: Colors.white),
        ],
        title: const Text('Filter'),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.3,
                width: double.infinity,
                child: Image.asset('assets/image/filter_image.jpeg',
                    fit: BoxFit.cover),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.6,
                child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemCount: jobs.getJobByCity.length,
                  itemBuilder: (context, index) {
                    return JobItemFilterType(
                        jobs.getJobByCity[index].job_type,
                        jobs.getJobByCity[index].job_name,
                        jobs.getJobByCity[index].job_salary,
                        jobs.getJobByCity[index].id,
                        jobs.getJobByCity[index].job_country,
                        jobs.getJobByCity[index].job_city,
                    index);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
