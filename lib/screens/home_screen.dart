import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:boundless_arts/constants.dart';
import 'package:boundless_arts/util/size_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: SizeConfig.safeHeight * 0.05),
            height: SizeConfig.safeHeight * 0.25,
            decoration: BoxDecoration(
                color: kSecondaryColor,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: SizeConfig.safeHeight * 0.04),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Welcome to',
                        style: TextStyle(
                          fontSize: SizeConfig.scaleText(20),
                        ),
                      ),
                      Text(
                        'Boundless Arts',
                        style: TextStyle(
                          fontSize: SizeConfig.scaleText(26),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                    padding: EdgeInsets.all(SizeConfig.safeHeight * 0.01),
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.white10),
                        color: Colors.red,
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: Icon(
                      Icons.search,
                      size: SizeConfig.safeHeight * 0.05,
                      color: kPrimaryColor,
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
