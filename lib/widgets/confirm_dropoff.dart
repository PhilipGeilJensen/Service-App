import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:repair_service_ui/utils/constants.dart';
import 'package:repair_service_ui/widgets/dropoff_date.dart';
import 'package:repair_service_ui/widgets/page_indicator.dart';
import 'package:repair_service_ui/widgets/secondary_button.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'input_widget.dart';

class ConfirmDropoff extends StatefulWidget {
  @override
  _ConfirmDropoffState createState() => _ConfirmDropoffState();
}

class _ConfirmDropoffState extends State<ConfirmDropoff> {
  int currentIndex = 0;
  List<DropoffDate> availableTimes;
  // final List<DropoffDate> options = [
  //   DropoffDate(
  //     "20-07-2021",
  //     [
  //       Padding(
  //         padding: EdgeInsets.symmetric(vertical: 10),
  //         child: Container(
  //           child: SecondaryButton(
  //             text: "09:00",
  //           ),
  //         ),
  //       ),
  //     ],
  //   ),
  // ];
  @override
  void initState() {
    // TODO: implement initState
    http
        .get(Uri.parse('http://10.100.32.237:80/api/dropoff-times'))
        .then((value) {
      List<DropoffDate> _availableTimes = [];
      for (var item in json.decode(value.body)) {
        List<Widget> _widgets = [];
        if (item["times"] != null) {
          for (var i in item["times"]) {
            _widgets.add(
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Container(
                  child: SecondaryButton(
                    text: DateFormat("HH:mm")
                        .format(DateTime.parse(i["time"]).toLocal())
                        .toString(),
                  ),
                ),
              ),
            );
          }
        }
        _availableTimes.add(DropoffDate(
            DateFormat("dd-MM-yyyy")
                .format(DateTime.parse(item["date"]))
                .toString(),
            _widgets));
      }

      setState(() {
        availableTimes = _availableTimes;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (availableTimes == null || availableTimes.length == 0) {
      return Center(
        child: CircularProgressIndicator(
          color: Colors.black,
        ),
      );
    }
    return Container(
      width: size.width,
      padding: EdgeInsets.symmetric(horizontal: 24.0),
      child: ListView(
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
            "Vælg en dato og tidspunkt for aflevering",
            style: TextStyle(
              color: Constants.primaryColor,
              fontSize: 28.0,
              fontWeight: FontWeight.w600,
              height: 1.2,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: SizedBox(),
              ),
              IconButton(
                onPressed: () => {
                  setState(() {
                    if (currentIndex > 0) {
                      currentIndex -= 1;
                    }
                  })
                },
                icon: Icon(Icons.arrow_back),
              ),
              Expanded(
                child: SizedBox(),
              ),
              Text(availableTimes[currentIndex].date),
              Expanded(
                child: SizedBox(),
              ),
              IconButton(
                onPressed: () => {
                  setState(() {
                    if (currentIndex < availableTimes.length - 1) {
                      currentIndex += 1;
                    }
                  })
                },
                icon: Icon(Icons.arrow_forward),
              ),
              Expanded(
                child: SizedBox(),
              ),
            ],
          ),
          availableTimes[currentIndex].options == null ||
                  availableTimes[currentIndex].options.length == 0
              ? Center(
                  child: Text("Der er ingen tilgængelige tider denne dag"),
                )
              : GridView.count(
                  crossAxisCount: 3,
                  crossAxisSpacing: 30,
                  childAspectRatio: 1.5,
                  children: availableTimes[currentIndex]
                      .options
                      .map((e) => e)
                      .toList(),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                ),
        ],
      ),
    );
  }
}
