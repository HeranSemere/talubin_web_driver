import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talu_bin_driver/apps/views/forget_password_2.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    // var height = MediaQuery.of(context).size.height;
    // var width = MediaQuery.of(context).size.width;
    return Container(
        decoration: BoxDecoration(
            gradient: new LinearGradient(colors: [
          Color(0xff80cbc4),
          Color(0xff4db6ac),
          Color(0xff009688),
          Color(0xff077968),
        ], begin: Alignment.topLeft, end: Alignment.centerRight)),
        child: Scaffold(
          appBar: AppBar(
            elevation: 1,
            backgroundColor: Colors.white,
            title: Text(
              "Change Your Password",
              style: TextStyle(color: Colors.tealAccent[700]),
            ),
          ),
          // backgroundColor: Colors.transparent,
          body: Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Password Reset",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.tealAccent[700]),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Please enter your email below",
                  style: TextStyle(
                      fontSize: 16, height: 1.5, color: Colors.grey.shade600),
                ),
                SizedBox(
                  height: 30,
                ),
                TextField(
                  // onChanged: (password) => onPasswordChanged(password),
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.email,
                        color: Color(0xff00bfa5),
                      ),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Color(0xff00bfa5))),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Color(0xff00bfa5))),
                    hintText: "Email",
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                MaterialButton(
                  height: 40,
                  minWidth: double.infinity,
                  onPressed: () {
                    Get.to(() => ForgetPasswordReset());
                  },
                  color: Colors.tealAccent[700],
                  child: Text(
                    "RESET PASSWORD ",
                    style: TextStyle(color: Colors.white),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                )
              ],
              // ),
            ),
          ),
        ));
  }
}
