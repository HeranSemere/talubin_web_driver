import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:talu_bin_driver/apps/views/home_screen.dart';
import 'apps/views/splash.dart';

void main() async {
  
  await GetStorage.init();
  runApp(DevicePreview(
    enabled: false,
    builder: (context) => MyApp(),
  ) // Wrap your app
      );
}

class MyApp extends StatelessWidget {
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor : Colors.transparent, systemNavigationBarIconBrightness: Brightness.dark));
    box.writeIfNull("isLoggedIn", false);

    return GetMaterialApp(
      title: 'TaluBin Driver',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      builder: DevicePreview.appBuilder,
      debugShowCheckedModeBanner: false,
      home: box.read('isLoggedIn') ? HomeScreen() : SplashScreen(),

    );
  }
}
