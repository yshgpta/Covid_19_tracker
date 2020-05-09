import 'package:flutter/material.dart';

import './constant.dart';

class Details extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 50),
        child: Column(
          children: <Widget>[
            Image.asset(
              "assets/images/map.png",
              fit: BoxFit.contain,
            ),
            SizedBox(height: 10),
            Text(
              "Spread of Virus",
              style: kTitleTextstyle,
            ),
            SizedBox(height: 10),
            Container(
              margin: EdgeInsets.all(10),
              child: Text(
                "Since the new coronavirus was first reported in Wuhan, China, in December, the infectious respiratory disease COVID-19 has spread rapidly within China and to neighboring countries and beyond.\n\n The first confirmed coronavirus cases outside China occurred on Jan. 20, in Japan, Thailand and South Korea. On Jan. 21, the first case in the U.S. was identified in Washington state.\n\n"
                "On Jan. 24, the first two European cases were confirmed in France. By Feb. 1, eight European nations had confirmed cases of COVID-19, and a month later that count had risen to 24 countries with at least 2,200 cases, most of them in Italy. \n\nOn March 11, Italy eclipsed 10,000 cases and the World Health Organization declared the outbreak a pandemic — the first since H1N1 in 2009."
                " That's also when China, the original epicenter, began seeing drops in daily counts of new cases.March also saw exponential spread of the virus throughout the U.S., with all 50 states reporting cases by March 17.",
                style: TextStyle(
                  color: kBodyTextColor,
                ),
                textAlign: TextAlign.justify,
              ),
            )
          ],
        ),
      ),
    );
  }
}
