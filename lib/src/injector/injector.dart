import 'package:get_it/get_it.dart';
import 'package:resident_app/src/helpers/shared_preferences_helper.dart';

GetIt locatorLocal = GetIt.instance;

Future setupInjector() async {
  SharedPreferencesHelper? sharedPreferencesManager =
      await SharedPreferencesHelper.getInstance();
  locatorLocal
      .registerSingleton<SharedPreferencesHelper>(sharedPreferencesManager!);
}
