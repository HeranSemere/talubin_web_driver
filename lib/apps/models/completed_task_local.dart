import 'package:talu_bin_driver/apps/SQFlite/presist_completed_tasks.dart';
import 'package:talu_bin_driver/apps/models/completed_task.dart';

var data ={
      'completedDate': "fsdf",
      'userId': "fsdf",
      'institutionName': "fsdf",
      'TBNumber': "fsdf",
      'weightBlue': 35,
      'weightRed': 36,
      'weightOther': 34,
      'long': 38,
      'lat': 9,
      'institutionId': "fsdf",
      'createdDate': "fsdf",
      'updatedDate': "fsdf",
      'completedId ': "fsdf",
      };

class CompletedTaskLocal {

  String? completedDate;
  String? userId;
  String? institutionName;
  String? tBNumber;
  int? weightBlue;
  int? weightRed;
  int? weightOther;
  double? long;
  double? lat;
  String? institutionId;
  String? createdDate;
  String? updatedDate;
  String? completedId;

  CompletedTaskLocal({this.completedDate, this.userId, this.institutionName, this.tBNumber, this.weightBlue, this.weightRed, this.weightOther, this.long, this.lat, this.institutionId, this.createdDate, this.updatedDate, this.completedId});


  Map<String, dynamic> toMap() {
    return {
      'completedDate': completedDate,
      'userId': userId,
      'institutionName': institutionName,
      'TBNumber': tBNumber,
      'weightBlue': weightBlue,
      'weightRed': weightRed,
      'weightOther': weightOther,
      'long': long,
      'lat': lat,
      'institutionId': institutionId,
      'createdDate': createdDate,
      'updatedDate': updatedDate,
      'completedId ': completedId,
    };
  }

  localise(List<CompletedTask> ctl) async{

    List<Map<String, Object>> localCompletedTasks= [];


    for(CompletedTask ct in ctl){
    data = {
          'completedDate': ct.completedDate!,
          'userId': ct.userId!,
          'institutionName': ct.institutionName!,
          'TBNumber': ct.tBNumber!,
          'weightBlue': ct.weight!.blue!,
          'weightRed': ct.weight!.red!,
          'weightOther': ct.weight!.other!,
          'long': ct.bin!.location!.long!,
          'lat': ct.bin!.location!.lat!,
          'institutionId': ct.bin!.institutionId!,
          'createdDate': ct.bin!.createdDate!,
          'updatedDate': ct.bin!.updatedDate!,
          'completedId ': ct.bin!.id!,
        };

        localCompletedTasks.add(data);

    }

    var database = await CompletedTasksDatabase().createDB(); 

    //await CompletedTasksDatabase().insertCompletedTask(localCompletedTasks, database);

    print("Succesfully presisted data"); 



  }


}
