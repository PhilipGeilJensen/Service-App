import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:repair_service_ui/utils/constants.dart';
import 'package:repair_service_ui/widgets/input_widget.dart';
import 'package:repair_service_ui/widgets/page_indicator.dart';
import 'package:repair_service_ui/widgets/primary_button.dart';

class HomePageInformation extends StatefulWidget {
  final Function nextPage;
  final Function prevPage;
  final Map<String, dynamic> itemData;

  HomePageInformation({this.nextPage, this.prevPage, this.itemData});

  @override
  _HomePageInformationState createState() => _HomePageInformationState();
}

class _HomePageInformationState extends State<HomePageInformation> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Map<String, String> informations = {};
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
              activePage: 3,
              darkMode: false,
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              "Kan du give os yderligere informationer? ",
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
              hintText: "Hvad er problemet?",
              suffixIcon: FlutterIcons.description_mdi,
              onSaved: (value) {
                informations["issue"] = value;
              },
            ),
            SizedBox(
              height: 10.0,
            ),
            InputWidget(
              hintText: "Enhedens mærke",
              suffixIcon: FlutterIcons.important_devices_mdi,
              onSaved: (value) {
                informations["brand"] = value;
              },
            ),
            SizedBox(
              height: 10.0,
            ),
            InputWidget(
              hintText: "Enhedens model",
              suffixIcon: FlutterIcons.perm_device_information_mdi,
              onSaved: (value) {
                informations["model"] = value;
              },
            ),
            SizedBox(
              height: 10.0,
            ),
            InputWidget(
              hintText: "Enhedens alder",
              suffixIcon: FlutterIcons.timetable_mco,
              onSaved: (value) {
                informations["device_age"] = value;
              },
            ),
            SizedBox(
              height: 20,
            ),
            PrimaryButton(
              text: "Videre",
              onPressed: () {
                _formKey.currentState.save();
                this.widget.itemData["informations"] = informations;
                Future.delayed(Duration(milliseconds: 350), () {
                  this.widget.nextPage(this.widget.itemData);
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
