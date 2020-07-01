import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:boundless_arts/constants.dart';
import 'package:boundless_arts/util/size_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:boundless_arts/services/networking.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui';
import 'dart:math';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> imgUrl = [];
  List<String> description = [];
  List photosData = [];
  bool showing = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    getData();
  }

  void getData() async {
    print('home getData was called');
    NetworkHelper networkHelper = NetworkHelper(
        'http://api.unsplash.com/photos/?client_id=', kAccessKey, '');

    photosData = await networkHelper.getData();
    print('photo length - ${photosData.length}');
    _assign();
    setState(() {
      showing = true;
    });
  }

  _assign() {
    for (int i = 0; i < photosData.length; i++) {
      imgUrl.add(photosData.elementAt(i)['urls']['regular']);
      description.add(photosData.elementAt(i)['alt_description']);
    }
  }

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
                  bottomRight: Radius.circular(30)),
              boxShadow: [
                new BoxShadow(
                  color: Colors.black87,
                  blurRadius: 12,
                ),
              ],
            ),
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
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.search,
                      size: SizeConfig.safeHeight * 0.05,
                      color: kPrimaryColor,
                    )),
              ],
            ),
          ),
          photosData == null
              ? CircularProgressIndicator()
              : Expanded(
                  child: Swiper(
                  scrollDirection: Axis.horizontal,
                  loop: false,
                  itemCount: photosData.length,
                  scale: 0.9,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: !showing
                          ? CircularProgressIndicator()
                          : Stack(
                              alignment: Alignment.center,
                              children: <Widget>[
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image(
                                    image:
                                        NetworkImage(imgUrl.elementAt(index)),
                                    fit: BoxFit.fill,
                                    height: SizeConfig.safeHeight * 0.6,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 5),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(
                                              SizeConfig.safeWidth * 0.03)),
                                      color: Colors.black.withOpacity(0.5),
                                    ),
                                    child: Text(
                                      '${description.elementAt(index)[0].toUpperCase()}${description.elementAt(index).substring(1)}',
                                      maxLines: 1,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white.withOpacity(1),
                                        fontSize: SizeConfig.scaleText(15),
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                    padding:
                                        EdgeInsets.all(SizeConfig.scaleText(6)),
                                  ),
                                  margin: EdgeInsets.only(
                                      bottom: SizeConfig.safeHeight * 0.02),
                                  alignment: Alignment.bottomCenter,
                                ),
                              ],
                            ),
                    );
                  },
                  viewportFraction: 0.8,
                  itemHeight: SizeConfig.safeWidth * 0.5,
                  itemWidth: SizeConfig.safeWidth * 0.5,
                )),
        ],
      ),
    );
  }
}
