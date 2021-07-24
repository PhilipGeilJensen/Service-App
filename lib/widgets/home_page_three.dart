import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_svg/svg.dart';
import 'package:repair_service_ui/utils/constants.dart';
import 'package:repair_service_ui/widgets/confirm_dropoff.dart';
import 'package:repair_service_ui/widgets/confirm_telephone.dart';
import 'package:repair_service_ui/widgets/page_indicator.dart';

import 'input_widget.dart';

class HomePageThree extends StatefulWidget {
  final Function nextPage;
  final Function prevPage;
  final Map<String, dynamic> itemData;

  HomePageThree({this.nextPage, this.prevPage, this.itemData});

  @override
  _HomePageThreeState createState() => _HomePageThreeState();
}

class _HomePageThreeState extends State<HomePageThree> {
  final List options = [
    {
      "name": "Snak med vores support",
      "icon": Icons.phone,
      "key": "phone",
      "description": "Lad os ringe dig op hurtigst muligt",
      "next": "/confirm",
    },
    {
      "name": "Modtag en mail",
      "icon": Icons.mail,
      "key": "mail",
      "description": "Få svar på din henvendelse via mail",
      "next": "/confirm",
    },
    {
      "name": "Aflever for reperation",
      "icon": Icons.build,
      "key": "dropoff",
      "description": "Vælg et tidspunkt for aflevering",
      "next": "/booking",
    },
  ];

  String active = "";

  void setActiveFunc(String key) {
    setState(() {
      active = key;
    });
  }

  @override
  Widget build(BuildContext context) {
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
            activePage: 5,
            darkMode: false,
          ),
          SizedBox(
            height: 20.0,
          ),
          Text(
            "Hvordan vil du gerne modtage hjælp?",
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
                children: options.map((e) {
                  int index = options.indexOf(e);
                  return serviceCard(options[index], active, setActiveFunc,
                      this.widget.nextPage, this.widget.itemData);
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget serviceCard(Map item, String active, Function setActive, nextPage,
    Map<String, dynamic> itemData) {
  bool isActive = active == item["key"];
  return Expanded(
    child: GestureDetector(
      onTap: () {
        setActive(item["key"]);
        itemData["service_method"] = item["key"];
        itemData["service_method_name"] = item["name"];
        itemData["service_methodIcon"] = item["icon"];
        Future.delayed(Duration(milliseconds: 350), () {
          nextPage(item["next"], itemData);
        });
      },
      child: AnimatedContainer(
        margin: EdgeInsets.only(bottom: 15.0),
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
                color: isActive ? Colors.white : null,
                size: 42,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item["name"],
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20.0,
                    color: isActive
                        ? Colors.white
                        : Color.fromRGBO(20, 20, 20, 0.96),
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  item["description"],
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 12.0,
                    color: isActive
                        ? Colors.white
                        : Color.fromRGBO(20, 20, 20, 0.96),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    ),
  );
}
