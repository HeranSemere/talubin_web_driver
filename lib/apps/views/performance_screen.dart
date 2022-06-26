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
import 'package:talu_bin_driver/apps/models/completed_task_local.dart';
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
        body:  FutureBuilder(
          future: checkConnection(),
          builder: (context, connectionSnapshot) {

            if(connectionSnapshot.connectionState==ConnectionState.done){

               if(connectionSnapshot.data as bool){

                return FutureBuilder<List<CompletedTask>>( 
                  future: APIService().getCompletedTasks(),
                  builder: (context, apiSnapshot) {

                        if(apiSnapshot.connectionState==ConnectionState.done){

                          if(!apiSnapshot.hasError){
                          return FutureBuilder<void>(

                          future: CompletedTask().localise(apiSnapshot.data!),
                          builder: (context, localSnapshot){

                              if(localSnapshot.connectionState==ConnectionState.done){

                                if(!localSnapshot.hasError){
                                  return loadFromInternet(apiSnapshot);
                                  
                                }else{
                                  return loadFromInternet(apiSnapshot);
                                }
                                
                              }else{
                                  return  Center(
                                    child: CircularProgressIndicator(
                                    color: Colors.tealAccent[700],
                                  ));
                              }

                            });
                          }else{

                            return loadPerformance(); //api error

                          }

                          }else{
                              return  Center(
                                    child: CircularProgressIndicator(
                                    color: Colors.tealAccent[700],
                                  ));
                    }
                  
              });

              }else{

                return loadPerformance(); //just load from local if no internet
              }
            }else{
              return  Center(
                                    child: CircularProgressIndicator(
                                    color: Colors.tealAccent[700],
                                  ));
            }

          }
      ),
        
            
            
            );


  }

  Widget loadPerformance(){  ////maybe the problem is the future builder, use normal .then clause like the one in performance screen, and also make suredatabae is not empty

    return FutureBuilder<Database>( //add a refresh functionality here, refreshed from internet if possible
    future: CompletedTasksDatabase().createDB(),
    builder: (context, databaseSnapshot){

      if(databaseSnapshot.connectionState==ConnectionState.done){

        if(databaseSnapshot.hasError){   //error opening database
            return Center(child: Icon(Icons.cloud_off, size: 100,color: Colors.grey),);
          }else{


          return FutureBuilder<List<CompletedTask>>( //add a refresh functionality here, refreshed from internet if possible
          future: CompletedTasksDatabase().getLocalCompletedTasks(databaseSnapshot.data as Database),
          builder: (context, snapshot){

        /*  return FutureBuilder<List<CompletedTask>>( //add a refresh functionality here, refreshed from internet if possible
          future: APIService().getCompletedTasks(),
          builder: (context, snapshot){*/

            if(snapshot.connectionState==ConnectionState.done){

              if(snapshot.hasError){
                  return Center(child: Text("error fetching local data"),); //error screen
                }else{

                  if(snapshot.data!.length == 0){
                    return Center(child: Text("No completed tasks yet"),); //information screen (no completed tasks yet)
                  }

                  return renderUI(snapshot);
               
                }
            }else{
               return Center(
              child: CircularProgressIndicator(
                color: Colors.tealAccent[700],
              ));

            }
    });

      }
       
      }else{
         return Center(
              child: CircularProgressIndicator(
                color: Colors.tealAccent[700],
              ));
      }

    });

  }


  Widget loadFromInternet(AsyncSnapshot<List<CompletedTask>> snapshot){
      return renderUI(snapshot);
  }


  bool fromDropdown = false;
  String? dropdownValue = "Total";


  Widget renderUI(AsyncSnapshot<List<CompletedTask>> snapshot){

      List<CompletedTask> yearData = [];
        List<String> years = [];

        years.add("Total");
     

        for(CompletedTask ct in snapshot.data!){

          String year=DateTime.parse(ct.completedDate.toString()).year.toString();

              if(!years.contains(year)){
                years.add(year);
              }         
          
          }

        

          if(dropdownValue =="Total"){

            //yearData = snapshot.data!;
            for(var y in snapshot.data!){
              yearData.add(y);
            }

          }else{

            for(var y in snapshot.data!){
          
              if(DateTime.parse(y.completedDate.toString()).year.toString() == dropdownValue){
                yearData.add(y);
            }
          
          }


          }

        

        //print("The list in performance class length: "+yearData.length.toString());

        var percentage = getWeightPercentageByType(yearData); 
      
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
              child: SimpleBarChart(yearData, dropdownValue!),
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
                          percentage[0].toInt().toString()+"%",
                          style: TextStyle(
                              color: Colors.teal,
                              fontWeight: FontWeight.bold),
                        ),
                      )),
                  Text(
                    "Blue",
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
                          percentage[1].toInt().toString()+"%",
                          style: TextStyle(
                              color: Colors.teal,
                              fontWeight: FontWeight.bold),
                        ),
                      )),
                  Text(
                    "Red",
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
                          percentage[2].toInt().toString()+"%",
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
                      "    Total number of pick-ups: ${yearData.length}",
                      style: TextStyle(),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.all_inclusive_outlined),
                    Text(
                      "    Total plastic waste: ${getTotalWeight(yearData)} kg",
                      style: TextStyle(),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  
                  children: [
                    Center(child: Icon(Icons.house_outlined)),
                    Text(
                      "    Number of institutions visited: "+getNumOfInstitutionsVisted(yearData).toString(),
                      style: TextStyle(),
                    ),
                  ],
                ),
                /*
                SizedBox(height: 10),
                Row(
                  children: [
                    Icon(Icons.task_outlined),
                    Text(
                      "    Current tasks: 8",
                      style: TextStyle(),
                    ),
                  ],
                ),*/
              ],
            ),
          ),
        ],
      );
    
  }
  

  Widget latestCompletedTasks(){

    
    if(fromDropdown){

    }

    return FutureBuilder<List<CompletedTask>>( //add a refresh functionality here

    future: APIService().getCompletedTasks(),
    builder: (context, snapshot){

    if(snapshot.connectionState==ConnectionState.done) {

      if(snapshot.hasError){

            return loadPerformance(); //return local database value

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

        var percentage = getWeightPercentageByType(snapshot.data!); 
      
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
              child: SimpleBarChart(yearData, dropdownValue!),
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            margin: EdgeInsets.fromLTRB(20, 35, 0, 0),
            child: Text(
              "Total Breakdown",
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
                          percentage[0].toInt().toString()+"%",
                          style: TextStyle(
                              color: Colors.teal,
                              fontWeight: FontWeight.bold),
                        ),
                      )),
                  Text(
                    "Blue",
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
                          percentage[1].toInt().toString()+"%",
                          style: TextStyle(
                              color: Colors.teal,
                              fontWeight: FontWeight.bold),
                        ),
                      )),
                  Text(
                    "Red",
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
                          percentage[2].toInt().toString()+"%",
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

              /*
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
              ),*/
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
                      "Total no of bins retrieved from: ${snapshot.data!.length}",
                      style: TextStyle(),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.all_inclusive_outlined),
                    Text(
                      "Total plastic waste: ${getTotalWeight(snapshot.data!)} kg",
                      style: TextStyle(),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.house_outlined),
                    Text(
                      "Number of institutions visited: "+getNumOfInstitutionsVisted(yearData).toString(),
                      style: TextStyle(),
                    ),
                  ],
                ),
                /*
                SizedBox(height: 10),
                Row(
                  children: [
                    Icon(Icons.task_outlined),
                    Text(
                      "    Current tasks: 8",
                      style: TextStyle(),
                    ),
                  ],
                ),*/
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

  List<double> getWeightPercentageByType(List<CompletedTask> cts){

    int totalWeightBlue = 0;
    int totalWeightRed = 0;
    int totalWeightOther = 0;

    for(CompletedTask ct in cts){
      totalWeightBlue += ct.weight!.blue!; 
      totalWeightRed += ct.weight!.red!;
      totalWeightOther += ct.weight!.other!;

    }

    int totalWeight = totalWeightBlue + totalWeightRed + totalWeightOther;

    List<double> perList = [(totalWeightBlue/totalWeight)*100, (totalWeightRed/totalWeight)*100, (totalWeightOther/totalWeight)*100 ];

    return perList;

  }

  int getNumOfInstitutionsVisted(List<CompletedTask> cts){
    
    List<String> institutions = [];

    for(CompletedTask ct in cts){

      print(ct.institutionName);
      if(institutions.indexOf(ct.institutionName!) == -1){

        institutions.add(ct.institutionName!);

      }
    }


    return institutions.length;
  }

  

}


