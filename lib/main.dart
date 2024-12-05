
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:soaqman/preferences/shared_pref_controller.dart';


import 'app/app.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await SharedPrefController().initPref();
  runApp( MyApp());
}

// class MyApp extends StatelessWidget {
//   MyApp({super.key});
//
//   var isArabic = SharedPrefController().lang1;
//
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider.value(
//       value: HttpProviders(),
//       child: MaterialApp(
//         title: 'Soaq Manager',
//         theme: ThemeData(
//           primaryColor: const Color(0x006699ff),
//           fontFamily: 'Roboto',
//           textTheme: const TextTheme(
//             titleMedium: TextStyle(fontWeight: FontWeight.bold),
//           ),
//         ),
//         localizationsDelegates: const [
//           AppLocalizations.delegate,
//           GlobalMaterialLocalizations.delegate,
//           GlobalCupertinoLocalizations.delegate,
//           GlobalWidgetsLocalizations.delegate,
//         ],
//         supportedLocales: L10n.all,
//         locale: Locale(isArabic),
//         debugShowCheckedModeBanner: false,
//         // home: AnimatedSplashScreen(splash: 'assets/image/splash.png', nextScreen: HomeScreen(),),
//         home: MyHomePage(),
//         routes: {
//           '/home_screen': (ctx) => HomeScreen(),
//           '/job_details': (ctx) => JobDetailScreen(),
//           '/filter_screen': (ctx) => FilterScreen(),
//           '/filter_country_screen': (ctx) => FilterCountryScreen(),
//           '/countries_screen': (ctx) => CountriesScreen(),
//           '/latest_job_screen': (ctx) => LatestJobScreen(),
//           '/categories_screen': (ctx) => CategoriesScreen(),
//           '/types_of_country_screen': (ctx) => TypesOfCountriesScreen(),
//           '/jobs_of_type_of_country_screen': (ctx) =>
//               JobsOfTypeOfCoutryScreen(),
//           '/add_jobs_screen': (ctx) => AddJobsScreen(),
//           '/ADs_screen': (ctx) => ADsScreen(),
//           '/add_ADs_screen': (ctx) => AddADsScreen(),
//         },
//       ),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   void initState() {
//     Timer(const Duration(seconds: 4), () {
//       Navigator.pushReplacementNamed(context, "/home_screen");
//     });
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         width: double.infinity,
//         height: double.infinity,
//         color: Colors.blue,
//         child: Center(
//             child: SvgPicture.asset(
//           'assets/image/2.svg',
//           color: Colors.white,
//         )),
//       ),
//     );
//   }
// }
