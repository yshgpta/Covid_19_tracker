import 'package:flutter/material.dart';

import './constant.dart';
import './widgets/my_header.dart';

class Item {
  Item(
    this.headerValue,
    this.expandedValue,
    this.isExpanded,
  );

  String expandedValue;
  String headerValue;
  bool isExpanded;
}

List<Item> generateItems(int numberOfItems) {
  List<Item> data;
  data = [
    Item(
        "What is Coronavirus?",
        "Coronaviruses are a large family of viruses which may cause illness in humans. Several coronaviruses are known to cause respiratory infections ranging from the common cold to more severe diseases such as Middle East Respiratory Syndrome (MERS), Severe Acute Respiratory Syndrome (SARS) Severe Acute Respiratory Infection (SARI) and Influenza Like Infection(ILI). The most recently discovered coronavirus causes coronavirus disease COVID-19.",
        false),
    Item(
        "What is COVID-19?",
        "COVID-19 is the infectious disease caused by the most recently discovered coronavirus. This new virus was unknown before the outbreak began in Wuhan, China, in December 2019.",
        false),
    Item(
        "What are the symptoms of COVID-19?",
        "The most common symptoms of COVID-19 are fever, tiredness, difficulty in breathing and cough. Some patients may have aches and pains, nasal congestion, runny nose, sore throat or diarrhea. These symptoms are usually mild and begin gradually. Some people become infected but don’t develop any symptoms and don't feel unwell. Most people (about 80%) recover from the disease without needing special treatment. Around 1 out of every 6 people who gets COVID-19 becomes seriously ill and develops difficulty breathing. Older people, and those with underlying medical problems like high blood pressure, heart problems or diabetes, are more likely to develop serious illness. People with fever, cough and difficulty breathing should seek medical attention.",
        false),
    Item(
        "How does COVID-19 spread?",
        "People can catch COVID-19 from others who have the virus. The disease can spread from person to person through small droplets from the nose or mouth which are spread when a person with COVID-19 sneeze, coughs or exhales. These droplets land on objects and surfaces around the person. Other people then catch COVID-19 by touching these objects or surfaces, then touching their eyes, nose or mouth. People can also catch COVID-19 if they breathe in droplets from a person with COVID-19 who coughs out or exhales droplets. This is why it is important to stay more than 1 meter (3 feet) away from a person who is sick",
        false),
    Item(
        "Should I worry about COVID-19?",
        "Illness due to COVID-19 infection is generally mild, especially for children and young adults. However, it can cause serious illness: about 1 in every 5 people who catch it need hospital care. It is therefore quite normal for people to worry about how the COVID-19 outbreak will affect them and their loved ones. \n We can channel our concerns into actions to protect ourselves, our loved ones and our communities. First and foremost, among these actions is regular and thorough hand-washing and good respiratory hygiene. Secondly, keep informed and follow the advice of the local health authorities including any restrictions put in place on travel, movement and gatherings.",
        false),
    Item(
        "Who is at risk of developing severe illness?",
        "While we are still learning about how COVID-2019 affects people, older persons and persons with pre-existing medical conditions (such as high blood pressure, heart disease, lung disease, cancer or diabetes) appear to develop serious illness more often than others.",
        false),
    Item(
        "Are antibiotics effective in preventing or treating the COVID-19?",
        "No. Antibiotics do not work against viruses, they only work on bacterial infections. COVID-19 is caused by a virus, so antibiotics do not work. Antibiotics should not be used as a means of prevention or treatment of COVID-19. They should only be used as directed by a physician to treat a bacterial infection.",
        false),
    Item(
        "Are there any medicines or therapies that can prevent or cure COVID-19?",
        "While some western, traditional or home remedies may provide comfort and alleviate symptoms of COVID-19, there is no evidence that current medicine can prevent or cure the disease. World Health Organization (WHO) does not recommend self-medication with any medicines, including antibiotics, as a prevention or cure for COVID-19. However, there are several ongoing clinical trials that include both western and traditional medicines.",
        false),
    Item(
        "Is there a vaccine, drug or treatment for COVID-19?",
        "Not yet. To date, there is no vaccine and no specific antiviral medicine to prevent or treat COVID-2019. However, those affected should receive care to relieve symptoms. People with serious illness should be hospitalized. Most patients recover thanks to supportive care.\n Possible vaccines and some specific drug treatments are under investigation. They arebeing tested through clinical trials. WHO is coordinating efforts to develop vaccines and medicines to prevent and treat COVID-19.",
        false),
    Item(
        "How long is the incubation period for COVID-19?",
        "The “incubation period” means the time between catching the virus and beginning to have symptoms of the disease. Most estimates of the incubation period for COVID-19 range to around 14 days.",
        false),
    Item(
        "How long does the virus survive on surface?",
        "It is not certain how long the virus that causes COVID-19 survives on surfaces, but itseems to behave like other coronaviruses. Studies suggest that coronaviruses (includingpreliminary information on the COVID-19 virus) may persist on surfaces for a few hours or upto several days. This may vary under different conditions (e.g. type of surface, temperature orhumidity of the environment).\n If you think a surface may be infected, clean it with simple disinfectant to kill the virus and protect yourself and others. Clean your hands with an alcohol-based hand rub or wash themwith soap and water. Avoid touching your eyes, mouth, or nose.",
        false)
  ];
  return data;
}

class QuesAnswer extends StatefulWidget {
  QuesAnswer({Key key}) : super(key: key);

  @override
  _QuesAnswerState createState() => _QuesAnswerState();
}

class _QuesAnswerState extends State<QuesAnswer> {
  final controller = ScrollController();
  double offset = 0;

  List<Item> _data = generateItems(8);


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
        children: <Widget>[
        MyHeader(
        image: "assets/images/doctor4.png",
        textTop: "Clear your queries",
        textBottom: "and be safe.",
        offset: offset,
        whichPage: "QuesandAnswer",
    ),
    Text(
      "Frequently Asked Questions",
      style: kTitleTextstyle,
    ),
    SizedBox(height: 10,),
    Container(
    margin: EdgeInsets.symmetric(horizontal: 20),
    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
    width: double.infinity,
    decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(25),
    border: Border.all(
    color: Color(0xFFE5E5E5),
    ),
    ),
    child: SingleChildScrollView(
      child: Container(
        child: _buildPanel(),
      ),
    ),
    ),
    ],
    ),
    )
    );
  }

  Widget _buildPanel() {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _data[index].isExpanded = !isExpanded;
        });
      },
      children: _data.map<ExpansionPanel>((Item item) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(item.headerValue),
            );
          },
          body: ListTile(
            title: Text(item.expandedValue,style: kSubTextStyle,textAlign: TextAlign.justify,),
          ),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }
}
