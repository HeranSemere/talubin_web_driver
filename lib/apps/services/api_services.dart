import 'dart:convert';

// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:talu_bin_driver/apps/constants/constants.dart';
import 'package:talu_bin_driver/apps/models/completed_task.dart';
import 'package:talu_bin_driver/apps/models/edit_profile_page.dart';
import 'package:talu_bin_driver/apps/models/profile_page.dart';
import 'package:talu_bin_driver/apps/models/talu_bin_info.dart';
import 'package:talu_bin_driver/apps/models/user_login.dart';
import 'package:talu_bin_driver/apps/views/home_screen.dart';

class APIService {
  static var client = http.Client();
  final box = GetStorage();

  Future<UserLogin> login(
      {required String email, required String password}) async {
    var body = {"email": email, "password": password};

    try {
      final response = await client.post(
        Uri.parse(Strings.autUrl),
        headers: {"Content-Type": "application/json"},
        body: json.encode(body),
      );
      print(response.body);

      if (response.statusCode == 200) {
        // print("here");
        var jsonMap = json.decode(response.body);
        print(jsonMap['userId']);
        box.write("userId", jsonMap['userId']);
        box.write('token', jsonMap['token']);
        box.write('isLoggedIn', true);
        // print('constant: ' + Strings.userId);
        // print('userBox: ' + box.read('userId'));
        Get.offAll(() => HomeScreen());
        return UserLogin.fromJson(jsonMap);
      } else {
        return Future.error('Failed to load data!');
      }
    } catch (e) {
      print(e);
      return Future.error('Failed to load data!');
    }
  }

  Future<int> completeTask(String binId) async {
    final response = await client.post(
      Uri.parse(Strings.taskCompleteUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'userId': box.read("userId"),
        'binId': binId
      }),
    );

    //print(response.statusCode.toString()+"here");
    //var jsonMap = json.decode(response.body);
    print(response.body);

    return response.statusCode;
  }

  Future<TaluBinInfo> getTaluBinInfo() async {
    try {
      var response = await client.get(Uri.parse(Strings.mainUrl));

      if (response.statusCode == 200) {
        var jsonString = response.body;
        var taluBinInfo = taluBinInfoFromJson(jsonString);
        return taluBinInfo;
      } else {
        return Future.error("Failed to get bins");
      }
    } catch (Exception) {
      return Future.error(
          "Failed to map the talubinInfo. Error: " + Exception.toString());
    }
  }

  Future<ProfilePage> getProfile() async {
    try {
      var response = await client.get(Uri.parse(Strings.profileUrl), headers: {
        "Content-Type": "application/json",
        "Authorization": "${Strings.token}"
      });
      print(response.statusCode);

      if (response.statusCode == 200) {
        var jsonString = response.body;
        print(jsonString);

        var profile = profilePageFromJson(jsonString);
        print('here: ${profile.message}');
        return profile;
      }
    } catch (Exception) {
      print("couldn't fetch the profile page");
      return ProfilePage();
    }
    return ProfilePage();
  }


Future<EditProfilePage> updateProfile({required String email, required String password, required String firstName, required String lastName, required String dob}) async {
  var body = {"email": email, "password": password, "firstName": firstName, "lastName": lastName, "dob": dob};
    try {
      var response = await client.put(Uri.parse(Strings.profileUrl), headers: {
        "Content-Type": "application/json",
        "Authorization": "${Strings.token}"
      }, body: json.encode(body),);
      print(response.statusCode);

      if (response.statusCode == 200) {
        var jsonString = response.body;
        print(jsonString);

        var profile = editProfilePageFromJson(jsonString);
        print('here: ${profile.message}');
        return profile;
      }
    } catch (Exception) {
      print("couldn't fetch the profile page");
      return EditProfilePage();
    }
    return EditProfilePage();
  }

  Future<List<CompletedTask>> getCompletedTasks() async {

    try {
      var response = await client.get(Uri.parse(Strings.getCompletedTasks));


      if (response.statusCode == 200) {


        var jsonString = response.body;



        List<CompletedTask> completedTasks= [];

        try {
         completedTasks = (json.decode(response.body) as List)
              .map((i) => CompletedTask.fromJson(i))
              .toList();
        }catch(Exception){
          print(Exception);
        }
        print(jsonString);

        print(Strings.getCompletedTasks);
       print('hereeeeeeeeeeeeeeeeeeeeeeeeee: ${completedTasks.length}');


        print('here: ${completedTasks.length}');

        return completedTasks;
      } else {

        return Future.error("Failed to get completed tasks");
      }
    } catch (Exception) {
      return Future.error(
          "Failed to map the completed tasks. Error: " + Exception.toString());
    }
  }
}