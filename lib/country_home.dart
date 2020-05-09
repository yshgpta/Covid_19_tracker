import 'package:flutter/material.dart';
import 'package:covid_19/constant.dart';
import 'package:covid_19/widgets/my_header.dart';
import 'package:covid_19/widgets/counter.dart';

class CountryHome extends StatefulWidget {
  String countryName;
  List countryData;
  String updateDate;

  CountryHome(this.countryName, this.countryData, this.updateDate);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CountryHomeState();
  }
}

class _CountryHomeState extends State<CountryHome> {
  final controller = ScrollController();
  double offset = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.addListener(onScroll);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  void onScroll() {
    setState(() {
      offset = (controller.hasClients) ? controller.offset : 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: controller,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            MyHeader(
              image: "assets/images/doctor1.png",
              textTop: "Prevention is ",
              textBottom: "Better than cure.",
              offset: offset,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Newest update " + widget.updateDate,
                    style: TextStyle(
                      color: kTextLightColor,
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: <Widget>[
                      Image.network(
                        widget.countryData[7],
                        width: 30,
                      ),
                      SizedBox(width: 5),
                      Text(
                        widget.countryName,
                        style: kTitleTextstyle,
                      ),
                      SizedBox(width: 3),
                      Text(
                        widget.countryData[0],
                        style: TextStyle(
                          fontSize: 14,
                          color: kBodyTextColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  _getRow(
                      "New Confirmed",
                      widget.countryData[1].toString(),
                      "Total Confirmed",
                      widget.countryData[2].toString(),
                      kInfectedColor),
                  SizedBox(height: 20),
                  _getRow(
                      "New Deaths",
                      widget.countryData[3].toString(),
                      "Total Deaths",
                      widget.countryData[4].toString(),
                      kDeathColor),
                  SizedBox(height: 20),
                  _getRow(
                      "New Recovered",
                      widget.countryData[5].toString(),
                      "Total Recovered",
                      widget.countryData[6].toString(),
                      kRecovercolor),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _getRow extends StatelessWidget {
  final String title1;
  final String data1;
  final String title2;
  final String data2;
  final Color c;

  _getRow(this.title1, this.data1, this.title2, this.data2, this.c);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Counter(
          color: c,
          number: data1 == null ? "- -" : data1,
          title: title1,
        ),
        Counter(
          color: c,
          number: data2 == null ? "- -" : data2.toString(),
          title: title2,
        ),
      ],
    );
  }
}
