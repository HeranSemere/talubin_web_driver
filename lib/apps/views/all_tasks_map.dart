import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:talu_bin_driver/apps/constants/constants.dart';
import 'package:talu_bin_driver/apps/models/talu_bin_info.dart';


import 'institution_bins_detail.dart';

class AllTasksMap extends StatefulWidget {
  @override
  _AllTasksMapState createState() => _AllTasksMapState();
}

class InstitutionInfo{

  var institutionName;
  var numOfBins;
  var numOfFullBins;
  var institutionId;
  var lat;
  var long;
  List<BinElement> bins;

  InstitutionInfo(this.institutionName, this.numOfBins, this.numOfFullBins, this.institutionId, this.lat, this.long, this.bins);

}

class _AllTasksMapState extends State<AllTasksMap> {


  var tasks = Get.arguments[0];
  final Map<String, Marker> _markers = {};
  List<InstitutionInfo> institutions = [];

  // late GoogleMapController _controller;
  // Location _location = Location();


  void filterTasks(){


    /*

    institutions.add(InstitutionInfo(tasks.data!.bins![0].institution!.name ?? "", 1,tasks.data!.bins![0].bin!.institutionId,tasks.data!.bins![0].bin!.location!.lat, tasks.data!.bins![0].bin!.location!.long));

    for(var i = 0; i < tasks.data!.bins!.length; i++){

      //institutions.add(InstitutionInfo(tasks.data!.bins![i].institution!.name ?? "", 1,tasks.data!.bins![i].bin!.institutionId,tasks.data!.bins![i].bin!.location!.lat, tasks.data!.bins![i].bin!.location!.long));

      for(var j = 0; j < institutions.length; j++){

        if(tasks.data!.bins![i].bin!.institutionId == institutions[j].institutionId){
          institutions[j].numOfBins+=1;
        }else{

          institutions.add(InstitutionInfo(tasks.data!.bins![i].institution!.name ?? "", 1,tasks.data!.bins![i].bin!.institutionId,tasks.data!.bins![i].bin!.location!.lat, tasks.data!.bins![i].bin!.location!.long));
        }

      }


      /* tasks.data!.bins![i].bin!.institutionId
              tasks.data!.bins![i].bin!.location!.lat, tasks.data!.bins![i].bin!.location!.long
              tasks.data!.bins![i].institution!.name ?? "",
              tasks.data!.bins![i].institution!.name ?? "",*/

    }*/

    final groupedBins = groupBy(tasks.data!.bins, (BinElement b) {
      return b.institution!.address;
    });

    institutions.clear();

    groupedBins.forEach((address, binelementList){
      print('Key: $address');
      print('Value: $binelementList');
      print('num of elements: ${binelementList.length}');
      print('------------------------------');


      var numOfFullBins = 0;


      for(var i = 0; i < binelementList.length; i++) {

        var totalWeight = binelementList[i].bin!.status!.weight!.blue! + binelementList[i].bin!.status!.weight!.red! + binelementList[i].bin!.status!.weight!.other!;

        if(totalWeight >= Ints.weightFull){
          numOfFullBins+=1;
        }
      }

      institutions.add(InstitutionInfo(
          binelementList[0].institution!.name,
          binelementList.length,
          numOfFullBins,
          binelementList[0].institution!.id,
          binelementList[0].bin!.location!.lat,
          binelementList[0].bin!.location!.long,
          binelementList
      ));

      for(var i = 0; i < binelementList.length; i++) {

        /*
        institutions.add(InstitutionInfo(
            binelementList[i].institution!.name, binelementList.length,
            binelementList[i].institution!.id,
            binelementList[i].bin!.location!.lat,
            binelementList[i].bin!.location!.long));*/
      }

    });

    print('${groupedBins.length} herrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrreeeeeeeeeeeeeeeee ${institutions.length}');

  }


  @override
  Widget build(BuildContext context) {

    filterTasks();

    return Scaffold(

        body: Stack(
            children: [
              FractionallySizedBox(
                //heightFactor: 0.7,
                heightFactor: 1,
                child: Container(
                  //height: (MediaQuery.of(context).size.height/10)*6,
                    child: GoogleMap(
                      //padding: EdgeInsets.only(top:MediaQuery.of(context).size.height/2),
                      padding: EdgeInsets.only(top:MediaQuery.of(context).size.height/1.3),
                      myLocationEnabled: true,
                      tiltGesturesEnabled: true,
                      compassEnabled: true,
                      scrollGesturesEnabled: true,
                      zoomGesturesEnabled: true,
                      onMapCreated: _onMapCreated,
                      initialCameraPosition: CameraPosition(
                          target: LatLng(9.004371,38.756287),
                          zoom: 13),
                      markers: _markers.values.toSet(),)),
              ),

             /* SizedBox.expand(
                  child: DraggableScrollableSheet(
                      initialChildSize: 0.3,
                      maxChildSize: 0.6,
                      minChildSize: 0.3,
                      builder: (BuildContext context, ScrollController scrollController) {
                        return Container(
                          color: Colors.teal,
                          child: ListView.builder(
                              controller: scrollController,
                              itemCount: tasks.data!.bins!.length,
                              itemBuilder: (context, index) {
                                print(tasks.data);
                                print(tasks.data);
                                return Container(
                                  height: 130,
                                  margin: const EdgeInsets.all(8),
                                  child: GestureDetector(
                                    child: Card(
                                      elevation: 10,
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
                                                Text(
                                                  tasks.data!.bins![index].institution!.name ?? "",
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontSize: 20, fontWeight: FontWeight.bold),
                                                ),
                                                SizedBox(height: 8),
                                                Row(
                                                  children: [
                                                    Text('Updated date: '),
                                                    Text(
                                                      tasks.data!.bins![index].bin!.updatedDate.toString(),
                                                      maxLines: 2,
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 8.0),
                                                Text('Weight: '+ tasks.data!.bins![index].bin!.status!.weight!.blue.toString(),
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                                SizedBox(height: 8.0),
                                                Text('No Bins: '+ tasks.data!.bins![index].institution!.bins!.length.toString(),
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                )
                                              ],
                                            ),
                                          ),
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
                                          ),
                                        ]),
                                      ),
                                    ),
                                  ),

                                );
                              }),
                        );
                      }

                  )
              ),*/
              Positioned(
                top: 20,
                left: 20,
                child: SafeArea(

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

                    /*child: Ink(
                      child: IconButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back),

                        iconSize: 26,
                      ),
                      decoration: ShapeDecoration(
                          color: Colors.red,
                          shape: CircleBorder()
                      ),
                    )*/
                ),


                    /*IconButton(
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back),

                      iconSize: 26,
                    )*/

    ),

            ])
    );


    /* Positioned(

                child: Container(
                  child: Center(
                    child: FutureBuilder<TaluBinInfo>(
                      future:  APIService().getTaluBinInfo(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          // var? taluBin = snapshot.data;
                          return ListView.builder(
                              itemCount: snapshot.data!.bins!.length,
                              itemBuilder: (context, index) {
                                print(snapshot.data);
                                print(snapshot.data);
                                return Container(
                                  height: 130,
                                  margin: const EdgeInsets.all(8),
                                  child: GestureDetector(
                                    child: Card(
                                      elevation: 10,
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
                                                Text(
                                                  snapshot.data!.bins![index].institution!.name ?? "",
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontSize: 20, fontWeight: FontWeight.bold),
                                                ),
                                                SizedBox(height: 8),
                                                Row(
                                                  children: [
                                                    Text('Updated date: '),
                                                    Text(
                                                      snapshot.data!.bins![index].bin!.updatedDate.toString(),
                                                      maxLines: 2,
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 8.0),
                                                Text('Weight: '+ snapshot.data!.bins![index].bin!.status!.weight!.blue.toString(),
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                                SizedBox(height: 8.0),
                                                Text('No Bins: '+ snapshot.data!.bins![index].institution!.bins!.length.toString(),
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                )
                                              ],
                                            ),
                                          ),
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
                                          ),
                                        ]),
                                      ),
                                    ),
                                  ),

                                );
                              });
                        } else {
                          return Center(
                              child: CircularProgressIndicator(
                                color: Colors.tealAccent[700],
                              ));
                        }
                      },
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: Colors.tealAccent[700],
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20.0),
                        topLeft: Radius.circular(20.0),
                      )),
                ),
              )*/

  }



  Future<void> _onMapCreated(GoogleMapController controller) async {
    setState(() {
      _markers.clear();

      /*
      final marker = Marker(
        markerId: MarkerId(tasks.data!.bins![0].bin!.id.toString()),
        position: LatLng(tasks.data!.bins![0].bin!.location!.lat, tasks.data!.bins![0].bin!.location!.long),
        infoWindow: InfoWindow(
          title: tasks.data!.bins![0].institution!.name ?? "",
          snippet: tasks.data!.bins![0].institution!.name ?? "",
        ),
      );

      _markers[tasks.data!.bins![0].bin!.id.toString()] = marker;

      final marker2 = Marker(
        markerId: MarkerId(tasks.data!.bins![1].bin!.id.toString()),
        position: LatLng(tasks.data!.bins![2].bin!.location!.lat, tasks.data!.bins![0].bin!.location!.long),
        infoWindow: InfoWindow(
          title: tasks.data!.bins![2].institution!.name ?? "",
          snippet: tasks.data!.bins![2].institution!.name ?? "",
        ),
      );

      _markers[tasks.data!.bins![1].bin!.id.toString()] = marker2;*/

      /*
      for(var i = 0; i < tasks.data!.bins!.length; i++){
        final marker = Marker(
          markerId: MarkerId(tasks.data!.bins![i].bin!.id.toString()),
          position: LatLng(tasks.data!.bins![i].bin!.location!.lat, tasks.data!.bins![i].bin!.location!.long),
          infoWindow: InfoWindow(
            title: tasks.data!.bins![i].institution!.name ?? "",
            snippet: tasks.data!.bins![i].institution!.name ?? "",
          ),
        );
        _markers[tasks.data!.bins![i].bin!.id.toString()] = marker;
      }*/

      //

      for(var i = 0; i < institutions.length; i++){
        final marker = Marker(
          markerId: MarkerId(institutions[i].institutionId.toString()),
          position: LatLng(institutions[i].lat, institutions[i].long),
          infoWindow: InfoWindow(
            title: institutions[i].institutionName,
            snippet: 'Full Bins: ${institutions[i].numOfFullBins.toString()}/${institutions[i].numOfBins.toString()}',
            onTap: (){
              Get.to(()=>InstitutionBinsDetail(), arguments: [institutions[i]]);
            }
          ),
        );
        _markers[institutions[i].institutionId.toString()] = marker;
      }

    });
  }

}

