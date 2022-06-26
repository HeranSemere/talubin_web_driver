import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:talu_bin_driver/apps/models/talu_bin_info.dart';
import 'package:talu_bin_driver/apps/services/api_services.dart';
// import 'package:talu_bin_driver/apps/models/talu_bin_info.dart';
// import 'package:talu_bin_driver/apps/services/api_services.dart';

class GoogleMapScreen extends StatefulWidget {
  const GoogleMapScreen({Key? key}) : super(key: key);

  @override
  _GoogleMapScreenState createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  // Set<Marker> _markers = {};

  // static const LatLng _kMapCenter = LatLng(9.024666568, 38.737330384);
  // BitmapDescriptor? _markerIcon;
  GoogleMapController? controller;

  static const _initialCameraPosition = CameraPosition(
    target: LatLng(9.024666568, 38.737330384),
    zoom: 12.0,
  );

  // List<Marker> _markers = <Marker>[];

  Completer<GoogleMapController> _controller = Completer();

  @override
  void initState() {
    // TODO: implement initState
    // intialize();
    super.initState();
    // setCustomMarker();
  }

  // Set<Marker> _createMarker() {
  //   if (_markerIcon != null) {
  //     return {
  //       firstMarker,
  //       secondeMarker,
  //       thiredMarker,
  //     };
  //   } else {
  //     return {
  //       Marker(
  //         markerId: MarkerId('TaluBin02'),
  //         position: _kMapCenter,
  //         infoWindow: InfoWindow(title: "Orange Digital Center"),
  //         icon:
  //             BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
  //       )
  //     };
  //   }
  // }

  // void intialize()
  //   Marker firstMarker = Marker(
  //       markerId: MarkerId('TaluBin01'),
  //       position: LatLng(9.732128, 37.737330384),
  //       infoWindow: InfoWindow(title: "Orange Digital Center"),
  //       icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),);
  //
  //   Marker secondeMarker = Marker(
  //       markerId: MarkerId('TaluBin01'),
  //       position: LatLng(9.732128, 37.737330384),
  //       infoWindow: InfoWindow(title: "Orange Digital Center"),
  //       icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen));
  //
  //   Marker thiredMarker = Marker(
  //       markerId: MarkerId('TaluBin01'),
  //       position: LatLng(9.732128, 37.737330384),
  //       infoWindow: InfoWindow(title: "Orange Digital Center"),
  //       icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen));
  //
  //   Marker fourthMarker = Marker(
  //       markerId: MarkerId('TaluBin01'),
  //       position: LatLng(9.732128, 37.737330384),
  //       infoWindow: InfoWindow(title: "Orange Digital Center"),
  //       icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen));
  //
  //   markers.add(firstMarker);
  //   markers.add(secondeMarker);
  //   markers.add(thiredMarker);
  //   markers.add(fourthMarker);
  //
  //   setState(() {});
  // }

  /////////////////////////////////////////

  // void setCustomMarker() async {
  //   customMarkerIcon = await BitmapDescriptor.fromAssetImage(
  //     ImageConfiguration(),
  //     'assets/smart_bin_marker.png',
  //   );
  // }

  // void _onMapCreated(GoogleMapController controller) {
  //   // controller.setMapStyle(Utils.mapStyle); // this is change the map style
  //   setState(() {
  //     _markers.add(Marker(
  //         markerId: MarkerId('id-1'),
  //         position: LatLng(9.024666568, 38.737330384),
  //         icon: customMarkerIcon,
  //         infoWindow: InfoWindow(
  //             title: 'Orange Digital Center',
  //             snippet: 'Smart Trash Bin Location')));
  //   });
  // }

  /////////////////////////////////

  @override
  Widget build(BuildContext context) {
    // LatLng? latLng;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.tealAccent[700],
        title: Text('Google Map'),
      ),
      body: Stack(
        children: [
          FutureBuilder<TaluBinInfo>(
            future: APIService().getTaluBinInfo(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child: CircularProgressIndicator(
                  color: Colors.tealAccent[700],
                ));
              } else if (snapshot.hasError) {
                return Text('error');
              } else {
                print(snapshot.data!.bins![0].bin.runtimeType);
                var finalData = snapshot.data;
                return Container(
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: finalData!.bins!.length,
                            itemBuilder: (context, index) {
                              double? lat =
                                  finalData.bins![index].bin!.location!.lat ??
                                      8.99;
                              double? lng =
                                  finalData.bins![index].bin!.location!.long ??
                                      8.99;
                              return Container(
                                height: MediaQuery.of(context).size.height,
                                child: GoogleMap(
                                  myLocationButtonEnabled: true,
                                  zoomControlsEnabled: true,
                                  initialCameraPosition: _initialCameraPosition,
                                  mapType: MapType.normal,
                                  markers: {
                                    addisAbaba1Marker,
                                    addisAbaba1Marker,
                                    firstMarker,
                                    secondeMarker,
                                    thiredMarker,
                                    // Marker(
                                    //   markerId: MarkerId(index.toString()),
                                    //   position: LatLng(lat == null ? 9.024666568 : lat, lng == null ? 38.737330384 : lat),
                                    // )
                                  },
                                  onMapCreated:
                                      (GoogleMapController controller) {
                                    _controller.complete(controller);
                                  },
                                ),
                              );
                            }),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
          DraggableScrollableSheet(builder: (context, controller) {
            
            return Container(
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
                  onTap: (){
                    Get.to(()=> GoogleMapScreen());
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
            );
          }),
        ],
      ),
    );
  }

  // List<Marker> allMarkers = [];
  // late TaluBinInfo talbinInfo;
  // loadMarkers() async {
  //
  //   talbinInfo = await APIService().getTaluBinInfo();
  //   allMarkers.add(
  //     Marker(markerId: MarkerId('newyork5'),
  //     position: LatLng(talbinInfo.bins[index].bin!.location.long, taluBin),
  //   )
  // }
  Marker addisAbaba1Marker = Marker(
      markerId: MarkerId('newyork1'),
      position: LatLng(9.024666568, 38.737330384),
      infoWindow: InfoWindow(title: 'Los Tacos'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen));

  Marker addisAbaba2Marker = Marker(
      markerId: MarkerId('newyork2'),
      position: LatLng(9.054666568, 38.699330384),
      infoWindow: InfoWindow(title: 'Los Tacos'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen));

  Marker firstMarker = Marker(
      markerId: MarkerId('TaluBin1'),
      position: LatLng(9.024666568, 38.757330384),
      infoWindow: InfoWindow(title: "Orange Digital Center"),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen));

  Marker secondeMarker = Marker(
      markerId: MarkerId('TaluBin2'),
      position: LatLng(9.024666568, 38.687330384),
      infoWindow: InfoWindow(title: "Orange Digital Center"),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen));

  Marker thiredMarker = Marker(
      markerId: MarkerId('TaluBin3'),
      position: LatLng(9.024666568, 38.777330384),
      infoWindow: InfoWindow(title: "Orange Digital Center"),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen));
}

//
