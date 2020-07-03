import 'package:flutter/material.dart';
import 'package:boundless_arts/constants.dart';
import 'package:boundless_arts/util/size_util.dart';

class ProfileColumns extends StatelessWidget {
  ProfileColumns({this.icon, this.text});
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
            decoration: BoxDecoration(
              color: kInactiveColor,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            padding: EdgeInsets.all(10),
            child: Icon(
              icon,
              color: kPrimaryColor,
            )),
        Row(
          children: <Widget>[
            Text(
              text,
              style: TextStyle(
                fontSize: SizeConfig.scaleText(20),
                fontFamily: 'Bitter',
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(width: SizeConfig.safeWidth * 0.13),
          ],
        ),
        Icon(Icons.chevron_right),
      ],
    );
  }
}
