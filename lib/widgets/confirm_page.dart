import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:repair_service_ui/utils/constants.dart';
import 'package:repair_service_ui/widgets/confirm_dropoff.dart';
import 'package:repair_service_ui/widgets/confirm_telephone.dart';
import 'package:repair_service_ui/widgets/page_indicator.dart';
import 'package:repair_service_ui/widgets/primary_button.dart';
import 'package:http/http.dart' as http;

class ConfirmPage extends StatefulWidget {
  Function prevPage;
  int confirmWidget;
  Function reset;
  Map<String, dynamic> itemData;

  ConfirmPage({this.prevPage, this.confirmWidget, this.reset, this.itemData});

  @override
  _ConfirmPageState createState() => _ConfirmPageState();
}

class _ConfirmPageState extends State<ConfirmPage> {
  @override
  Widget build(BuildContext context) {
    List<Widget> options = [
      ConfirmTelephone(
        itemData: this.widget.itemData,
        reset: this.widget.reset,
      ),
      ConfirmDropoff(),
    ];
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      padding: EdgeInsets.symmetric(horizontal: 24.0),
      child: ListView(
        children: [
          SizedBox(
            height: 20.0,
          ),
          PageIndicator(
            activePage: 7,
            darkMode: false,
          ),
          SizedBox(
            height: 20.0,
          ),
          Text(
            "Bekræft dine oplysninger og send afsted",
            style: TextStyle(
              color: Constants.primaryColor,
              fontSize: 28.0,
              fontWeight: FontWeight.w600,
              height: 1.2,
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Text(
            "Kontakt oplysninger",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20.0,
              color: Color.fromRGBO(20, 20, 20, 0.96),
            ),
          ),
          itemTile(
            "Navn",
            this.widget.itemData["customer"]["name"],
            this.widget.itemData["customer"]["nameIcon"],
          ),
          itemTile(
            "Email",
            this.widget.itemData["customer"]["email"],
            this.widget.itemData["customer"]["emailIcon"],
          ),
          itemTile(
            "Telefon nummer",
            this.widget.itemData["customer"]["phone_number"],
            this.widget.itemData["customer"]["phone_numberIcon"],
          ),
          Text(
            "Enheds oplysninger",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20.0,
              color: Color.fromRGBO(20, 20, 20, 0.96),
            ),
          ),
          itemTile(
            "Enheden",
            this.widget.itemData["device"],
            this.widget.itemData["deviceIcon"],
          ),
          itemTile(
            "Problem",
            this.widget.itemData["problem"],
            this.widget.itemData["problemIcon"],
          ),
          itemTile(
            "Hvad er problemet",
            this.widget.itemData["informations"]["issue"],
            this.widget.itemData["informations"]["issueIcon"],
          ),
          itemTile(
            "Mærke",
            this.widget.itemData["informations"]["brand"],
            this.widget.itemData["informations"]["brandIcon"],
          ),
          itemTile(
            "Model",
            this.widget.itemData["informations"]["model"],
            this.widget.itemData["informations"]["modelIcon"],
          ),
          itemTile(
            "Enhedens alder",
            this.widget.itemData["informations"]["device_age"],
            this.widget.itemData["informations"]["device_ageIcon"],
          ),
          itemTile(
            "Service metode",
            this.widget.itemData["service_method_name"],
            this.widget.itemData["service_methodIcon"],
          ),
          this.widget.itemData["drop_off_date"] != null
              ? itemTile(
                  "Tidspunkt",
                  DateFormat("dd-MM-yyyy HH:mm").format(
                    DateTime.parse(
                        this.widget.itemData["drop_off_date"].toString()),
                  ),
                  Icons.calendar_today)
              : Container(),
          SizedBox(
            height: 20,
          ),
          PrimaryButton(
            text: "Send sag afsted",
            onPressed: () {
              context.loaderOverlay.show();
              // http
              //     .post(
              //   Uri.parse(
              //       'https://mlcittcx45.execute-api.eu-central-1.amazonaws.com/email'),
              //   headers: <String, String>{
              //     'Content-Type': 'application/json; charset=UTF-8',
              //   },
              //   body: jsonEncode({
              //     "device": this.widget.itemData["device"],
              //     "problem": this.widget.itemData["problem"],
              //     "information": {
              //       "issue": this.widget.itemData["informations"]["issue"],
              //       "brand": this.widget.itemData["informations"]["brand"],
              //       "model": this.widget.itemData["informations"]["model"],
              //       "device_age": this.widget.itemData["informations"]
              //           ["device_age"],
              //     },
              //     "customer": {
              //       "name": this.widget.itemData["customer"]["name"],
              //       "email": this.widget.itemData["customer"]["email"],
              //       "phone_number": this.widget.itemData["customer"]
              //           ["phone_number"],
              //     },
              //     "service_method": this.widget.itemData["service_method"],
              //     "drop_off_date": {
              //       "date": this.widget.itemData["drop_off_date"] != null
              //           ? DateTime.parse(this
              //                   .widget
              //                   .itemData["drop_off_date"]
              //                   .toString())
              //               .toIso8601String()
              //           : null,
              //     },
              //   }),
              // )
              //     .then((value) {
              //   if (value.statusCode == 200) {
              //     Scaffold.of(context).showBottomSheet(
              //       (context) => BottomSheet(
              //         onClosing: () => Navigator.pop(context),
              //         builder: (context) {
              //           return Container(
              //             height: 60,
              //             color: Colors.green[800],
              //             alignment: Alignment.center,
              //             child: Row(
              //               children: [
              //                 Expanded(
              //                   child: SizedBox(),
              //                   flex: 1,
              //                 ),
              //                 Expanded(
              //                   child: Center(
              //                     child: Text(
              //                       "Vi har modtaget din henvendelse",
              //                       style: TextStyle(
              //                         color: Colors.white,
              //                         fontSize: 16,
              //                         fontWeight: FontWeight.w600,
              //                       ),
              //                     ),
              //                   ),
              //                   flex: 2,
              //                 ),
              //                 Expanded(
              //                   child: Center(
              //                     child: IconButton(
              //                       onPressed: () => Navigator.pop(context),
              //                       icon: Icon(
              //                         Icons.close,
              //                         color: Colors.white,
              //                       ),
              //                     ),
              //                   ),
              //                   flex: 1,
              //                 ),
              //               ],
              //             ),
              //           );
              //         },
              //       ),
              //     );
              //     context.loaderOverlay.hide();
              //     this.widget.reset();
              //   }
              // });
            },
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}

Widget itemTile(String title, subtitle, IconData icon) {
  return ListTile(
    title: Text(
      title,
      style: TextStyle(
        color: Constants.primaryColor,
        fontWeight: FontWeight.w500,
      ),
    ),
    subtitle: Text(
      subtitle,
      style: TextStyle(
        color: Constants.primaryColor,
        fontWeight: FontWeight.w600,
      ),
    ),
    trailing: Icon(icon),
  );
}
