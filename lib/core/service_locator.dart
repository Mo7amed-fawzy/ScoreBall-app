import 'package:basketball_counter_app/core/cache_helper.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  // خد اوبجكت خزنه فالسيرفيز لوكيترو
  // خزنه فالسيرفيس لوكيتور داregisterLazySingleton
  // وانا هستخدم الاوبجكت الخدتو
  getIt.registerLazySingleton<CacheHelper>(() => CacheHelper()); // خد اوبجكت
}
