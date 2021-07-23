import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:repair_service_ui/utils/constants.dart';
import 'package:repair_service_ui/widgets/confirm_dropoff.dart';
import 'package:repair_service_ui/widgets/confirm_page.dart';
import 'package:repair_service_ui/widgets/home_page_contact.dart';
import 'package:repair_service_ui/widgets/home_page_info.dart';
import 'package:repair_service_ui/widgets/home_page_one.dart';
import 'package:repair_service_ui/widgets/home_page_three.dart';
import 'package:repair_service_ui/widgets/home_page_two.dart';

class RequestServiceFlow extends StatefulWidget {
  @override
  _RequestServiceFlowState createState() => _RequestServiceFlowState();
}

class _RequestServiceFlowState extends State<RequestServiceFlow> {
  int current = 0;
  Map<String, dynamic> itemData = {"device": "Initial", "problem": "Initial"};
  int confirmWidget;

  void nextPage(Map<String, dynamic> item) {
    print(item);
    setState(() {
      itemData = item;
      current += 1;
    });
  }

  void prevPage() {
    setState(() {
      current -= 1;
    });
  }

  void confirmPage(int widget, Map<String, dynamic> item) {
    print(item);
    setState(() {
      itemData = item;
      current += 1;
      confirmWidget = widget;
    });
  }

  void reset() {
    setState(() {
      current = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      HomePageOne(nextPage: nextPage, prevPage: prevPage),
      HomePageTwo(nextPage: nextPage, prevPage: prevPage, itemData: itemData),
      HomePageInformation(
          nextPage: nextPage, prevPage: prevPage, itemData: itemData),
      HomePageContact(
          nextPage: nextPage, prevPage: prevPage, itemData: itemData),
      HomePageThree(
        nextPage: confirmPage,
        prevPage: prevPage,
        itemData: itemData,
      ),
      ConfirmDropoff()
    ];

    return WillPopScope(
      onWillPop: () async {
        if (current == 0) {
          return true;
        } else {
          prevPage();
          return false;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          brightness: Brightness.dark,
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          leading: current > 0
              ? GestureDetector(
                  onTap: () {
                    this.prevPage();
                  },
                  child: Icon(FlutterIcons.keyboard_backspace_mdi),
                )
              : null,
          iconTheme: IconThemeData(
            color: Constants.primaryColor,
          ),
        ),
        backgroundColor: current == 0 ? Constants.primaryColor : Colors.white,
        body: AnimatedSwitcher(
          duration: Duration(milliseconds: 300),
          child: pages[current],
        ),
      ),
    );
  }
}
