import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:covid_19/constant.dart';
import 'package:covid_19/widgets/counter.dart';
import 'package:covid_19/widgets/my_header.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'widgets/counter.dart';
import 'widgets/my_header.dart';
import './constant.dart';
import './country_home.dart';
import './details.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final controller = ScrollController();
  double offset = 0;
  final String url = "https://api.covid19api.com/summary";
  var data;
  var cdata;

  var clist = List<String>();
  var months = {
    "01": "January",
    "02": "February",
    "03": "March",
    "04": "April",
    "05": "May",
    "06": "June",
    "07": "July",
    "08": "Augest",
    "09": "September",
    "10": "October",
    "11": "November",
    "12": "December"
  };
  String uDate = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getJsonData();
    controller.addListener(onScroll);
  }

  Future<Map<String, List>> getJsonData() async {
    var response = await http.get(url);
    var countryData = Map<String, List>();
    var countryList = List<String>();
    countryList.add("Search countries....");
    String updateDate;
    if (response.statusCode == 200) {
      data = json.decode(response.body);

      data["Date"].toString().substring(0, 10);

      if (data != null) {
        var d = data["Date"].toString();
        var year = d.substring(0, 4);
        var month = months[d.substring(5, 7)];
        var day = d.substring(8, 10);
        updateDate = day + " " + month + " " + year;

        countryData["Global"] = [
          "",
          data["Global"]["NewConfirmed"],
          data["Global"]["TotalConfirmed"],
          data["Global"]["NewDeaths"],
          data["Global"]["TotalDeaths"],
          data["Global"]["NewRecovered"],
          data["Global"]["TotalRecovered"],
          "https://upload.wikimedia.org/wikipedia/commons/thumb/e/ef/International_Flag_of_Planet_Earth.svg/800px-International_Flag_of_Planet_Earth.svg.png"
        ];

        for (var i in data["Countries"]) {
          countryList.add(i["Country"]);
          String flagUrl = "https://www.countryflags.io/" +
              i["CountryCode"].toString().toLowerCase() +
              "/flat/64.png";
          countryData[i["Country"]] = [
            i["CountryCode"],
            i["NewConfirmed"],
            i["TotalConfirmed"],
            i["NewDeaths"],
            i["TotalDeaths"],
            i["NewRecovered"],
            i["TotalRecovered"],
            flagUrl
          ];
        }
        setState(() {
          cdata = countryData;
          clist = countryList;
          uDate = updateDate;
        });
      }
    }
    return countryData;
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
          children: <Widget>[
            MyHeader(
              image: "assets/images/doctor2.png",
              textTop: "All you need",
              textBottom: "is stay at home.",
              offset: offset,
              whichPage: "HomeScreen",
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              height: 60,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  color: Color(0xFFE5E5E5),
                ),
              ),
              child: Row(
                children: <Widget>[
                  SvgPicture.asset("assets/icons/maps-and-flags.svg"),
                  SizedBox(width: 20),
                  Expanded(
                    child: DropdownButton(
                      isExpanded: true,
                      underline: SizedBox(),
                      icon: SvgPicture.asset("assets/icons/dropdown.svg"),
                      value: "Search countries....",
                      items: (clist == null ? ["Search countries...."] : clist)
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        print(value);
                        value == "Search countries...."
                            ? ""
                            : Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CountryHome(
                                        value, cdata[value], uDate)));
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Case Update\n",
                              style: kTitleTextstyle,
                            ),
                            TextSpan(
                              text: "Newest update " + uDate,
                              style: TextStyle(
                                color: kTextLightColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      FlatButton(
                        padding: EdgeInsets.all(0),
                        child: Text(
                          "See details",
                          style: TextStyle(
                            color: kPrimaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CountryHome(
                                    "Global", cdata["Global"], uDate)),
                          );
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 4),
                          blurRadius: 30,
                          color: kShadowColor,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Counter(
                          color: kInfectedColor,
                          number: cdata == null
                              ? "- -"
                              : cdata["Global"][2].toString(),
                          title: "Infected",
                        ),
                        Counter(
                          color: kDeathColor,
                          number: cdata == null
                              ? "- -"
                              : cdata["Global"][4].toString(),
                          title: "Deaths",
                        ),
                        Counter(
                          color: kRecovercolor,
                          number: cdata == null
                              ? "- -"
                              : cdata["Global"][6].toString(),
                          title: "Recovered",
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Spread of Virus",
                        style: kTitleTextstyle,
                      ),
                      FlatButton(
                        padding: EdgeInsets.all(0),
                        child: Text(
                          "See details",
                          style: TextStyle(
                            color: kPrimaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Details()),
                          );
                        },
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    padding: EdgeInsets.all(20),
                    height: 178,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 10),
                          blurRadius: 30,
                          color: kShadowColor,
                        ),
                      ],
                    ),
                    child: Image.asset(
                      "assets/images/map.png",
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
