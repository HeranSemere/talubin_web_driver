import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:talu_bin_driver/apps/models/profile_page.dart';
import 'package:talu_bin_driver/apps/services/api_services.dart';
import 'package:talu_bin_driver/apps/views/edit_profile.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey.shade300,
        appBar: AppBar(
          backgroundColor: Colors.tealAccent[700],
          elevation: 1,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.edit,
                color: Colors.white,
              ),
              onPressed: () {
                Get.to(() => AddProfileScreen());
              },
            ),
          ],
          title: Text("Profile", style: TextStyle(color:  Colors.white),),
        ),
        body: FutureBuilder<ProfilePage>(
            future: APIService().getProfile(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                // print("snapshot: ${snapshot.data!.user}");
                // print(snapshot.data.runtimeType);
                return SingleChildScrollView(
                  child: Stack(
                    children: <Widget>[
                      SizedBox(
                        height: 250,
                        width: double.infinity,
                        child: Image(
                          image: AssetImage(
                            "assets/login_profile.png",
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(15, 200, 15, 15),
                        child: Column(
                          children: <Widget>[
                            Stack(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(15),
                                  margin: EdgeInsets.only(top: 15),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.only(left: 95),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              "${snapshot.data!.user!.firstName!.toUpperCase()} ${snapshot.data!.user!.lastName!.toUpperCase()}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline6,
                                            ),
                                            ListTile(
                                              contentPadding: EdgeInsets.all(0),
                                              title: Text(
                                                  "Position: ${snapshot.data!.user!.role}"),
                                              //You can add Subtitle here
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: Column(
                                              children: <Widget>[
                                                Text("40"),
                                                Text("Visited Institution"),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Column(
                                              children: <Widget>[
                                                Text("800"),
                                                Text("Collected Bins"),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Column(
                                              children: <Widget>[
                                                Text("8"),
                                                Text("Rating"),
                                              ],
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 80,
                                  height: 80,
                                  margin: EdgeInsets.only(left: 15),
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        offset: Offset(0, 0),
                                        blurRadius: 10,
                                        color: Colors.black.withOpacity(0.15),
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      image: AssetImage(
                                        "assets/login_profile.png",
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Column(
                                children: <Widget>[
                                  ListTile(
                                    title: Text("Driver Information"),
                                  ),
                                  Divider(),
                                  ListTile(
                                    title: Text("Email"),
                                    subtitle: Text("${snapshot.data!.user!.email}"),
                                    leading: Icon(
                                      Icons.email,
                                      color: Colors.tealAccent[700],
                                    ),
                                  ),
                                  ListTile(
                                    title: Text("Address"),
                                    subtitle: Text("${snapshot.data!.user!.address}"),
                                    leading: Icon(LineIcons.mapMarked,
                                        color: Colors.tealAccent[700]),
                                  ),
                                  ListTile(
                                    title: Text("About"),
                                    subtitle: Text(
                                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Bibendum at varius vel pharetra."),
                                    leading: Icon(Icons.format_align_center,
                                        color: Colors.tealAccent[700]),
                                  ),
                                  ListTile(
                                    title: Text("Joined Date"),
                                    subtitle: Text("${snapshot.data!.user!.createdDate}"),
                                    leading: Icon(Icons.calendar_view_day,
                                        color: Colors.tealAccent[700]),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              } else {
                return Center(
                    child: CircularProgressIndicator(
                  color: Colors.tealAccent[700],
                ));
              }
            }),
      ),
    );
  }
}
