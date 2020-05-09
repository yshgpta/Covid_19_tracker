import 'package:covid_19/home_screen.dart';
import 'package:flutter/material.dart';

import './home_screen.dart';

class IntroPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _IntroPageState();
  }
}

class _IntroPageState extends State<IntroPage> {
  @override
  Widget build(BuildContext context) {
    final wth = MediaQuery.of(context).size.width;
    // TODO: implement build
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0XFFD50000),
            Color(0xFFFF80AB),
          ],
        )),
        child: Stack(
          children: <Widget>[
            _buildHeader(context),
            Container(
              child: Center(
                child: Image.asset(
                  "assets/images/virus1.png",
                ),
              ),
            ),

            _buildFooter(context),
          ],
        ),
      ),
    );
  }
}

Widget _buildHeader(BuildContext context) {
  final wth = MediaQuery.of(context).size.width;
  return Padding(
    padding: EdgeInsets.only(top: 50),
    child: Align(
      alignment: Alignment.topCenter,
      child: Image.asset("assets/images/logo.png", width: wth - 100),
    ),
  );
}

Widget _buildFooter(BuildContext context) {
  final wth = MediaQuery.of(context).size.width;
  void printval() {
    print("Hello");
  }

  return Positioned(
    bottom: 50,
    child: Container(
      width: wth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            "Coronavirus disease (COVID-19)",
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
          Text(
            "Designed and Developed by",
            style: TextStyle(
              fontSize: 14,
              color: Colors.white,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            "Yash Gupta",
            style: TextStyle(
              fontSize: 14,
              color: Colors.white,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 10,
          ),
          ButtonTheme(
            minWidth: wth - 150,
            height: 40,
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                side: BorderSide(color: Colors.redAccent),
              ),
              color: Colors.white,
              child: Text(
                "GET STARTED",
                style: TextStyle(
                  color: Colors.redAccent,
                ),
              ),
              onPressed: (){
                Navigator.pushReplacement(
                  context,MaterialPageRoute(builder: (context) => HomeScreen())
                );
              },
            ),
          )
        ],
      ),
    ),
  );
}
