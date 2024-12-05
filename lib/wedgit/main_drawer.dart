import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:soaqman/providers/http_providers.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


import '../preferences/language_provider.dart';
import '../preferences/shared_pref_controller.dart';

class MainDrawer extends StatefulWidget {
  @override
  State<MainDrawer> createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  var isLoading = false;
  late final curLocale = Provider.of<LocaleProvider>(context, listen: false);
  Locale? local;

  @override
  Widget build(BuildContext context) {
    final jobs = Provider.of<HttpProviders>(context);

    return Drawer(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.2,
            color: Colors.purple,
            child: Image.asset(
              'assets/image/photo_2022-11-25_21-53-06.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0,left: 15,right: 15),
            child: GestureDetector(
              onTap: () {
                _customDialogLanguage(context);
              },
              child: Row(
                children: [
                  // Spacer(),
                  Text(AppLocalizations.of(context)!.language,
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
                  Spacer(),
                  Icon(Icons.chevron_right),
                  // Spacer(),
                ],
              ),
            ),
          ),
          Container(
            alignment: Alignment.bottomLeft,
            padding: const EdgeInsets.all(15),
            child: const Text(
              'Categories :',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                fontFamily: 'Lato',
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(top: 2, bottom: 2),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.72,
                            padding: EdgeInsets.all(10),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () async {
                                      setState(() {
                                        isLoading = true;
                                      });
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return const AlertDialog(
                                            title: Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                          );
                                        },
                                      );

                                      if (jobs.getImageType[index].name == 'Emarits') {
                                        await Provider.of<HttpProviders>(context,
                                            listen: false)
                                            .getJobByNationalityFun(
                                            jobs.getImageType[index].name)
                                            .then((_) => isLoading = false)
                                            .then((_) =>
                                            Navigator.of(context).pop())
                                            .then(
                                              (value) => Navigator.of(context)
                                              .pushNamed('/filter_screen',
                                              arguments: {
                                                'list': jobs
                                                    .getImageType[index].name,
                                              }),
                                        );
                                      }else {
                                        await Provider.of<HttpProviders>(context,
                                            listen: false)
                                            .getJobByTypeFun(
                                            jobs.getImageType[index].name)
                                            .then((_) => isLoading = false)
                                            .then((_) =>
                                            Navigator.of(context).pop())
                                            .then(
                                              (value) => Navigator.of(context)
                                              .pushNamed('/filter_screen',
                                              arguments: {
                                                'list': jobs
                                                    .getImageType[index].name,
                                              }),
                                        );
                                      }

                                    },
                                    child: SharedPrefController().lang1 == 'ar' ?Text(
                                      jobs.getImageType[index].namear!,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ) : Text(
                                      jobs.getImageType[index].name,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  ),
                                ),
                                const Icon(Icons.chevron_right)
                              ],
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Container(
                          height: 1,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                );
              },
              itemCount: jobs.getImageType.length,
            ),
          ),
          const Text('Visit Our Pages.'),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: () {
                    jobs.getWebpage('https://www.facebook.com/profile.php?id=100086435884352');
                  },
                  icon: const Icon(
                    Icons.facebook,
                    color: Colors.blue,
                  )),
              IconButton(
                  onPressed: () {
                    jobs.getWebpage('https://twitter.com/soaqjob');
                  },
                  icon:
                  const Icon(FontAwesomeIcons.twitter, color: Colors.blue)),
              IconButton(
                  onPressed: () {

                    jobs.getWebpage('https://www.instagram.com/soaqjob/');
                  },
                  icon: const Icon(FontAwesomeIcons.instagram,
                      color: Colors.red)),
              IconButton(
                  onPressed: () {jobs.getWebpage('https://t.me/soaqq');},
                  icon: const Icon(FontAwesomeIcons.telegram,
                      color: Colors.blue)),
              IconButton(
                  onPressed: () {

                    jobs.getWebpage('https://www.linkedin.com/company/soaqjob/');
                  },
                  icon: const Icon(FontAwesomeIcons.linkedin,
                      color: Colors.blue)),
            ],
          ),
        ],
      ),
    );
  }

  void _customDialogLanguage(context) async {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
              height: 146,
              width: 360,
              padding: EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(9),
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 12,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        AppLocalizations.of(context)!.language,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18),
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    GestureDetector(
                      onTap: (){
                        curLocale.setLocale( Locale('en'));
                        print('=========================language');
                        print(SharedPrefController().lang1);
                        SharedPrefController().changeLanguage(language: 'en');
                        Navigator.of(context).pushReplacementNamed('/home_screen');
                      },
                      child: Row(
                        children: [
                          Text(AppLocalizations.of(context)!.english,
                            style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18),
                          ),
                          Spacer(),
                          SharedPrefController().lang1 == 'en'?   Icon(Icons.check,color: Colors.lightBlue,):Container(),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    GestureDetector(
                      onTap: (){
                        curLocale.setLocale(Locale('ar'));
                        SharedPrefController().changeLanguage(language: 'ar');
                        print('=========================language');
                        print(SharedPrefController().lang1);
                        Navigator.of(context).pushReplacementNamed('/home_screen');
                      },
                      child: Row(
                        children: [
                          Text(AppLocalizations.of(context)!.arabic,
                            style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18),
                          ),
                          Spacer(),
                          SharedPrefController().lang1 == 'ar'?   Icon(Icons.check,color: Colors.lightBlue,):Container(),
                        ],
                      ),
                    ),

                  ]),
            ),
          );
        });
  }
}
