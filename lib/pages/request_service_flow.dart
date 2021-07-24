import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:loader_overlay/loader_overlay.dart';
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
  Map<String, dynamic> itemData;
  Map<String, Widget> _widgets = {};
  int confirmWidget;
  Queue<String> _widget = Queue();

  void pushPage(String page, Map<String, dynamic> item) {
    print(item);
    setState(() {
      itemData = item;
      _widget.add(page);
    });
  }

  void popPage() {
    setState(() {
      _widget.removeLast();
    });
  }

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
      _widget.clear();
    });
  }

  void goToPage(int index) {
    setState(() {
      current = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    _widgets = {
      "/one": HomePageOne(nextPage: pushPage, prevPage: popPage),
      "/two": HomePageTwo(
          nextPage: pushPage, prevPage: popPage, itemData: itemData),
      "/three": HomePageThree(
          nextPage: pushPage, prevPage: popPage, itemData: itemData),
      "/info": HomePageInformation(
          nextPage: pushPage, prevPage: popPage, itemData: itemData),
      "/contact": HomePageContact(
          nextPage: pushPage, prevPage: popPage, itemData: itemData),
      "/booking": ConfirmDropoff(
        itemData: itemData,
        nextPage: pushPage,
      ),
      "/confirm": ConfirmPage(
        prevPage: popPage,
        itemData: itemData,
        reset: reset,
      ),
    };
    if (_widgets.isEmpty) {
      return Center(
        child: CircularProgressIndicator(
          color: Colors.black,
        ),
      );
    }

    return WillPopScope(
      onWillPop: () async {
        if (_widget.isEmpty) {
          return true;
        } else {
          popPage();
          return false;
        }
      },
      child: LoaderOverlay(
        useDefaultLoading: false,
        overlayWidget: Center(
          child: CircularProgressIndicator(
            color: Colors.black,
          ),
        ),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            brightness: Brightness.dark,
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            leading: _widget.isNotEmpty
                ? GestureDetector(
                    onTap: () {
                      this.popPage();
                    },
                    child: Icon(FlutterIcons.keyboard_backspace_mdi),
                  )
                : null,
            iconTheme: IconThemeData(
              color: Constants.primaryColor,
            ),
          ),
          backgroundColor:
              _widget.isEmpty ? Constants.primaryColor : Colors.white,
          body: AnimatedSwitcher(
            duration: Duration(milliseconds: 300),
            child:
                _widget.isNotEmpty ? _widgets[_widget.last] : _widgets["/one"],
          ),
        ),
      ),
    );
  }
}
