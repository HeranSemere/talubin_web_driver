import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:progress_indicator_button/progress_button.dart';
// import 'package:talu_bin_driver/apps/constants/constants.dart';
import 'package:talu_bin_driver/apps/services/api_services.dart';
// import 'home_screen.dart';
import 'forget_password.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  var box = GetStorage();

  // late TextEditingController emailController, passwordController;
  bool isApiCallProcess = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  APIService apiService = APIService();

  var _passwordVisible = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // loginRequestModel = new LoginRequestModel(email: 'fish', password: 'enzc');
  }

  var passwordError = false;
  var emailError = false;


  var passwordErrorText = "Please enter password";
  var emailErrorText = "Please enter email";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height,
              maxWidth: MediaQuery.of(context).size.height,
            ),
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: [
                Color(0xff80cbc4),
                Color(0xff4db6ac),
                Color(0xff009688),
                Color(0xff077968),
              ],
              begin: Alignment.topLeft,
              end: Alignment.centerRight,
            )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 36.0, horizontal: 24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Login',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 46.0,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          'Welcome to Plastic Recycling World',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextFormField(

                            keyboardType: TextInputType.emailAddress,
                            controller: emailController,
                            onChanged: (value){
                              if(value.trim().isNotEmpty){
                                setState(() {
                                  emailError = false;
                                });
                              }
                            },
                            validator: (input) => !input!.contains('@')
                                ? "Email Id should be valid"
                                : null,
                            decoration: InputDecoration(
                              errorText: emailError? emailErrorText : null,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                    color: Color(0xff26a69a), width: 2.5),
                              ),
                              filled: true,
                              fillColor: Color(0xffe7edeb),
                              hintText: 'E-mail',
                              focusColor: Colors.tealAccent[700],
                              prefixIcon: Icon(
                                Icons.email,
                                color: Colors.tealAccent[700],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: !_passwordVisible,
                            controller: passwordController,
                            onChanged: (value){
                              if(value.isNotEmpty){
                                setState(() {
                                  passwordError = false;
                                });
                              }
                            },
                            validator: (input) => input!.length < 6 ? "Password should be more than 6 characters" : null,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: Icon(
                                  // Based on passwordVisible state choose the icon
                                  _passwordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Theme.of(context).primaryColorDark,
                                ),
                                onPressed: () {
                                  // Update the state i.e. toogle the state of passwordVisible variable
                                  setState(() {
                                    _passwordVisible = !_passwordVisible;
                                  });
                                },
                              ),
                              errorText: passwordError? passwordErrorText : null,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                    color: Color(0xff26a69a), width: 2.5),
                              ),
                              filled: true,
                              fillColor: Color(0xffe7edeb),
                              hintText: 'Password',
                              focusColor: Colors.tealAccent[700],
                              prefixIcon: Icon(
                                Icons.lock,
                                color: Colors.tealAccent[700],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Get.to(() => ForgotPassword());
                                },
                                child: Text(
                                  'Forgot your password?',
                                  style: TextStyle(
                                      color: Colors.tealAccent[700],
                                      decoration: TextDecoration.underline),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 50.0,
                          ),
                          Container(
                            width: double.infinity,
                            child: ProgressButton(

                              //animationDuration: Duration(milliseconds: 1),
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.tealAccent[700],

                              strokeWidth: 2,
                              child: Text(
                                'Login',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16.0),
                              ),
                              // color: Colors.tealAccent[700],
                              onPressed: (AnimationController controller) async {

                                // Get.to(() => HomeScreen());
                                if (emailController.text.trim().isNotEmpty && passwordController.text.isNotEmpty) {

                                  controller.forward();

                                  var connectivityResult = await (Connectivity().checkConnectivity());

                                  if (connectivityResult == ConnectivityResult.mobile ||connectivityResult == ConnectivityResult.wifi) {

                                    await apiService.login(email: emailController.text, password: passwordController.text).then((value) {

                                      controller.reset();


                                    }).catchError((onError) {

                                      setState(() {

                                        controller.reset();

                                        emailErrorText = "Login incorrect or non-existant";
                                        passwordErrorText = "Login incorrect or non-existant";

                                        emailError = true;
                                        passwordError = true;

                                      });

                                    });

                                  }else{


                                    setState(() {
                                      controller.reset();
                                      passwordError = false;
                                      emailError = false;
                                      Get.snackbar(
                                        "No Connection",
                                        'Check your internet connection',
                                        snackPosition: SnackPosition.BOTTOM,
                                      );
                                    });


                                  }



                                } else {


                                  setState(() {

                                    emailErrorText = "Please enter email";
                                    passwordErrorText = "Please enter password";

                                    if(emailController.text.trim().isEmpty){
                                      emailError = true;
                                    }
                                    if(passwordController.text.isEmpty){
                                      passwordError = true;
                                    }

                                  });

                                  print('blank field is not allowed');
                                }

                              },
                            ),
                          ),

                            /*
                            child: ElevatedButton(
                              onPressed: () async {
                                // Get.to(() => HomeScreen());
                                if (emailController.text.trim().isNotEmpty && passwordController.text.isNotEmpty) {

                                  var connectivityResult = await (Connectivity().checkConnectivity());

                                  if (connectivityResult == ConnectivityResult.mobile ||connectivityResult == ConnectivityResult.wifi) {

                                    await apiService.login(email: emailController.text, password: passwordController.text).then((value) {

                                      print(value);


                                    }).catchError((onError) {

                                      setState(() {

                                        emailErrorText = "Login incorrect or non-existant";
                                        passwordErrorText = "Login incorrect or non-existant";

                                        emailError = true;
                                        passwordError = true;

                                      });

                                    });

                                  } else{

                                    Get.snackbar(
                                      "No Connection",
                                      'Check your internet connection',
                                      snackPosition: SnackPosition.BOTTOM,
                                    );

                                  }



                                } else {


                                  setState(() {

                                    emailErrorText = "Please enter email";
                                    passwordErrorText = "Please enter password";

                                    if(emailController.text.trim().isEmpty){
                                          emailError = true;
                                    }
                                    if(passwordController.text.isEmpty){
                                          passwordError = true;
                                    }

                                  });

                                  print('blank field is not allowed');
                                }
                              },
                              child: Text(
                                'Login',
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
                            ),*/
                          //),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }

  // bool validateAndSave() {
  //   final form = loginFormKey.currentState;
  //   if (form!.validate()) {
  //     form.save();
  //     return true;
  //   }
  //   return false;
  // }
}
