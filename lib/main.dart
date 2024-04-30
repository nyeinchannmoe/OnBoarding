import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const OnBoardingScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  TextEditingController textEditingController = TextEditingController();

  StreamController<ErrorAnimationType>? errorController;

  bool hasError = false;
  String currentText = "";
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width =MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xFFF2F3F8),
      body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Stack(
            children: [
              Image.asset('assets/image 9.png'),
              Positioned(
                bottom: 30,
                left: 30,
                child: Image.asset('assets/Fome-Ai_Outline 1.png'))
            ],
          ),
         const  Padding(
            padding: EdgeInsets.fromLTRB(8, 50, 8, 30),
            child: Text('Please enter your confirmation code from the authentication app you have set up MFA with to continue',
            style: TextStyle(fontSize: 14,
            color: Color(0xFF10203D),
            fontWeight: FontWeight.w400),
            textAlign: TextAlign.center,),
          ),
          Padding(padding: const EdgeInsets.fromLTRB(10, 0, 10, 30),
          child: PinCodeTextField(
            appContext: context,
        length: 5,
        obscureText: true,
        animationType: AnimationType.fade,
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          
          borderRadius: BorderRadius.circular(5),
          inactiveFillColor: const Color(0xFFFFFFFF),
          inactiveColor:  Colors.white,
          fieldHeight: 57,
          fieldWidth: 57,
          activeFillColor: Colors.white,
        ),
        animationDuration:const Duration(milliseconds: 300),
        backgroundColor:null,
        enableActiveFill: true,
        errorAnimationController: errorController,
        controller: textEditingController,
        onCompleted: (v) {
        },
        onChanged: (value) {
          setState(() {
            currentText = value;
          });
        },
        beforeTextPaste: (text) {
          //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
          //but you can show anything you want here, like your pop up saying wrong paste format or etc
          return true;
        },
      ),),
      InkWell(
              onTap: (){},
              child: Container(
                margin: const EdgeInsets.only(bottom: 48),
                height: height * 0.075,
                width: width - 30,
                decoration: BoxDecoration(
                  color:const Color(0xFF4A7AD1),
                  borderRadius: BorderRadius.circular(3),
                ),
                child: const Center(
                  child: Text(
                    "Log in",
                    style: TextStyle(
                      fontFamily: "HappyMonkey",
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: height * 0.2),
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Powered By '),
                    Image.asset('assets/Fome-Ai_Outline 1.png',
                    height: 17,
                    width: 53,)
                  ],
                ),
            ),
        ],
      ),
            ),
    );
  }
}

// OnBoarding content Model
class OnBoard {
  final String image, title, description;

  OnBoard({
    required this.image,
    required this.title,
    required this.description,
  });
}

// OnBoarding content list
final List<OnBoard> demoData = [
  OnBoard(
    image: "assets/1.png",
    title: "Title 01",
    description:
        "Welcome to FOME.ai the Australian tech business using computer vision technology in the sports industry",
  ),
  OnBoard(
    image: "assets/2.png",
    title: "Title 02",
    description:
        "Mobile app used by participants to record themselves doing exercises",
  ),
  OnBoard(
    image: "assets/3.png",
    title: "Title 03",
    description:
        "These videos will be analyzed by FOME’s computer vision engine and the results will be returned to the Participant",
  ),
];

// OnBoardingScreen
class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  late PageController _pageController;
  int _pageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: PageView.builder(
              physics: const NeverScrollableScrollPhysics(),
              // onPageChanged: (index) {
              //   setState(() {
              //     _pageIndex = index;
              //   });
              // },
              itemCount: demoData.length,
              controller: _pageController,
              itemBuilder: (context, index) => OnBoardContent(
          title: demoData[index].title,
          description: demoData[index].description,
          image: demoData[index].image,
          currenIndex: _pageIndex,
          nextAction: () {
            setState(() {
              _pageIndex++;
              _pageController.animateToPage(
                _pageIndex,
                duration: const Duration(milliseconds: 350),
                curve: Curves.easeIn,
              );
              if (_pageIndex > 2) {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const MyHomePage(
                          title: 'Password Code',
                        )));
              }
            });
          },
        ),
            ),
    );
  }
}

// OnBoarding area widget
class OnBoardContent extends StatelessWidget {
  const OnBoardContent({
    super.key,
    required this.image,
    required this.title,
    required this.description,
    required this.nextAction,
    required this.currenIndex,
  });

  final VoidCallback nextAction;
  final String image;
  final String title;
  final String description;
  final int currenIndex;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        // color: ,
          image: DecorationImage(
              fit: BoxFit.contain,
              opacity: 0.75,
              colorFilter: const ColorFilter.mode(Colors.black45, BlendMode.colorDodge),
              filterQuality: FilterQuality.low,
              image: AssetImage(image))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: height * 0.07,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Image.asset('assets/Fome-Ai_Outline 1.png'),
              ),
              SizedBox(
                height: height * 0.3,
              ),
              Text(
                description,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: nextAction,
                child: Container(
                  margin: const EdgeInsets.only(bottom: 48),
                  height: height * 0.075,
                  width: width - 30,
                  decoration: BoxDecoration(
                    color:const Color(0xFF4A7AD1),
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: const Center(
                    child: Text(
                      "Next",
                      style: TextStyle(
                        fontFamily: "HappyMonkey",
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
              // White space
              const SizedBox(
                height: 16,
              ),

              // Indicator area
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ...List.generate(
                      demoData.length,
                      (index) => Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: DotIndicator(
                          isActive: index == currenIndex,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

// Dot indicator widget
class DotIndicator extends StatelessWidget {
  const DotIndicator({
    this.isActive = false,
    super.key,
  });

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 8,
      width: isActive ? 8 : 8,//24
      decoration: BoxDecoration(
        color: isActive ? Colors.blue : Colors.white,
        border: isActive ? null : Border.all(color: Colors.blue),
        borderRadius: const BorderRadius.all(
          Radius.circular(12),
        ),
      ),
    );
  }
}