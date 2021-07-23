import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:repair_service_ui/utils/constants.dart';
import 'package:repair_service_ui/widgets/input_widget.dart';
import 'package:repair_service_ui/widgets/primary_button.dart';

class ConfirmMail extends StatefulWidget {
  @override
  _ConfirmMailState createState() => _ConfirmMailState();
}

class _ConfirmMailState extends State<ConfirmMail> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Indtast dit navn og email addresse",
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
        ),
        SizedBox(
          height: 20,
        ),
        InputWidget(
          hintText: "Email",
          suffixIcon: FlutterIcons.email_mco,
        ),
        SizedBox(
          height: 20,
        ),
        PrimaryButton(
          text: "Send sag afsted",
          onPressed: () => {},
        )
      ],
    );
  }
}
