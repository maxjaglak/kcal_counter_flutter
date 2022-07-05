import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {

  static const areTermsAcceptedKey = "isFirstLaunch";

  Future<bool> areTermsAccepted() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool(areTermsAcceptedKey) ?? false;
  }

  Future<void> setTermsAccepted(bool value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool(areTermsAcceptedKey, value);
  }

}