import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ForgetPasswordReset extends StatefulWidget {
  const ForgetPasswordReset({ Key? key }) : super(key: key);

  @override
  _ForgetPasswordResetState createState() => _ForgetPasswordResetState();
}

class _ForgetPasswordResetState extends State<ForgetPasswordReset> {
   bool _isVisible = false;
  bool _isPasswordEightCharacters = false;
  bool _hasPasswordOneNumber = false;

  onPasswordChanged(String password) {
    final numericRegex = RegExp(r'[0-9]');

    setState(() {
      _isPasswordEightCharacters = false;
      if(password.length >= 8)
        _isPasswordEightCharacters = true;

      _hasPasswordOneNumber = false;
      if(numericRegex.hasMatch(password))
        _hasPasswordOneNumber = true;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        title: Text("Change Your Password", style: TextStyle(color: Colors.tealAccent[700]),),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Reset Password", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.tealAccent[700]),),
              SizedBox(height: 10,),
              Text("Please create a new secure password",
                style: TextStyle(fontSize: 16, height: 1.5, color: Colors.grey.shade600),),
              SizedBox(height: 30,),
              TextField(
                onChanged: (password) => onPasswordChanged(password),
                obscureText: !_isVisible,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _isVisible = !_isVisible;
                      });
                    },
                    icon: _isVisible ? Icon(Icons.visibility, color: Color(0xff00bfa5),) : 
                      Icon(Icons.visibility_off, color: Colors.grey,),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Color(0xff00bfa5))
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color:Color(0xff00bfa5))
                  ),
                  hintText: "Password",
                  contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                ),
              ),
              SizedBox(height: 15),
              TextField(
                onChanged: (password) => onPasswordChanged(password),
                obscureText: !_isVisible,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _isVisible = !_isVisible;
                      });
                    },
                    icon: _isVisible ? Icon(Icons.visibility, color: Color(0xff00bfa5),) : 
                      Icon(Icons.visibility_off, color: Colors.grey,),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Color(0xff00bfa5))
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color:Color(0xff00bfa5))
                  ),
                  hintText: "Re-Password",
                  contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                ),
              ),
              
              SizedBox(height: 30,),
              Row(
                children: [
                  AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: _isPasswordEightCharacters ?  Colors.green : Colors.transparent,
                      border: _isPasswordEightCharacters ? Border.all(color: Colors.transparent) :
                        Border.all(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(50)
                    ),
                    child: Center(child: Icon(Icons.check, color: Colors.white, size: 15,),),
                  ),
                  SizedBox(width: 10,),
                  Text("Contains at least 8 characters")
                ],
              ),
              SizedBox(height: 10,),
              Row(
                children: [
                  AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: _hasPasswordOneNumber ?  Colors.green : Colors.transparent,
                      border: _hasPasswordOneNumber ? Border.all(color: Colors.transparent) :
                        Border.all(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(50)
                    ),
                    child: Center(child: Icon(Icons.check, color: Colors.white, size: 15,),),
                  ),
                  SizedBox(width: 10,),
                  Text("Contains at least 1 number")
                ],
              ),
              SizedBox(height: 50,),
             MaterialButton(
                    height: 40,
                    minWidth: double.infinity,
                    onPressed: () {
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
          ),
        ),
      ),
      
    );
  }
}