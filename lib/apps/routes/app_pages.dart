import 'package:get/get.dart';
import 'package:talu_bin_driver/apps/bindings/home_binding.dart';
import 'package:talu_bin_driver/apps/views/intro_screen.dart';



part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => onboarding(),
      binding: HomeBinding(),
    ),
  ];
}
