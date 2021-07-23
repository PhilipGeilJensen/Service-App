import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:repair_service_ui/utils/constants.dart';
import 'package:repair_service_ui/widgets/input_widget.dart';
import 'package:repair_service_ui/widgets/primary_button.dart';
import 'package:http/http.dart' as http;

class ConfirmTelephone extends StatefulWidget {
  final Map<String, dynamic> itemData;
  final Function reset;

  ConfirmTelephone({this.itemData, this.reset});
  @override
  _ConfirmTelephoneState createState() => _ConfirmTelephoneState();
}

class _ConfirmTelephoneState extends State<ConfirmTelephone> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Map<String, String> customer = {};
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Text(
            "Indtast dit navn og telefon nummer",
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
          InputWidget(
            hintText: "Navn",
            suffixIcon: FlutterIcons.person_mdi,
            onSaved: (value) {
              customer["name"] = value;
            },
          ),
          SizedBox(
            height: 20,
          ),
          InputWidget(
            hintText: "Telefon nummer",
            suffixIcon: FlutterIcons.phone_call_fea,
            onSaved: (value) {
              customer["phone_number"] = value;
            },
          ),
          SizedBox(
            height: 20,
          ),
          PrimaryButton(
            text: "Send sag afsted",
            onPressed: () {
              _formKey.currentState.save();
              this.widget.itemData["customer"] = customer;
              Future.delayed(Duration(milliseconds: 350), () {
                http
                    .post(
                  Uri.parse('http://10.100.32.237:8080/create-request'),
                  headers: <String, String>{
                    'Content-Type': 'application/json; charset=UTF-8',
                  },
                  body: jsonEncode(this.widget.itemData),
                )
                    .then((response) {
                  if (response.statusCode == 200) {
                    Scaffold.of(context).showBottomSheet(
                      (context) => BottomSheet(
                        onClosing: () => Navigator.pop(context),
                        builder: (context) {
                          return Container(
                            height: 60,
                            color: Colors.green[800],
                            alignment: Alignment.center,
                            child: Row(
                              children: [
                                Expanded(
                                  child: SizedBox(),
                                  flex: 1,
                                ),
                                Expanded(
                                  child: Center(
                                    child: Text(
                                      "Vi har modtaget din henvendelse",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  flex: 2,
                                ),
                                Expanded(
                                  child: Center(
                                    child: IconButton(
                                      onPressed: () => Navigator.pop(context),
                                      icon: Icon(
                                        Icons.close,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  flex: 1,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                    this.widget.reset();
                  }
                });
              });
            },
          )
        ],
      ),
    );
  }
}
