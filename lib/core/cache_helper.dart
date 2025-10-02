// هفصل الكود بتاع الامبلمنتاشن بتاع الباكدج عن المكان بتاع الكاش
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences sharedPreferences;

  init() async {
    sharedPreferences = await SharedPreferences.getInstance();
    // خدت نسخة من الشيرد وخزنتها فالفاريابل بحيث اكتب الميثودز واستخدمها فالابلكيشن
  }

// الهو هخزن الداتا بانهي كيي
  Future<bool> saveData({required String key, required dynamic value}) async {
    if (value is int) {
      return await sharedPreferences.setInt(key, value);
    } else if (value is double) {
      return await sharedPreferences.setDouble(key, value);
    } else if (value is String) {
      return await sharedPreferences.setString(key, value);
    } else if (value is bool) {
      return await sharedPreferences.setBool(key, value);
    } else {
      return await sharedPreferences.setStringList(key, value);
    }
  }

  // setInt('teamAPoints', teamAPoints + 1);
  // دا مثال علي الكيي والفاليو هنا الكيي التكست المتخزن والفايلو الفيها الانكرمنت

  dynamic getData({required String key}) {
    return sharedPreferences.get(key);
  }

//بقولو مثلا امسحلي الكاونتر
  Future<bool> removeData({required String key}) async {
    return await sharedPreferences.remove(key);
  }

// بقولو امسح كل حاجه
  Future<bool> clearData() async {
    return await sharedPreferences.clear();
  }

// بتروح علكاش وتشوف الكيي موجود ولا لا بتروو وفولس
  bool containsData({required String key}) {
    return sharedPreferences.containsKey(key);
  }
}
