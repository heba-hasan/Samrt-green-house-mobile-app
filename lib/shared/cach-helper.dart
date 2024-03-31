import 'package:shared_preferences/shared_preferences.dart';

class CachHelper {

  static late SharedPreferences sharedPreference;
  static init () async {
    sharedPreference= await SharedPreferences.getInstance();
  }

  static dynamic getdata({
    required String key,
  })
  {
    return sharedPreference.get(key);
  }


  static Future<bool> savedata({
    required String key,
    required dynamic value,
  })async
  {
    if(value is bool) return await sharedPreference.setBool(key, value);
    else if(value is String) return await sharedPreference.setString(key, value);
    else if(value is int) return await sharedPreference.setInt(key, value);
    return await sharedPreference.setDouble(key, value);
  }


  static Future<bool> cleardata({
    required String key,
  })async
  {
    return sharedPreference.remove(key);
  }
}