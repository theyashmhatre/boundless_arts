import 'package:boundless_arts/constants.dart';
import 'package:boundless_arts/util/size_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:boundless_arts/widgets/profile_columns.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
              height: SizeConfig.safeHeight * 0.5,
              width: double.infinity,
              child: Image.asset(
                'assets/images/Ted.jpg',
                fit: BoxFit.cover,
              )),
          Container(
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.only(top: SizeConfig.safeHeight * 0.4),
            width: double.infinity,
            decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30), topLeft: Radius.circular(30)),
            ),
            child: Column(
              children: <Widget>[
                Text(
                  'Ted Mosby',
                  style: TextStyle(
                    color: kTertiaryColor,
                    fontSize: SizeConfig.scaleText(23),
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Acme',
                  ),
                ),
                Text(
                  'Wildlife Photographer',
                  style: TextStyle(
                    color: Colors.grey,
                    fontFamily: 'Bitter',
                  ),
                ),
                SizedBox(height: SizeConfig.safeHeight * 0.015),
                Container(
                  child: RaisedButton(
                    color: kTertiaryColor,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    onPressed: () {},
                    child: Text(
                      'Hire Me',
                      style: TextStyle(
                          color: kSecondaryColor,
                          fontSize: SizeConfig.scaleText(15)),
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    SizedBox(height: SizeConfig.safeHeight * 0.04),
                    ProfileColumns(
                        icon: Icons.chat_bubble_outline, text: 'Start a chat'),
                    SizedBox(height: SizeConfig.safeHeight * 0.04),
                    ProfileColumns(
                        icon: Icons.star_border, text: 'Review Ratings'),
                    SizedBox(height: SizeConfig.safeHeight * 0.04),
                    ProfileColumns(
                        icon: Icons.format_list_bulleted,
                        text: 'Asked questions'),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
