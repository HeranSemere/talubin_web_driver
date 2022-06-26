import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talu_bin_driver/apps/views/login_screen.dart';

class Onboarding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'avenir'),
      home: onboarding(),
    );
  }
}

class onboarding extends StatefulWidget {
  @override
  _onboardingState createState() => _onboardingState();
}

class _onboardingState extends State<onboarding> {
  int currentPage = 0;
  PageController _pageController =
      new PageController(initialPage: 0, keepPage: true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.6,
                child: PageView(
                  controller: _pageController,
                  children: [
                    onBoardPage("recycle_onboard", "Welcome to TaluBin"),
                    onBoardPage("zero_plastic_onboard", "Zero Plastic Waste"),
                    onBoardPage("clean_world_onboard", "Clean World"),
                  ],
                  onPageChanged: (value) => {setCurrentPage(value)},
                ),
              ),
              SizedBox(height: 1),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(3, (index) => getIndicator(index)),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              margin: EdgeInsets.only(top: 20),
              height: 300,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/path3.png'), fit: BoxFit.fill)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: openLoginPage,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 100),
                      decoration:
                          BoxDecoration(color: Colors.white, boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            offset: Offset(0, 9),
                            blurRadius: 20,
                            spreadRadius: 3)
                      ]),
                      child: Text(
                        "Get Started",
                        style: TextStyle(
                            fontSize: 16, color: Colors.tealAccent[800]),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  // Text(
                  //   "Login",
                  //   style: TextStyle(
                  //       color: Colors.white,
                  //       fontSize: 18,
                  //       fontWeight: FontWeight.bold),
                  // )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  AnimatedContainer getIndicator(int pageNo) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 100),
      height: 10,
      width: (currentPage == pageNo) ? 20 : 10,
      margin: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: (currentPage == pageNo) ? Colors.black : Colors.grey),
    );
  }

  Column onBoardPage(String img, String title) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 20,
        ),
        Container(
          height: 200,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(50),
          decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage('assets/$img.png'))),
        ),
        SizedBox(
          height: 30,
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Text(
            title,
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
          child: Text(
            "Lorem ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text",
            style: TextStyle(fontSize: 16, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  setCurrentPage(int value) {
    currentPage = value;
    setState(() {});
  }

  openLoginPage() {
    Get.offAll(() => Login());
  }
}

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:introduction_screen/introduction_screen.dart';

// import 'login_screen.dart';

// class IntroScreen extends StatefulWidget {
//   const IntroScreen({Key? key}) : super(key: key);

//   @override
//   _IntroScreenState createState() => _IntroScreenState();
// }

// class _IntroScreenState extends State<IntroScreen> {
//   final pageDecoration = PageDecoration(
//     titleTextStyle:
//         PageDecoration().titleTextStyle.copyWith(color: Colors.white),
//     bodyTextStyle: PageDecoration().bodyTextStyle.copyWith(color: Colors.white),
//     footerPadding: const EdgeInsets.all(10),
//   );

//   List<PageViewModel> getPages() {
//     return [
//       PageViewModel(
//           image: Image.asset("assets/zero_plastic_onboard.png"),
//           title: "ZERO PLASTIC",
//           body: "This is an online ad.",
//           footer: Text(
//             "MTECHVIRAL",
//             style: TextStyle(color: Colors.white),
//           ),
//           decoration: pageDecoration),
//       PageViewModel(
//           image: Image.asset("assets/recycle_onboard.png"),
//           title: "RECYCLE",
//           body: "This is an online ad.",
//           footer: Text(
//             "MTECHVIRAL",
//             style: TextStyle(color: Colors.white),
//           ),
//           decoration: pageDecoration),
//       PageViewModel(
//           image: Image.asset("assets/clean_world_onboard.png"),
//           title: "CLEAN WORLD",
//           body: "This is an online ad.",
//           footer: Text(
//             "MTECHVIRAL",
//             style: TextStyle(color: Colors.white),
//           ),
//           decoration: pageDecoration),
//     ];
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: IntroductionScreen(
//         globalBackgroundColor: Colors.tealAccent[700],
//         skip: Text(
//           "SKIP",
//           style: TextStyle(color: Colors.white),
//         ),
//         showSkipButton: true,
//         pages: getPages(),
//         done: Text(
//           "Done",
//           style: TextStyle(color: Colors.white),
//         ),
//         showNextButton: true,
//         next: const Icon(Icons.arrow_forward),
//         color: Colors.white,
//         onDone: () {
//           Get.to(() => Login());
//         },
//         dotsDecorator: DotsDecorator(
//           //delete const if want to change active color
//           // activeColor: Color(0xFFBA68C8),
//           activeColor: Colors.white,
//           size: Size(10.0, 10.0),
//           color: Color(0xFFBDBDBD),
//           activeSize: Size(22.0, 10.0),
//           activeShape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.all(Radius.circular(25.0)),
//           ),
//         ),
//       ),
//     );
//   }
// }
