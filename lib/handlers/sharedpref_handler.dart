import 'package:shared_preferences/shared_preferences.dart';

class SharedprefHandler {


  Future<String> readString (String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) ?? "";}

  Future<void > writeString (String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);}

  Future <void> removeString (String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);}
}