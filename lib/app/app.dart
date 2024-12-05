import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:provider/provider.dart';
import 'package:soaqman/app/utils/L10n.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


import '../preferences/language_provider.dart';
import '../preferences/shared_pref_controller.dart';
import '../providers/http_providers.dart';
import '../screens/ADs_screen.dart';
import '../screens/add_ADs_screen.dart';
import '../screens/add_jobs_screen.dart';
import '../screens/categories_screen.dart';
import '../screens/countries_screen.dart';
import '../screens/filter_country_screen.dart';
import '../screens/filter_screen.dart';
import '../screens/home_screen/home_screen.dart';
import '../screens/job_detail_screen.dart';
import '../screens/jobs_of_type_of_country_screen.dart';
import '../screens/latest_job_screen.dart';
import '../screens/types_of_countries_screen.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // var isArabic = SharedPrefController().lang1;


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
        value: HttpProviders(),),
        ChangeNotifierProvider.value(
          value: LocaleProvider(),),
      ],
        child: Builder(
          builder: (context) {
            final provider = Provider.of<LocaleProvider>(context);
            var isArabic = SharedPrefController().lang1;
            return ScreenUtilInit(
              designSize: const Size(375, 812),
              minTextAdapt: true,
              builder: (BuildContext context, Widget? child) {
                return GetMaterialApp(
                  title: 'Soaq Manager',
                  theme: ThemeData(
                    primaryColor: const Color(0x006699ff),
                    fontFamily: 'Roboto',
                    textTheme: const TextTheme(
                      titleMedium: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  localizationsDelegates: const [
                    AppLocalizations.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                  ],
                  supportedLocales: L10n.all,
                  locale: isArabic == 'ar' ? Locale('ar') : Locale('en'),
                  debugShowCheckedModeBanner: false,
                  // home: AnimatedSplashScreen(splash: 'assets/image/splash.png', nextScreen: HomeScreen(),),
                  home: MyHomePage(),
                  routes: {
                    '/home_screen': (ctx) => HomeScreen(),
                    // '/job_details': (ctx) => JobDetailScreen(),
                    '/filter_screen': (ctx) => FilterScreen(),
                    '/filter_country_screen': (ctx) => FilterCountryScreen(),
                    // '/countries_screen': (ctx) => CountriesScreen(),
                    '/latest_job_screen': (ctx) => LatestJobScreen(),
                    '/categories_screen': (ctx) => CategoriesScreen(),
                    '/types_of_country_screen': (ctx) => TypesOfCountriesScreen(),
                    '/jobs_of_type_of_country_screen': (ctx) =>
                        JobsOfTypeOfCoutryScreen(),
                    // '/add_jobs_screen': (ctx) => AddJobsScreen(),
                    '/ADs_screen': (ctx) => ADsScreen(),
                    '/add_ADs_screen': (ctx) => AddADsScreen(),
                  },
                );
              },
            );
          }
        ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    Timer(const Duration(seconds: 4), () {
      Navigator.pushReplacementNamed(context, "/home_screen");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.blue,
        child: Center(
            child: SvgPicture.asset(
              'assets/image/2.svg',
              color: Colors.white,
            )),
      ),
    );
  }
}