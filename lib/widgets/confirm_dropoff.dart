import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:repair_service_ui/utils/constants.dart';
import 'package:repair_service_ui/widgets/dropoff_date.dart';
import 'package:repair_service_ui/widgets/page_indicator.dart';
import 'package:repair_service_ui/widgets/primary_button.dart';
import 'package:repair_service_ui/widgets/secondary_button.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'input_widget.dart';

class ConfirmDropoff extends StatefulWidget {
  final Map<String, dynamic> itemData;
  final Function nextPage;

  ConfirmDropoff({this.itemData, this.nextPage});
  @override
  _ConfirmDropoffState createState() => _ConfirmDropoffState();
}

class _ConfirmDropoffState extends State<ConfirmDropoff> {
  DateTime _selectedTime;
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
        .get(Uri.parse(
            'https://mlcittcx45.execute-api.eu-central-1.amazonaws.com/bookings'))
        .then((value) {
      print(value);
      List<DropoffDate> _availableTimes = [];
      for (var item in json.decode(value.body)) {
        List<String> _widgets = [];
        if (item["times"] != null) {
          for (var i in item["times"]) {
            _widgets.add(i["time"]);
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
            activePage: 6,
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
                  // children: availableTimes[currentIndex].options.map((e) {
                  //   return Padding(
                  //     padding: EdgeInsets.symmetric(vertical: 10),
                  //     child: Container(
                  //       child: SecondaryButton(
                  //         text: e
                  //       ),
                  //     ),
                  //   );
                  // }).toList(),
                  children: List.generate(
                      availableTimes[currentIndex].options.length, (index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Container(
                        child: SecondaryButton(
                          text: Text(
                            DateFormat("HH:mm")
                                .format(DateTime.parse(
                                    availableTimes[currentIndex]
                                        .options[index]))
                                .toString(),
                            style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontSize: 16.0,
                            ),
                          ),
                          onPressed: () {
                            DateTime date = DateTime.parse(
                                availableTimes[currentIndex].options[index]);
                            print(date);
                            setState(() {
                              _selectedTime = date;
                            });
                          },
                        ),
                      ),
                    );
                  }),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                ),
          _selectedTime != null
              ? SizedBox(
                  height: 20,
                )
              : Container(),
          _selectedTime != null
              ? PrimaryButton(
                  text: "Vælg tid " +
                      DateFormat("HH:mm").format(
                        DateTime.parse(_selectedTime.toString()),
                      ),
                  onPressed: () {
                    this.widget.itemData["drop_off_date"] = _selectedTime;
                    Future.delayed(Duration(milliseconds: 350), () {
                      this.widget.nextPage("/confirm", this.widget.itemData);
                    });
                  },
                )
              : Container(),
        ],
      ),
    );
  }
}
