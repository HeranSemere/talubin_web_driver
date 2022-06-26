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

class CompletedTasksScreen extends StatefulWidget {
  const CompletedTasksScreen({Key? key}) : super(key: key);

  @override
  _CompletedTasksScreenState createState() => _CompletedTasksScreenState();
}

class _CompletedTasksScreenState extends State<CompletedTasksScreen> {
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
        title: Text('Completed Tasks'),
        backgroundColor: Colors.tealAccent[700],
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: FutureBuilder(
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
                                  return renderUi(apiSnapshot);
                                  
                                }else{
                                  return renderUi(apiSnapshot);
                                }
                                
                              }else{
                                  return  Center(
                                    child: CircularProgressIndicator(
                                    color: Colors.tealAccent[700],
                                  ));
                              }

                            });
                          }else{

                            return loadCompletedTasks(); //api error

                          }

                          }else{
                              return  Center(
                                    child: CircularProgressIndicator(
                                    color: Colors.tealAccent[700],
                                  ));
                    }
                  
              });

              }else{

                return loadCompletedTasks(); //just load from local if no internet
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

/*
  Widget latestCompletedTasks() {

    return FutureBuilder<List<CompletedTask>>( //add a refresh functionality here

    future: APIService().getCompletedTasks(),
    builder: (context, snapshot){

    if(snapshot.connectionState==ConnectionState.done){
       if(snapshot.hasError){
            return Center(child: Icon(Icons.cloud_off, size: 100,color: Colors.grey),);
          }else{

              CompletedTaskLocal().localise(snapshot.data!);

              return RefreshIndicator(
              onRefresh: _refresh,
              color: Colors.teal,
                child: ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    print(snapshot.data);
                    print(snapshot.data);
                    return Container(
                      //height: 130,
                      margin: const EdgeInsets.all(0),
                      child: GestureDetector(
                        onTap: () {},
                        child: Card(
                          elevation: 3,
                          clipBehavior: Clip.antiAlias,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Row(children: [
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    // Text(formattedTime),
                                    
                                    Row(
                                      children: [
                                        Text('Date completed: '),
                                        Text(
                                              DateTime.tryParse(snapshot.data![index].completedDate
                                              .toString())!.day.toString()+"/"+DateTime.tryParse(snapshot.data![index].completedDate
                                              .toString())!.month.toString()+"/"+DateTime.tryParse(snapshot.data![index].completedDate
                                              .toString())!.year.toString()
                                          ,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),                            
                                    SizedBox(height: 8.0),
                                    Text(
                                      snapshot.data![index].institutionName.toString()
                                             
                                          ,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      'Weight: ' +
                                          (snapshot.data![index].weight!.blue!+snapshot.data![index].weight!.red!.toInt()+snapshot.data![index].weight!.other!.toInt()).toString()
                                              .toString(),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    
                                  ],
                                ),
                              ),

                              /*
                              SizedBox(width: 16),
                              Card(
                                clipBehavior: Clip.antiAlias,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Image.network(
                                  "https://images.unsplash.com/photo-1567103472667-6898f3a79cf2?ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8Y29jYWNvbGElMjBsb2dvfGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60",
                                  fit: BoxFit.cover,
                                ),
                              ),*/
                            ]),
                          ),
                        ),
                      ),
                    );
                  }),
              );
              
            
          }
          } else {
            return Center(
                child: CircularProgressIndicator(
              color: Colors.tealAccent[700],
            ));
          }
        }


    );


  }*/

  Widget loadCompletedTasks(){  ////maybe the problem is the future builder, use normal .then clause like the one in performance screen, and also make suredatabae is not empty

    return FutureBuilder<Database>( //add a refresh functionality here, refreshed from internet if possible
    future: CompletedTasksDatabase().createDB(),
    builder: (context, snapshot){

      if(snapshot.connectionState==ConnectionState.done){

        if(snapshot.hasError){
            return Center(child: Text("error opening database"),);
          }else{


          return FutureBuilder<List<CompletedTask>>( //add a refresh functionality here, refreshed from internet if possible
          future: CompletedTasksDatabase().getLocalCompletedTasks(snapshot.data as Database),
          builder: (context, localCompletedTasksForward){

            if(localCompletedTasksForward.connectionState==ConnectionState.done){

              if(localCompletedTasksForward.hasError){
                  return Center(child: Text("error fetching local data"),); //error screen
                }else{

                  if(localCompletedTasksForward.data!.length == 0){
                    return Center(child: Text("No completed tasks yet"),);
                  }

                  return renderUi(localCompletedTasksForward);

                    }
            }else{
               return Center(
              child: CircularProgressIndicator(
                color: Colors.tealAccent[700],
              ));

            }
    });

      }
        /*CompletedTasksDatabase().getLocalCompletedTasks(snapshot.data as Database).then((localCompletedTasks) {

          //return Text("lenght of local database is: "+value.length.toString());
          print("lenght of local database is: "+localCompletedTasks.length.toString());*/

        /*print("lenght of local database is: "+value.length.toString());
        print("sample : "+value[0].institutionName.toString());*/

      /*  return ListView.builder(itemCount: localCompletedTasks.length, itemBuilder: (context, index) {

          return Text("Sample data: "+localCompletedTasks[index].institutionName.toString());

        });


        }, onError: (error) {

          return Center(child: Icon(Icons.cloud_off, size: 100,color: Colors.grey),);//error screen

        });

       return Center(child: Icon(Icons.cloud_off, size: 100,color: Colors.grey),); //error screen*/
      }else{
         return Center(
              child: CircularProgressIndicator(
                color: Colors.tealAccent[700],
              ));
      }

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


  Widget renderUi(var localCompletedTasksForward){
    
               
                var localCompletedTasks = localCompletedTasksForward.data!.reversed.toList();

               return RefreshIndicator(
                onRefresh: _refresh,
                color: Colors.teal,
                    child:ListView.builder(
                      
                    itemCount: localCompletedTasks.length,
                    itemBuilder: (context, index) {
                      print(localCompletedTasks);
                      print(localCompletedTasks);
                      return Container(
                        //height: 130,
                      
                        margin: const EdgeInsets.fromLTRB(8,4,8,4),
                        

                        //margin: const EdgeInsets.all(0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment. center,
                          children: [
                            GestureDetector(
                              onTap: () {},
                              child: Card(
                                
                                elevation: 3,
                                clipBehavior: Clip.antiAlias,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(15,25,0,25),
                                  child: Row(children: [
                                    Flexible(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          // Text(formattedTime),
                                          
                                          Row(
                                            children: [
                                              Text('Date Completed: '),
                                              Text(
          
                                                    DateTime.tryParse(localCompletedTasks[index].completedDate
                                                      .toString())!.day.toString()+"/"+DateTime.tryParse(localCompletedTasks[index].completedDate
                                                      .toString())!.month.toString()+"/"+DateTime.tryParse(localCompletedTasks[index].completedDate
                                                      .toString())!.year.toString(), 
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ],
                                          ),                            
                                          SizedBox(height: 8.0),
                                          Text(
                                            localCompletedTasks[index].institutionName.toString()
                                                  
                                                ,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(height: 8),
                                          Text(
                                            'Weight: '+
                                            (localCompletedTasks[index].weight!.blue!+localCompletedTasks[index].weight!.red!+localCompletedTasks[index].weight!.other!).toString(),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          
                                        ],
                                      ),
                                    ),
                                  ]),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }));
  }

  
  Future<void> _refresh() async {

    setState(() {
 
    }); 
  }

}


