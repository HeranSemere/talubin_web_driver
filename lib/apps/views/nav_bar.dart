import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:talu_bin_driver/apps/services/api_services.dart';
import 'package:talu_bin_driver/apps/views/profile.dart';
import 'package:talu_bin_driver/apps/views/completed_task.dart';
import 'package:talu_bin_driver/apps/views/google_map_screen.dart';
import 'package:talu_bin_driver/apps/views/login_screen.dart';
import 'package:talu_bin_driver/apps/views/settings.dart';
import 'performance_screen.dart';

class NavBar extends StatelessWidget {
  final box = GetStorage();
  APIService apiService = APIService();

  // const NavBar({Key? key}) : super(key: key);
  NavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('TaluBin'),
            accountEmail: Text('talubin@gmail.com'),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: ClipOval(
                child: Image.asset(
                  'assets/login_profile.png',
                  fit: BoxFit.cover,
                  width: 90,
                  height: 90,
                ),
              ),
            ),
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: [
                Color(0xff80cbc4),
                Color(0xff4db6ac),
                Color(0xff077968),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )),
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Completed Task'),
            onTap: () => {Get.to(CompletedTasksScreen())},
            /*trailing: ClipOval(
              child: Container(
                color: Colors.red,
                width: 20,
                height: 20,
                child: Center(
                  child: Text(
                    '8',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ),*/
          ),
          ListTile(
            leading: Icon(Icons.graphic_eq_rounded),
            title: Text('Performance'),
            onTap: () => {Get.to(() => Performance())},
          ),
          ListTile(
            leading: Icon(Icons.location_on),
            title: Text('Location'),
            onTap: () => {/*Get.to(() => GoogleMapScreen())*/},
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profile'),
             onTap: () async {
                // await apiService
                //     .getProfile()
                //     .then((value) => print(value))
                //     .catchError((onError) {
                //   print(onError);
                //   Get.to(Profile());
                // });
                Get.to(() => Profile());
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () => {/*Get.to(() => SettingsPage())*/},
          ),
          ListTile(
              leading: Icon(Icons.description),
              title: Text('Policies'),
              onTap: () =>{}
              ),
          Divider(),
          ListTile(
            title: Text('Logout'),
            leading: Icon(Icons.logout_outlined),
            onTap: () => {logOut()},
          ),
        ],
      ),
    );
  }

  void logOut() {
    var userId = box.read('userId').toString();
    print("first id: " + userId);
    print(box.read("isLoggedIn"));
    box.remove('userId');
    print(box.read('userId'));
    box.write('isLoggedIn', false);
    print(box.read('isLoggedIn'));
    Get.offAll(() => Login());
  }

  String getToken() {
    var token = box.read('token').toString();
    return token;
  }

  String getUserId() {
    var token = box.read('userId').toString();
    return token;
  }
}
