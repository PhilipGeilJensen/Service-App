import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_svg/svg.dart';
import 'package:repair_service_ui/utils/constants.dart';
import 'package:repair_service_ui/widgets/input_widget.dart';
import 'package:repair_service_ui/widgets/page_indicator.dart';

class HomePageTwo extends StatefulWidget {
  final Function nextPage;
  final Function prevPage;
  final Map<String, dynamic> itemData;

  HomePageTwo({this.nextPage, this.prevPage, this.itemData});

  @override
  _HomePageTwoState createState() => _HomePageTwoState();
}

class _HomePageTwoState extends State<HomePageTwo> {
  final List options = [
    [
      {
        "name": "Opstart eller Strøm",
        "icon": Icons.power,
        "key": "power",
      },
      {
        "name": "Hardware Problemer",
        "icon": Icons.hardware,
        "key": "hardware",
      },
    ],
    // Second
    [
      {
        "name": "Batteri & Opladning",
        "icon": Icons.battery_alert,
        "key": "charging",
      },
      {
        "name": "Internet & Forbindelse",
        "icon": Icons.wifi,
        "key": "internet",
      },
    ],
    // Third
    [
      {
        "name": "Software & Brug",
        "icon": Icons.bug_report,
        "key": "software",
      },
      {
        "name": "Mail",
        "icon": Icons.mail,
        "key": "mail",
      },
    ],
    // Fourth
    [
      {
        "name": "Opsætning",
        "icon": Icons.settings,
        "key": "setup",
      },
      {
        "name": "Andet",
        "icon": Icons.miscellaneous_services,
        "key": "other",
      },
    ],
  ];

  String active = "";

  void setActiveFunc(String key) {
    setState(() {
      active = key;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(this.widget.itemData);
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      padding: EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 20.0,
          ),
          PageIndicator(
            activePage: 2,
            darkMode: false,
          ),
          SizedBox(
            height: 20.0,
          ),
          Text(
            "Hvad sker der med din " + this.widget.itemData["device"] + "? ",
            style: TextStyle(
              color: Constants.primaryColor,
              fontSize: 28.0,
              fontWeight: FontWeight.w600,
              height: 1.2,
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(
                  4,
                  (index) => Expanded(
                    child: Container(
                      margin: EdgeInsets.only(bottom: index == 3 ? 0 : 10.0),
                      child: Row(
                        children: [
                          serviceCard(options[index][0], active, setActiveFunc,
                              this.widget.nextPage, this.widget.itemData),
                          SizedBox(
                            width: 10.0,
                          ),
                          serviceCard(options[index][1], active, setActiveFunc,
                              this.widget.nextPage, this.widget.itemData),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget serviceCard(Map item, String active, Function setActive,
    Function nextPage, Map<String, dynamic> itemData) {
  bool isActive = active == item["key"];
  return Expanded(
    child: GestureDetector(
      onTap: () {
        setActive(item["key"]);
        itemData["problem"] = item["name"];
        itemData["problemIcon"] = item["icon"];
        Future.delayed(Duration(milliseconds: 350), () {
          nextPage("/info", itemData);
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: isActive ? Colors.black : Constants.greyColor,
          borderRadius: BorderRadius.circular(12.0),
        ),
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Icon(
                item["icon"],
                size: 32,
                color: isActive ? Colors.white : null,
              ),
            ),
            Text(
              item["name"],
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14.0,
                  color: isActive
                      ? Colors.white
                      : Color.fromRGBO(20, 20, 20, 0.96)),
            )
          ],
        ),
      ),
    ),
  );
}
