// import 'package:get_storage/get_storage.dart';
import 'package:talu_bin_driver/apps/views/nav_bar.dart';

class Strings {
  static String autUrl = "https://talubin-be.herokuapp.com/users/login";
  static String mainUrl =
      "https://talubin-main.herokuapp.com/api/TaluBins/getBinsInfo";
  static String profileUrl =
      "https://talubin-be.herokuapp.com/users/$userId/userdata";

  static String token = NavBar().getToken().toString();
  static String userId = NavBar().getUserId().toString();
  static String taskCompleteUrl = "https://talubin-main.herokuapp.com/api/TaluBins/completeJob";
  static String getCompletedTasks = "https://talubin-main.herokuapp.com/api/Tasks/byCollector?userId=$userId";

}
class Ints{
  static var weightFull = 17;
  static var weightCapacity = 30;
}
