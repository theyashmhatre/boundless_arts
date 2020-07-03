import 'package:boundless_arts/constants.dart';
import 'package:boundless_arts/util/size_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:boundless_arts/services/networking.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui';
import 'package:boundless_arts/screens/bottom_sheet.dart';
import 'package:boundless_arts/widgets/swiper_widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with TickerProviderStateMixin<HomePage> {
  List<String> imgUrl = [];
  List<String> description = [];
  List photosData = [];
  bool showing = false;
  double _scale;
  AnimationController _controller;

  @override
  void initState() {
    getData();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 100),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });

    super.initState();
  }

  //getData from network helper and make a list of urls

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

  //HomeScreen bottomSheet container

  void _onButtonPressed() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => SingleChildScrollView(
          child: Container(
        height: SizeConfig.safeHeight * 0.6,
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: BottomContainerSheet(),
      )),
    );
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller.value;
    SizeConfig().init(context);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: SizeConfig.safeHeight * 0.05),
            height: SizeConfig.safeHeight * 0.25, //top container height
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

            //Welcome to boundless Arts text and search icon

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
                          fontFamily: 'Bitter',
                        ),
                      ),
                      Text(
                        'Boundless Arts',
                        style: TextStyle(
                          fontSize: SizeConfig.scaleText(28),
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Berkshire',
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _controller.forward().then((val) {
                      _controller.reverse().then((val) {
                        _onButtonPressed();
                      });
                    });
                  },
                  child: Transform.scale(
                    scale: _scale,
                    child: Container(
                        width: SizeConfig.safeWidth * 0.17,
                        height: SizeConfig.safeHeight * 0.07,
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: kTertiaryColor.withOpacity(0.7),
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            border: Border.all(width: 1),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black,
                                blurRadius: 3,
                                offset: Offset(0.2, 0.5),
                              ),
                            ]),
                        child: Icon(
                          Icons.search,
                          size: SizeConfig.safeHeight * 0.05,
                          color: kSecondaryColor,
                        )),
                  ),
                ),
              ],
            ),
          ),
          photosData == null
              ? CircularProgressIndicator()
              : SwiperWidget(
                  photosData: photosData,
                  imgUrl: imgUrl,
                  showing: showing,
                  description: description),
        ],
      ),
    );
  }
}
