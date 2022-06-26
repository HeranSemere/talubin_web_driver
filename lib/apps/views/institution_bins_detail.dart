import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:talu_bin_driver/apps/constants/constants.dart';
import 'package:talu_bin_driver/apps/services/api_services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'all_tasks_map.dart';

class InstitutionBinsDetail extends StatefulWidget {
  const InstitutionBinsDetail({Key? key}) : super(key: key);

  @override
  _InstitutionBinsDetailState createState() => _InstitutionBinsDetailState();
}

class _InstitutionBinsDetailState extends State<InstitutionBinsDetail> {


 
  InstitutionInfo institution = Get.arguments[0];
  Color backgroundColor = Color(0xffF5F7FA);

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Color(0xffF5F7FA);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),

      home: Scaffold(

          appBar: AppBar(

            title: Text(institution.institutionName, style: TextStyle(color: Colors.black),overflow: TextOverflow.ellipsis,),
            backgroundColor: backgroundColor,
            iconTheme: IconThemeData(color: Colors.black, size: 40),
            leading: IconButton (icon:Icon(Icons.arrow_back),onPressed:()=> Navigator.pop(context)),
            elevation: 0,

          ),
      body: ListView.builder(

          itemCount: institution.bins.length,
          itemBuilder: (context, index) {
           /* backgroundColor: Color(0xFF11A879),
            foregroundColor: Colors.white,
            icon: Icons.check,
            label: 'Done',*/
            return  Slidable(

              // Specify a key if the Slidable is dismissible.
              key: const ValueKey(0),

              // The start action pane is the one at the left or the top side.
              startActionPane: ActionPane(
                // A motion is a widget used to control how the pane animates.
                motion: const ScrollMotion(),

                // A pane can dismiss the Slidable.
               // dismissible: DismissiblePane(onDismissed: () {}),

                // All actions are defined in the children parameter.
                children: [

                  SlidableAction(
                    backgroundColor: Color(0xFF11A879),
                    foregroundColor: Colors.white,
                    icon: Icons.check,
                    label: 'Done',
                    onPressed: (BuildContext context) {
                      completeTask(institution.bins[index].bin!.id!,context, index);
                    },
                  ),
                ],
              ),

              // The end action pane is the one at the right or the bottom side.
              endActionPane: ActionPane(
                motion: ScrollMotion(),
                children: [

                  SlidableAction(
                    backgroundColor: Color(0xFF11A879),
                    foregroundColor: Colors.white,
                    icon: Icons.check,
                    label: 'Done',
                    onPressed: (BuildContext context) {
                      completeTask(institution.bins[index].bin!.id!,context, index);
                    },
                   //   (institution.bins[index].bin!.id!)
                  ),
                ],
              ),

              // The child of the Slidable is what the user sees when the
              // component is not dragged.
              child: Container(
                //height: 130,

                //margin: const EdgeInsets.fromLTRB(8,4,8,4),


                //margin: const EdgeInsets.all(0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment. center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        //Navigator.pop(context);
                      },
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
                                      Text('Bin ID: '+institution.bins[index].bin!.tbNumber.toString()),
                                      /* Text(

                                      DateTime.tryParse(localCompletedTasks[index].completedDate
                                          .toString())!.day.toString()+"/"+DateTime.tryParse(localCompletedTasks[index].completedDate
                                          .toString())!.month.toString()+"/"+DateTime.tryParse(localCompletedTasks[index].completedDate
                                          .toString())!.year.toString(),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),*/
                                    ],
                                  ),
                                  SizedBox(height: 8.0),
                                  Text(
                                    'Weight: '+ (institution.bins[index].bin!.status!.weight!.blue!+institution.bins[index].bin!.status!.weight!.red!+institution.bins[index].bin!.status!.weight!.other!).toString(),
                                  ),
                                  SizedBox(height: 8),
                                  Padding(
                                    padding: EdgeInsets.all(0),
                                    child: new LinearPercentIndicator(
                                      width: MediaQuery.of(context).size.width - 50,
                                      animation: true,
                                      lineHeight: 20.0,
                                      animationDuration: 2000,
                                      percent: ((institution.bins[index].bin!.status!.weight!.blue!+institution.bins[index].bin!.status!.weight!.red!+institution.bins[index].bin!.status!.weight!.other!)/Ints.weightCapacity),
                                      center: Text( (((institution.bins[index].bin!.status!.weight!.blue!+institution.bins[index].bin!.status!.weight!.red!+institution.bins[index].bin!.status!.weight!.other!)/Ints.weightCapacity)*100).floor().toString()+"%",
                                        style: TextStyle(color: Colors.white),),
                                      linearStrokeCap: LinearStrokeCap.roundAll,
                                      progressColor: Colors.teal[300],  //Todo: Color code the bars according to weight level
                                    ),
                                  ),
                                  /*SizedBox(height: 8),
                                  ElevatedButton(
                                      child: Text("Done"),

                                      style: ButtonStyle(

                                      ),
                                      onPressed:() async{

                                        try{
                                          int response = await APIService().completeTask(institution.bins[index].bin!.id!); //HjqBS0qnkvoQqQcfIONT3
                                          print(response.toString()+"herrrrrrrrrrrrrrrrrrrrrrrrrrrrrrreeee");

                                          if(response == 200){

                                            //Get.to(() => HomeScreen());
                                            /*Get.snackbar(
                                            "Complete",
                                            'Task completed',
                                            snackPosition: SnackPosition.BOTTOM,
                                          );*/

                                            final snackBar = SnackBar(content: Text('Task completed'));
                                            ScaffoldMessenger.of(context).showSnackBar(snackBar);

                                          }else{
                                            /*Get.snackbar(
                                            "Error",
                                            'Couldn\'t complete task',
                                            snackPosition: SnackPosition.BOTTOM,
                                          );*/
                                            final snackBar = SnackBar(content: Text('Couldn\'t complete task'));
                                            ScaffoldMessenger.of(context).showSnackBar(snackBar);


                                          }
                                        }catch(Exception){
                                          Get.snackbar(
                                            "Error",
                                            'Couldn\'t complete task',
                                            snackPosition: SnackPosition.BOTTOM,
                                          );

                                        }
                                      }
                                  )*/

                                  /*Text(
                                  'Weight: '+
                                      (localCompletedTasks[index].weight!.blue!+localCompletedTasks[index].weight!.red!+localCompletedTasks[index].weight!.other!).toString(),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),*/

                                ],
                              ),
                            ),
                          ]),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
           /* return Container(
              //height: 130,

              margin: const EdgeInsets.fromLTRB(8,4,8,4),


              //margin: const EdgeInsets.all(0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment. center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
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
                                    Text('Bin ID: '+institution.bins![index].bin!.tbNumber.toString()),
                                   /* Text(

                                      DateTime.tryParse(localCompletedTasks[index].completedDate
                                          .toString())!.day.toString()+"/"+DateTime.tryParse(localCompletedTasks[index].completedDate
                                          .toString())!.month.toString()+"/"+DateTime.tryParse(localCompletedTasks[index].completedDate
                                          .toString())!.year.toString(),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),*/
                                  ],
                                ),
                                SizedBox(height: 8.0),
                                Text(
                                  'Weight: '+ (institution.bins[index].bin!.status!.weight!.blue!+institution.bins[index].bin!.status!.weight!.red!+institution.bins[index].bin!.status!.weight!.other!).toString(),
                                ),
                                SizedBox(height: 8),
                                Padding(
                                  padding: EdgeInsets.all(0),
                                  child: new LinearPercentIndicator(
                                    width: MediaQuery.of(context).size.width - 50,
                                    animation: true,
                                    lineHeight: 20.0,
                                    animationDuration: 2000,
                                    percent: ((institution.bins[index].bin!.status!.weight!.blue!+institution.bins[index].bin!.status!.weight!.red!+institution.bins[index].bin!.status!.weight!.other!)/Ints.weightCapacity),
                                    center: Text( (((institution.bins[index].bin!.status!.weight!.blue!+institution.bins[index].bin!.status!.weight!.red!+institution.bins[index].bin!.status!.weight!.other!)/Ints.weightCapacity)*100).floor().toString()+"%",
                                      style: TextStyle(color: Colors.white),),
                                    linearStrokeCap: LinearStrokeCap.roundAll,
                                    progressColor: Colors.teal[300],
                                  ),
                                ),
                                SizedBox(height: 8),
                                ElevatedButton(
                                    child: Text("Done"),

                                    style: ButtonStyle(

                                    ),
                                    onPressed:() async{

                                      try{
                                        int response = await APIService().completeTask(institution.bins[index].bin!.id!); //HjqBS0qnkvoQqQcfIONT3
                                        print(response.toString()+"herrrrrrrrrrrrrrrrrrrrrrrrrrrrrrreeee");

                                        if(response == 200){

                                          //Get.to(() => HomeScreen());
                                          /*Get.snackbar(
                                            "Complete",
                                            'Task completed',
                                            snackPosition: SnackPosition.BOTTOM,
                                          );*/

                                          final snackBar = SnackBar(content: Text('Task completed'));
                                          ScaffoldMessenger.of(context).showSnackBar(snackBar);

                                        }else{
                                          /*Get.snackbar(
                                            "Error",
                                            'Couldn\'t complete task',
                                            snackPosition: SnackPosition.BOTTOM,
                                          );*/
                                          final snackBar = SnackBar(content: Text('Couldn\'t complete task'));
                                          ScaffoldMessenger.of(context).showSnackBar(snackBar);


                                        }
                                      }catch(Exception){
                                        Get.snackbar(
                                          "Error",
                                          'Couldn\'t complete task',
                                          snackPosition: SnackPosition.BOTTOM,
                                        );

                                      }
                                    }
                                )

                                /*Text(
                                  'Weight: '+
                                      (localCompletedTasks[index].weight!.blue!+localCompletedTasks[index].weight!.red!+localCompletedTasks[index].weight!.other!).toString(),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),*/

                              ],
                            ),
                          ),
                        ]),
                      ),
                    ),
                  ),
                ],
              ),
            );*/
          })

      ),
    );

  }
  void completeTask(String binID, BuildContext context, int index) async {

    try{
      int response = await APIService().completeTask(binID); //HjqBS0qnkvoQqQcfIONT3
      print(response.toString()+"herrrrrrrrrrrrrrrrrrrrrrrrrrrrrrreeee");

      if(response == 200){

        //Get.to(() => HomeScreen());
        /*Get.snackbar(
                                            "Complete",
                                            'Task completed',
                                            snackPosition: SnackPosition.BOTTOM,
                                          );*/

        final snackBar = SnackBar(content: Text('Task completed'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

        setState(() async { // Todo: let it update from api instead of just going to zero
          institution.bins[index].bin!.status!.weight!.blue = 0;
          institution.bins[index].bin!.status!.weight!.red = 0;
          institution.bins[index].bin!.status!.weight!.other = 0;

          int response = await APIService().completeTask(binID);
        });

      }else{
        /*Get.snackbar(
                                            "Error",
                                            'Couldn\'t complete task',
                                            snackPosition: SnackPosition.BOTTOM,
                                          );*/
        final snackBar = SnackBar(content: Text('Couldn\'t complete task, bin might still be full'));

        ScaffoldMessenger.of(context).showSnackBar(snackBar);






      }
    }catch(Exception){

      final snackBar = SnackBar(content: Text('Couldn\'t complete task'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

    }

  }

  }




