import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:talu_bin_driver/apps/SQFlite/presist_completed_tasks.dart';
import 'package:talu_bin_driver/apps/models/completed_task.dart';
import 'package:talu_bin_driver/apps/services/api_services.dart';

import 'package:talu_bin_driver/apps/views/home_screen.dart';
import 'package:talu_bin_driver/apps/views/placeholder_chart.dart';

class Performance extends StatefulWidget {
  const Performance({Key? key}) : super(key: key);

  @override
  _PerformanceState createState() => _PerformanceState();
}

class _PerformanceState extends State<Performance> {
  Color backgroundColor = Color(0xffF5F7FA);
  Color cardColor = Color(0xfff0f7f6);

  Future<bool> checkConnection() async{

    var connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.mobile||connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    else{
      return false;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Performance',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          backgroundColor: backgroundColor,
          iconTheme: IconThemeData(color: Colors.black, size: 35),
          elevation: 0,
        ),
        backgroundColor: backgroundColor,
        body: FutureBuilder(
      
          future: checkConnection(),
          builder: (context, snapshot) {

            if(snapshot.connectionState==ConnectionState.done){

              if(snapshot.data as bool){

                return latestCompletedTasks();
              }else{
                return savedCompletedTasks();
              }
            }else{
              return CircularProgressIndicator();
            }

          }
      ),
        
            
            
            );


  }

  Widget savedCompletedTasks(){

    return FutureBuilder<Database>( //add a refresh functionality here, refreshed from internet if possible
    future: CompletedTasksDatabase().createDB(),
    builder: (context, snapshot){

        CompletedTasksDatabase().getLocalCompletedTasks(snapshot.data as Database).then((localCompletedTasks) {

          //return Text("lenght of local database is: "+value.length.toString());

        /*print("lenght of local database is: "+value.length.toString());
        print("sample : "+value[0].institutionName.toString());*/

        return ListView.builder(itemCount: localCompletedTasks.length, itemBuilder: (context, index) {

          return Text("Sample data: "+localCompletedTasks[index].institutionName.toString());

        });


        }, onError: (error) {

          return Center(child: Icon(Icons.cloud_off, size: 100,color: Colors.grey),);//error screen

        });

        return Center(child: Icon(Icons.cloud_off, size: 100,color: Colors.grey),); //error screen

    });


    //return Center(child:Text("Data from local database")); //if there is error fetching saved local completed tasks, display an error screen (transmission error),
    //also, when refresh is clicked here, the list/local database tries to refresh from internet if available
    //use a future builder here 

    /*
      print(snapshot.data!.length.toString() + "hereeeeeeeeeeeeeeeeeeee");
      print(snapshot.data![0].institutionName); //

      CompletedTasksDatabase().createDB().then((value){
        CompletedTasksDatabase().insertCompletedTask(snapshot.data![0], value);
     

      CompletedTasksDatabase().getLocalCompletedTasks(value).then((value) {
        print("lenght of local database is: "+value.length.toString());
        print("sample : "+value[0].institutionName.toString());

        }, onError: (error) {
          print(error);
        });
      });*/
  }


  bool fromDropdown = false;
  String? dropdownValue;
  

  Widget latestCompletedTasks(){

    
    if(fromDropdown){

    }

    return FutureBuilder<List<CompletedTask>>( //add a refresh functionality here

    future: APIService().getCompletedTasks(),
    builder: (context, snapshot){

    if(snapshot.connectionState==ConnectionState.done) {

      if(snapshot.hasError){

            return savedCompletedTasks(); //return local database value

      }else{

        
        List<CompletedTask> yearData = [];
        List<String> years = [];

        for(CompletedTask ct in snapshot.data!){

          String year=DateTime.parse(ct.completedDate.toString()).year.toString();

              if(!years.contains(year)){
                years.add(year);
              }         
          
          }

        dropdownValue = years.last;

        for(var y in snapshot.data!){
          //print("Added year dataaaaa"+DateTime.parse(y.completedDate.toString()).year.toString());
          if(DateTime.parse(y.completedDate.toString()).year.toString() == dropdownValue){
            yearData.add(y);

          }
        }

        //print("The list in performance class length: "+yearData.length.toString());
      
        return Column(
    
         children: [

           Container(
             alignment: Alignment.topRight,
             margin: EdgeInsets.only(right:4),
             child: DropdownButton<String>(
                  value: dropdownValue,
                  icon: const Icon(Icons.filter_list_rounded, color: Colors.teal),
                  iconSize: 24,
                  elevation: 16,
                  style: const TextStyle(
                    color: Colors.black
                  ),
                  underline: Container(
                    height: 2,
                    color: Colors.tealAccent,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue!;
                      fromDropdown = true;
                    });
                  },
                  items: years
                    .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    })
                    .toList(),
                ),
           ), 
            Card(
            //color: cardColor,
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            margin: EdgeInsets.all(4),
            child: Container(
              padding: EdgeInsets.all(10),
              height: 300,
              decoration: BoxDecoration(),
              child: SimpleBarChart(yearData,dropdownValue!),
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            margin: EdgeInsets.fromLTRB(20, 35, 0, 0),
            child: Text(
              "Breakdown",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(150),
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          // The child of a round Card should be in round shape
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          "45%",
                          style: TextStyle(
                              color: Colors.teal,
                              fontWeight: FontWeight.bold),
                        ),
                      )),
                  Text(
                    "PET Bottles",
                    style: TextStyle(color: Colors.grey, fontSize: 10),
                  )
                ],
              ),
              Column(
                children: [
                  Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(150),
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          // The child of a round Card should be in round shape
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          "5%",
                          style: TextStyle(
                              color: Colors.teal,
                              fontWeight: FontWeight.bold),
                        ),
                      )),
                  Text(
                    "Cap",
                    style: TextStyle(color: Colors.grey, fontSize: 10),
                  )
                ],
              ),
              Column(
                children: [
                  Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(150),
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          // The child of a round Card should be in round shape
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          "20%",
                          style: TextStyle(
                              color: Colors.teal,
                              fontWeight: FontWeight.bold),
                        ),
                      )),
                  Text(
                    "Bio-degradable",
                    style: TextStyle(color: Colors.grey, fontSize: 10),
                  )
                ],
              ),
              Column(
                children: [
                  Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(150),
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          // The child of a round Card should be in round shape
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          "30%",
                          style: TextStyle(
                              color: Colors.teal,
                              fontWeight: FontWeight.bold),
                        ),
                      )),
                  Text(
                    "Other",
                    style: TextStyle(color: Colors.grey, fontSize: 10),
                  )
                ],
              ),
            ],
          ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.fromLTRB(30, 35, 10, 10),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.delete_outline),
                    Text(
                      "    Total no of bins retrieved from: ${snapshot.data!.length}",
                      style: TextStyle(),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.all_inclusive_outlined),
                    Text(
                      "    Total plastic waste: ${getTotalWeight(snapshot.data!)} kg",
                      style: TextStyle(),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.house_outlined),
                    Text(
                      "    Number of institutions visited: 5",
                      style: TextStyle(),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Icon(Icons.task_outlined),
                    Text(
                      "    Current tasks: 8",
                      style: TextStyle(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      );

          }
      
      

    }else{

      return Center(
            child: CircularProgressIndicator(
            color: Colors.tealAccent[700],
          ));
    }

  }


  );
    
  }

  int getTotalWeight(List<CompletedTask> cts){

    int totalWeight = 0;

    for(CompletedTask ct in cts){
      int binWeight = ct.weight!.blue!+ ct.weight!.red! +ct.weight!.other!;
      totalWeight+=binWeight;
    }
    
    return totalWeight ;
    
  }

  

  

}


