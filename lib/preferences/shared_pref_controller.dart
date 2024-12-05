import 'package:shared_preferences/shared_preferences.dart';


enum PrefKeys {
  // displayOnBoarding,
  language,
}

class SharedPrefController {
  SharedPrefController._internal();

  late SharedPreferences _sharedPreferences;
  static SharedPrefController? _instance;

  factory SharedPrefController() {
    return _instance ??= SharedPrefController._internal();
  }

  ///TO DO CALLED IN MAIN AFTER --WidgetsFlutterBinding-- AND BEFORE runApp()
  Future<void> initPref() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  var key = 'ar';

  Future<bool> clear() async {
    return _sharedPreferences.clear();
  }

  String get lang1 {
    return _sharedPreferences.getString(PrefKeys.language.toString()) ?? 'en';
  }



  Future<bool> changeLanguage({required String language}) async {
    return _sharedPreferences.setString(PrefKeys.language.toString(), language);
  }

}
