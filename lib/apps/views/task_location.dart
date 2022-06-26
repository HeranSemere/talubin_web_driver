import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:talu_bin_driver/apps/constants/constants.dart';
import 'package:talu_bin_driver/apps/models/talu_bin_info.dart';
import 'package:talu_bin_driver/apps/services/api_services.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:talu_bin_driver/apps/utils/MapUtils.dart';
import 'home_screen.dart';
import 'dart:ui' as ui;



/*class TaskLocation extends StatefulWidget {

  //final MapData taskLocation;
  //const TaskLocation({key, @required this.taskLocation}) : super(key: key);

  @override
  _TaskLocationState createState() => _TaskLocationState();
}

class _TaskLocationState extends State<TaskLocation> {

  var taskLocation = Get.arguments;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Sample App"),
        backgroundColor: Colors.tealAccent[700],
      ),
      body: Container(

       // child: Text(taskLocation[1].runtimeType.toString())


         height: 600,
          child: GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
                target: LatLng(taskLocation[1],taskLocation[2]),
                zoom: 15),
            markers: _markers.values.toSet(),)
         ),



    );
  }

  final Map<String, Marker> _markers = {};

  Future<void> _onMapCreated(GoogleMapController controller) async {
    setState(() {
      _markers.clear();

      final marker = Marker(
        markerId: MarkerId(taskLocation[1]),
        position: LatLng(taskLocation[1],taskLocation[2]),
        infoWindow: InfoWindow(
          title: taskLocation[0],
          snippet: taskLocation[0],
        ),
      );
      _markers[taskLocation.institution] = marker;
    });
  }

}*/

class TaskLocation extends StatefulWidget {

  //final MapData taskLocation;
  //const TaskLocation({key, @required this.taskLocation}) : super(key: key);

  @override
  _TaskLocationState createState() => _TaskLocationState();
}

class _TaskLocationState extends State<TaskLocation> {

  var taskLocation = Get.arguments;
  Color backgroundColor = Color(0xfff3f0f0);
  var binid;

  @override
  Widget build(BuildContext context) {

    BinElement binelement = taskLocation[4];

    binid = binelement.bin!.tbNumber;


    return Scaffold(
      body: Stack(
        children: [
          FractionallySizedBox(
              heightFactor: 0.7,

              child: Stack(
                children: [
                  GoogleMap(
                    padding: EdgeInsets.only(top:MediaQuery.of(context).size.height/2),
                    onMapCreated: _onMapCreated,
                    myLocationEnabled: true,
                    initialCameraPosition: CameraPosition(
                        target: LatLng(taskLocation[2],taskLocation[1]),
                        zoom: 12),
                    markers: _markers.values.toSet(),),
                  Align(
                      alignment:Alignment.bottomRight,
                      child:Container(
                        margin: EdgeInsets.fromLTRB(0,0,7,MediaQuery.of(context).size.height/4),
                        child: FloatingActionButton(
                          backgroundColor: Colors.teal,
                          child: Icon(Icons.directions, color: Colors.white, ),
                          onPressed: (){
                            MapUtils.openMap(taskLocation[2],taskLocation[1]);
                          },
                        ),
                      )
                  ),
                ],
              )),

          Align(
            alignment: Alignment.bottomCenter,
            child: FractionallySizedBox(
              heightFactor: 0.31,
              widthFactor: 1,
              child: Container(
                alignment: Alignment.topLeft,
                decoration: BoxDecoration(
                    color: backgroundColor,
                    boxShadow: [
                      BoxShadow(

                       // blurRadius: 1,


                      ),
                    ],
                    borderRadius: BorderRadius.all(
                        Radius.circular(15)
                    )
                ),
                padding: EdgeInsets.all(25),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Text(binelement.institution!.name.toString(), style: TextStyle(
                          color: Colors.black,
                          //fontWeight: FontWeight.bold,
                          fontSize : 20
                      ),),
                      Text("Bin ID: "+binelement.bin!.tbNumber.toString() , style: TextStyle(
                          color: Colors.black,
                          //fontWeight: FontWeight.bold,
                          fontSize : 15
                      ),),
                      Text("Weight: "+(binelement.bin!.status!.weight!.blue!+binelement.bin!.status!.weight!.red!+binelement.bin!.status!.weight!.other!).toString()+" KG" , style: TextStyle(
                          color: Colors.black,
                          //fontWeight: FontWeight.bold,
                          fontSize : 15
                      ),),
                      Text("Date Assigned: "+binelement.bin!.updatedDate!.day.toString()+"/"+binelement.bin!.updatedDate!.month.toString()+"/"+binelement.bin!.updatedDate!.year.toString() , style: TextStyle(
                          color: Colors.black,
                          //fontWeight: FontWeight.bold,
                          fontSize : 15
                      ),),
                      Padding(
                        padding: EdgeInsets.all(0),
                        child: new LinearPercentIndicator(
                          width: MediaQuery.of(context).size.width - 50,
                          animation: true,
                          lineHeight: 20.0,
                          animationDuration: 2000,
                          percent: ((binelement.bin!.status!.weight!.blue!+binelement.bin!.status!.weight!.red!+binelement.bin!.status!.weight!.other!)/Ints.weightCapacity),
                          center: Text( (((binelement.bin!.status!.weight!.blue!+binelement.bin!.status!.weight!.red!+binelement.bin!.status!.weight!.other!)/Ints.weightCapacity)*100).floor().toString()+"%",
                          style: TextStyle(color: Colors.white),),
                          linearStrokeCap: LinearStrokeCap.roundAll,
                          progressColor: Colors.teal[300],
                        ),
                      ),

                      
                      
                      Container(

                        alignment: Alignment.bottomRight,
                        
                        child: ElevatedButton(
                          child: Text("Done"),

                          style: ButtonStyle(

                          ),
                          onPressed:() async{

                            try{
                              int response = await APIService().completeTask(taskLocation[3]); //HjqBS0qnkvoQqQcfIONT3
                              print(response.toString()+"herrrrrrrrrrrrrrrrrrrrrrrrrrrrrrreeee");

                              if(response == 200){

                                Get.to(() => HomeScreen());
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
                      ),
                  ),
                 /* LinearProgressIndicator(
    backgroundColor: Colors.green,
    valueColor: AlwaysStoppedAnimation<Color>(Colors.teal,),
    value: 0.8,
),*/
                    ],
                  ),

               /* child: Container(
                  padding: EdgeInsets.all(7),
                    decoration: BoxDecoration(
                      //color: Colors.teal[400],
                        boxShadow: [
                          BoxShadow(

                            blurRadius: 4,

                          ),
                        ],
                        gradient: LinearGradient(
                            colors: [
                              const Color(0xFF399E91),
                              const Color(0xFF40CFBC),
                            ],
                            begin: const FractionalOffset(0.0, 1.0),
                            end: const FractionalOffset(0.0, 0.0),
                            stops: [0.0, 1.0],
                            tileMode: TileMode.clamp),
                        borderRadius: BorderRadius.all(
                            Radius.circular(15)
                        )
                    ),

                ),
*/
              ),
            ),
          ),


          Positioned(
            top: 50,
            left: 20,
            child: ElevatedButton.icon(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    )
                ),
              ),
              icon: Icon(Icons.arrow_back, color: Colors.black,),
              label: Text("Discover Tasks", style: TextStyle(color: Colors.black),),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),

        ],
      ),
    );
  }

  final Map<String, Marker> _markers = {};

  Future<void> _onMapCreated(GoogleMapController controller) async {

   // final icon = await BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(10, 10)), 'assets/smart_bin_marker.png');
    final Uint8List markerIcon = await getBytesFromAsset('assets/smart_bin_marker_red.png',55);

    setState(() {
      _markers.clear();

      final marker = Marker(
        markerId: MarkerId(taskLocation[3]),
        position: LatLng(taskLocation[2],taskLocation[1]),
        icon: BitmapDescriptor.fromBytes(markerIcon),
        infoWindow: InfoWindow(
          title: taskLocation[0],
          snippet: "Bin ID: "+binid,
        ),
      );
      _markers[taskLocation[0]] = marker;
    });
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec =
    await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }
}

