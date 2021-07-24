import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:repair_service_ui/utils/constants.dart';
import 'package:repair_service_ui/widgets/input_widget.dart';
import 'package:repair_service_ui/widgets/page_indicator.dart';
import 'package:repair_service_ui/widgets/primary_button.dart';

class HomePageContact extends StatefulWidget {
  final Function nextPage;
  final Function prevPage;
  final Map<String, dynamic> itemData;

  HomePageContact({this.nextPage, this.prevPage, this.itemData});

  @override
  _HomePageContactState createState() => _HomePageContactState();
}

class _HomePageContactState extends State<HomePageContact> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Map<String, dynamic> customer = {};
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      padding: EdgeInsets.symmetric(horizontal: 24.0),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            SizedBox(
              height: 20.0,
            ),
            PageIndicator(
              activePage: 4,
              darkMode: false,
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              "Indtast kontakt oplysninger? ",
              style: TextStyle(
                color: Constants.primaryColor,
                fontSize: 28.0,
                fontWeight: FontWeight.w600,
                height: 1.2,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            InputWidget(
              hintText: "Navn",
              suffixIcon: FlutterIcons.person_mdi,
              onSaved: (value) {
                customer["name"] = value;
                customer["nameIcon"] = FlutterIcons.person_mdi;
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Udfyld venligst dit navn";
                }
                return null;
              },
              initialValue: this.widget.itemData["customer"] != null
                  ? this.widget.itemData["customer"]["name"]
                  : null,
            ),
            SizedBox(
              height: 10.0,
            ),
            InputWidget(
              hintText: "Email",
              suffixIcon: FlutterIcons.email_mdi,
              onSaved: (value) {
                customer["email"] = value;
                customer["emailIcon"] = FlutterIcons.email_mdi;
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Udfyld venligst din email";
                }
                return null;
              },
              initialValue: this.widget.itemData["customer"] != null
                  ? this.widget.itemData["customer"]["email"]
                  : null,
            ),
            SizedBox(
              height: 10.0,
            ),
            InputWidget(
              hintText: "Telefon nummer",
              suffixIcon: FlutterIcons.phone_mdi,
              onSaved: (value) {
                customer["phone_number"] = value;
                customer["phone_numberIcon"] = FlutterIcons.phone_mdi;
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Udfyld venligst dit telefon nummer";
                }
                return null;
              },
              initialValue: this.widget.itemData["customer"] != null
                  ? this.widget.itemData["customer"]["phone_number"]
                  : null,
            ),
            SizedBox(
              height: 20.0,
            ),
            PrimaryButton(
              text: "Videre",
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  _formKey.currentState.save();
                  this.widget.itemData["customer"] = customer;
                  Future.delayed(Duration(milliseconds: 350), () {
                    this.widget.nextPage("/three", this.widget.itemData);
                  });
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
