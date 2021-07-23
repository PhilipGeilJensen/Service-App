import 'package:flutter/material.dart';
import 'package:repair_service_ui/widgets/confirm_dropoff.dart';
import 'package:repair_service_ui/widgets/confirm_mail.dart';
import 'package:repair_service_ui/widgets/confirm_telephone.dart';
import 'package:repair_service_ui/widgets/page_indicator.dart';

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
      ConfirmMail(),
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
            activePage: 5,
            darkMode: false,
          ),
          SizedBox(
            height: 20.0,
          ),
          options[widget.confirmWidget],
        ],
      ),
    );
  }
}
