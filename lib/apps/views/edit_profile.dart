import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_rest_api_image_upload/controllers/profileController.dart';

import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:talu_bin_driver/apps/controllers/profile_controller.dart';
import 'package:talu_bin_driver/apps/services/api_services.dart';
import 'package:talu_bin_driver/apps/utils/widget/loading_button.dart';

import 'package:image_picker/image_picker.dart';

class AddProfileScreen extends StatefulWidget {
  @override
  _AddProfileScreenState createState() => _AddProfileScreenState();
}

class _AddProfileScreenState extends State<AddProfileScreen> {
  // final profileController = Get.put(ProfileController());

  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController firstNameController = new TextEditingController();
  TextEditingController lastNameController = new TextEditingController();
  TextEditingController dobController = new TextEditingController();
  XFile? pickedFile;

  APIService apiService = APIService();

  final formKey = GlobalKey<FormState>();

  void selectImage(ImageSource imageSource) async {
    try {
      pickedFile = await ImagePicker().pickImage(source: imageSource);
    } finally {
      if (Get.isBottomSheetOpen ?? true) Get.back();
      // update();
    }
  }

  void clearController() {
    emailController.clear();
    passwordController.clear();
    firstNameController.clear();
    lastNameController.clear();
    dobController.clear();
    pickedFile = null;
    // update();
  }

  @override
  void initState() {
    // TODO: implement initState
    clearController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Profile'),
        backgroundColor: Colors.tealAccent[700],
      ),
      body: Container(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Form(
              key: formKey,
              autovalidateMode: AutovalidateMode.disabled,
              child: Column(
                children: [
                     SizedBox(
                        height: 115,
                        width: 115,
                        child: Stack(
                          clipBehavior: Clip.none,
                          fit: StackFit.expand,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              backgroundImage: pickedFile != null
                                  ? FileImage(
                                      File(pickedFile!.path),
                                      // height: 300.0,
                                      // fit: BoxFit.scaleDown,
                                    )
                                  : AssetImage('assets/login_profile.png')
                                      as ImageProvider,
                            ),
                            Positioned(
                              right: -16,
                              bottom: 0,
                              child: SizedBox(
                                height: 46,
                                width: 46,
                                child: FlatButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                    side: BorderSide(color: Colors.white),
                                  ),
                                  color: Colors.grey[200],
                                  onPressed: () {
                                    // Get.bottomSheet(
                                    //   Container(
                                    //     decoration: BoxDecoration(
                                    //       color: Colors.white,
                                    //       borderRadius: const BorderRadius.only(
                                    //           topLeft: Radius.circular(16.0),
                                    //           topRight: Radius.circular(16.0)),
                                    //     ),
                                    //     child: Wrap(
                                    //       alignment: WrapAlignment.end,
                                    //       crossAxisAlignment:
                                    //           WrapCrossAlignment.end,
                                    //       children: [
                                    //         ListTile(
                                    //           leading: Icon(Icons.camera),
                                    //           title: Text('Camera'),
                                    //           onTap: () {
                                    //             profileController.selectImage(
                                    //                 ImageSource.camera);
                                    //           },
                                    //         ),
                                    //         ListTile(
                                    //           leading: Icon(Icons.image),
                                    //           title: Text('Gallery'),
                                    //           onTap: () {
                                    //             profileController.selectImage(
                                    //                 ImageSource.gallery);
                                    //           },
                                    //         ),
                                    //       ],
                                    //     ),
                                    //   ),
                                    // );
                                  },
                                  child: SvgPicture.asset(
                                      "assets/icons/Camera Icon.svg"),
                                ),
                              ),
                            ),
                            Positioned(
                              right: -17,
                              bottom: -3,
                              child: IconButton(
                                icon: Icon(
                                  Icons.camera_alt,
                                  color: Colors.tealAccent[700],
                                ),
                                onPressed: () {
                                  Get.bottomSheet(
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(16.0),
                                            topRight: Radius.circular(16.0)),
                                      ),
                                      child: Wrap(
                                        alignment: WrapAlignment.end,
                                        crossAxisAlignment:
                                            WrapCrossAlignment.end,
                                        children: [
                                          ListTile(
                                            leading: Icon(Icons.camera),
                                            title: Text('Camera'),
                                            onTap: () {
                                              selectImage(ImageSource.camera);
                                            },
                                          ),
                                          ListTile(
                                            leading: Icon(Icons.image),
                                            title: Text('Gallery'),
                                            onTap: () {
                                              selectImage(ImageSource.gallery);
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                  // GetBuilder<ProfileController>(
                  //   builder: (_c) => Container(
                      
                  //   ),
                  //////////////////////////
                  SizedBox(height: 40),
                  TextFormField(
                    keyboardType: TextInputType.name,
                    cursorColor: Colors.tealAccent[700],
                    controller: emailController,
                    onEditingComplete: () => node.nextFocus(),
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'Enter your email address';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: "Email address",
                      focusColor: Colors.tealAccent[700],
                      fillColor: Colors.tealAccent[700],
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    keyboardType: TextInputType.name,
                    cursorColor: Colors.tealAccent[700],
                    controller: passwordController,
                    onEditingComplete: () => node.nextFocus(),
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'Enter your password';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: "Password",
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    keyboardType: TextInputType.name,
                    cursorColor: Colors.tealAccent[700],
                    controller: firstNameController,
                    onEditingComplete: () => node.nextFocus(),
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'Enter your first name';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: "First name",
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    keyboardType: TextInputType.name,
                    cursorColor: Colors.tealAccent[700],
                    controller: lastNameController,
                    onEditingComplete: () => node.nextFocus(),
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'Enter your last name';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: "Last name",
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    keyboardType: TextInputType.streetAddress,
                    cursorColor: Colors.tealAccent[700],
                    controller: dobController,
                    onEditingComplete: () => node.nextFocus(),
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'Enter your Date of birth';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: "Date of Birth",
                    ),
                  ),
                  SizedBox(height: 30),
                  Container(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () async {
                                // Get.to(() => HomeScreen());
                                if (emailController.text.isNotEmpty &&
                                    passwordController.text.isNotEmpty&& firstNameController.text.isNotEmpty && 
                                    lastNameController.text.isNotEmpty&& dobController.text.isNotEmpty
                                    ) {
                                  await apiService
                                  .updateProfile(email: emailController.text, password: passwordController.text, firstName: firstNameController.text, lastName: lastNameController.text, dob: dobController.text)
                                      .then((value) => print(value))
                                      .catchError((onError) {
                                    print(onError);
                                  });
                                } else {
                                  Get.snackbar(
                                    "Error",
                                    "Please Enter all fields",
                                    snackPosition: SnackPosition.BOTTOM,
                                  );

                                  print('blank field is not allowed');
                                }
                              },
                              child: Text(
                                'Update Profile',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16.0),
                              ),
                              // color: Colors.tealAccent[700],
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.tealAccent[700]),
                                padding: MaterialStateProperty.all(
                                  EdgeInsets.symmetric(vertical: 16.0),
                                ),
                              ),

                            ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
