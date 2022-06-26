import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:talu_bin_driver/apps/constants/constants.dart';
import 'package:talu_bin_driver/apps/models/talu_bin_info.dart';
import 'package:talu_bin_driver/apps/services/api_services.dart';
import 'package:talu_bin_driver/apps/views/task_location.dart';
import 'package:talu_bin_driver/apps/views/all_tasks_map.dart';
import 'package:connectivity/connectivity.dart';
import 'package:geocoder/geocoder.dart';

import 'nav_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;



  var tasks;
  late Future<BinElement> taluBinInfo;
  
  @override
  void initState() {

    super.initState();
    initConnectivity();

    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
      return;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
    });
  }

  Color backgroundColor = Color(0xffF5F7FA);
  Color cardColor = Color(0xffDFDADA);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Discover Tasks', style: TextStyle(color: Colors.black),),
        backgroundColor: backgroundColor,
        iconTheme: IconThemeData(color: Colors.black, size: 35),
        elevation: 0,

      ),
      backgroundColor: backgroundColor ,
      body: FutureBuilder(
        //onRefresh: () async => Future.delayed(Duration(seconds: 3)),
          future: checkConnection(),
          builder: (context, snapshot) {

            if(snapshot.connectionState==ConnectionState.done){
              if(snapshot.data as bool){
                return body();
              }else{
                return notConnectedBody();
              }
            }else{
              return CircularProgressIndicator();
            }

          }
      ),

      drawer: Drawer(
        child: Container(
          child: Column(
            children: [
              NavBar(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.tealAccent[700],
        onPressed: () {

    

        checkConnection().then((value) {

          if(value){
            if(tasks!=null){
            Get.to(()=> AllTasksMap(), arguments: [tasks]);
          }else{
            final snackBar = SnackBar(content: Text('Loading data...'));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            //Fluttertoast.showToast(msg: "No Connection",toastLength: Toast.LENGTH_SHORT,gravity: ToastGravity.BOTTOM,timeInSecForIos: 1);
          }
          //Get.to(()=> GoogleMapScreen(),);
          }else{

            final snackBar = SnackBar(content: Text('No connection'));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);

          }

           


        

        });

         
        },
        // tooltip: 'Google Map Demo',
        child: Icon(Icons.pin_drop_outlined),
      ),

    );
  }


  Future<bool> checkConnection() async{

    var connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.mobile||connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    else{
      return false;
    }
  }

  Widget notConnectedBody(){
    return Center(child: Icon(Icons.cloud_off, size: 100,color: Colors.grey),);
  }


  /*Future<String> GetAddressFromLatLong(var latitude, var longitude)async {

    List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
    print(placemarks);
    Placemark place = placemarks[0];

    return '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';

    //return 'Location';

  }*/

  /*
  Future<String> _getAddress(double lat, double lang) async {

    final coordinates = new Coordinates(lat, lang);
    List<Address> add =
    await Geocoder.local.findAddressesFromCoordinates(coordinates);
    return add;

  }*/


  


  Widget body(){
    
    return FutureBuilder<TaluBinInfo>(
      future:  APIService().getTaluBinInfo(),
      builder: (context, snapshot) {

        if(snapshot.connectionState==ConnectionState.done){

          if(snapshot.hasError){
            return Center(child: Icon(Icons.cloud_off, size: 100,color: Colors.grey),);
          }else{

            tasks=snapshot;

            var fullBins = [];

            for (int i = 0; i < snapshot.data!.bins!.length; i++){

              double totalWeight = snapshot.data!.bins![i].bin!.status!.weight!.blue!+ snapshot.data!.bins![i].bin!.status!.weight!.red! +snapshot.data!.bins![i].bin!.status!.weight!.other!;

              if(totalWeight>= Ints.weightFull){
                fullBins.add(snapshot.data!.bins![i]);
              }
             fullBins.add(snapshot.data!.bins![i]);

            }
 /*           snapshot.data!.bins![1].institution!.name = "Ethio Telecom";
            snapshot.data!.bins![2].institution!.name = "Orange Digital";
            snapshot.data!.bins![3].institution!.name = "Noah Real Estate";
            snapshot.data!.bins![4].institution!.name = "Awash Bank";
            snapshot.data!.bins![5].institution!.name = "Orange Digital";
            snapshot.data!.bins![6].institution!.name = "Coca-Coala bottling company";
            snapshot.data!.bins![7].institution!.name = "Ethio Telecom";
            snapshot.data!.bins![8].institution!.name = "Nib Bank";

            fullBins.add(snapshot.data!.bins![2]);
            fullBins.add(snapshot.data!.bins![3]);
            fullBins.add(snapshot.data!.bins![4]);
            fullBins.add(snapshot.data!.bins![5]);
            fullBins.add(snapshot.data!.bins![6]);
            fullBins.add(snapshot.data!.bins![7]);
            fullBins.add(snapshot.data!.bins![8]);
*/
            return RefreshIndicator(
              
              onRefresh: _refresh,
              color: Colors.teal,
              child: ListView.builder( itemCount: fullBins.length, itemBuilder: (context, index) {

                print(snapshot.data);
                print(snapshot.data);

                return InkWell(
                  onTap: (){
                    //Get.to(()=> GoogleMapScreen());
                    Get.to(()=> TaskLocation(), arguments:[fullBins[index].institution!.name ?? "",fullBins[index].bin!.location!.long,fullBins[index].bin!.location!.lat, fullBins[index].bin!.id,fullBins[index]]);
                  },

                  child: Container(

                    padding: EdgeInsets.all(13),
                    constraints: BoxConstraints(
                      minHeight: 130,
                    ),
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      //color: Colors.teal[400],
                      color: cardColor,
                        /*
                        gradient: LinearGradient(
                            colors: [
                              const Color(0xFF399E91),
                              const Color(0xFF40CFBC),
                            ],
                            begin: const FractionalOffset(0.0, 1.0),
                            end: const FractionalOffset(0.0, 0.0),
                            stops: [0.0, 1.0],
                            tileMode: TileMode.clamp),*/
                        borderRadius: BorderRadius.all(
                            Radius.circular(15)
                        )
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Row(
                          children: [
                            Text('Date assigned: ',style: TextStyle(),),
                            Text(
                              fullBins[index].bin!.updatedDate!.day.toString()+"/"+fullBins[index].bin!.updatedDate!.month.toString()+"/"+fullBins[index].bin!.updatedDate!.year.toString(),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Text(
                              fullBins[index].institution!.name ?? "",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold, ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),

                      /*  Row(
                          children: [

                            Text(
                              //"Loading location...",
                               getAddress( fullBins[index].bin!.location!.lat, fullBins[index].bin!.location!.long),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(),
                            ),
                          ],
                        ),*/

                                   Align(
                                       alignment: Alignment.centerLeft,
                                     child: SingleChildScrollView(
                                       scrollDirection: Axis.horizontal,
                                       child: Row(
                          children: [


                         FutureBuilder(
                                  future: getAddress( fullBins[index].bin!.location!.lat, fullBins[index].bin!.location!.long),
                                  initialData: "Loading location..",
                                  builder: (BuildContext context, AsyncSnapshot<String> text) {
                                        return Text(
                                              text.data ?? "Couldn't load location",
                                              overflow: TextOverflow.ellipsis,
                                            );
                                  })

                          ]
                                       ),
                                     ),
                                   )

                        /*
                          Row(
                            children: [

                              FutureBuilder(
                                  future: GetAddressFromLatLong(snapshot.data!.bins![index].bin!.location!.lat,snapshot.data!.bins![index].bin!.location!.long),
                                  initialData: "Loading location..",
                                  builder: (BuildContext context, AsyncSnapshot<String> text) {
                                    return Text(
                                          text.data ?? "Location",
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(color: Colors.white),
                                        );
                                  })
                            ],
                          ),*/
                      ],
                    ),
                  ),
                );


                /*Contaier(


                  height: 130,
                  margin: const EdgeInsets.all(8),
                  child: GestureDetector(
                    onTap: (){
                      //Get.to(()=> GoogleMapScreen());
                      Get.to(()=> TaskLocation(), arguments:[snapshot.data!.bins![index].institution!.name ?? "",snapshot.data!.bins![index].bin!.location!.long,snapshot.data!.bins![index].bin!.location!.lat, snapshot.data!.bins![index].bin!.id],);
                    },
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

                );*/
              }),
            );

          }
        }else{
          return Center(
              child: CircularProgressIndicator(
                color: Colors.tealAccent[700],
              ));
        }

      },
    );


  }


  Future<void> _refresh() async {

   

    setState(() {
 
    }); 
  }

  Future<String> getAddress(var lat, var long)async{
   
      final coordinates = new Coordinates(lat,long);
      var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
      var first = addresses.first; 
      
      print("${first.featureName} : ${first.addressLine}");
      print(first.addressLine);  

      return first.addressLine;
  }
}
