import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:soaqman/providers/http_providers.dart';
import 'package:soaqman/wedgit/job_item_filter_type.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class FilterScreen extends StatefulWidget {
  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  var isInit = true;
  var isLoading = true;

  @override
  Widget build(BuildContext context) {
    final jobs = Provider.of<HttpProviders>(context, listen: false);
    final results =
    ModalRoute.of(context)?.settings.arguments as Map<String, String>;

    return Scaffold(
      appBar: AppBar(
        title: const Text('filter screen'),
        actions: [
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/home_screen');
            },
          ),
          SvgPicture.asset('assets/image/2.svg',
              alignment: Alignment.bottomRight, width: 50, color: Colors.white),
        ],
      ),
      body: results['list'] == 'Emarits'
          ? jobs.getJobByNationality.isEmpty
          ? const Center(
          child: Text('Sorry there is no jobs yet, please try later.'))
          : SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.3,
                width: double.infinity,
                child: Image.asset('assets/image/photo_2022-11-25_22-00-29.jpg',
                    fit: BoxFit.scaleDown),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.6,
                child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemCount: jobs.getJobByNationality.length,
                  itemBuilder: (context, index) {
                    return JobItemFilterType(
                        jobs.getJobByNationality[index].job_type,
                        jobs.getJobByNationality[index].job_name,
                        jobs.getJobByNationality[index].job_salary,
                        jobs.getJobByNationality[index].id,
                        jobs.getJobByNationality[index].job_country,
                        jobs.getJobByNationality[index].job_city,
                    index);
                  },
                ),
              ),
            ],
          ),
        ),
      )
          : jobs.getJobByType.isEmpty
          ? const Center(
          child: Text('Sorry there is no jobs yet, please try later.'))
          : SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.3,
                width: double.infinity,
                child: Image.asset('assets/image/photo_2022-11-25_22-00-29.jpg',
                    fit: BoxFit.scaleDown),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.6,
                child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemCount: jobs.getJobByType.length,
                  itemBuilder: (context, index) {
                    return JobItemFilterType(
                        jobs.getJobByType[index].job_type,
                        jobs.getJobByType[index].job_name,
                        jobs.getJobByType[index].job_salary,
                        jobs.getJobByType[index].id,
                        jobs.getJobByType[index].job_country,
                        jobs.getJobByType[index].job_city,
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
