import 'package:boundless_arts/constants.dart';
import 'package:boundless_arts/util/size_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:boundless_arts/services/networking.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui';
import 'package:boundless_arts/screens/bottom_sheet.dart';
import 'full_screen_image.dart';

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
    getData();
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
    SizeConfig().init(context);

    return Scaffold(
      resizeToAvoidBottomInset: true,
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
                    width: SizeConfig.safeWidth * 0.17,
                    height: SizeConfig.safeHeight * 0.07,
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(2.0, 2.0),
                            color: Colors.black87,
                            blurRadius: 3.0,
                            spreadRadius: 1.0,
                          ),
                        ]),
                    child: FlatButton(
                      color: kTertiaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      onPressed: () {
                        _onButtonPressed();
                      },
                      child: Icon(
                        Icons.search,
                        size: SizeConfig.safeHeight * 0.05,
                        color: kPrimaryColor,
                      ),
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
                  control: SwiperControl(),
                  itemBuilder: (BuildContext context, int index) {
                    return FlatButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return FullScreenImage(
                            url: imgUrl[index],
                          );
                        }));
                      },
                      child: Container(
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
                                      image: NetworkImage(
                                          '${imgUrl.elementAt(index)}'),
                                      fit: BoxFit.cover,
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
                                      padding: EdgeInsets.all(
                                          SizeConfig.scaleText(6)),
                                    ),
                                    margin: EdgeInsets.only(
                                        bottom: SizeConfig.safeHeight * 0.02),
                                    alignment: Alignment.bottomCenter,
                                  ),
                                ],
                              ),
                      ),
                    );
                  },
                  viewportFraction: 0.9,
                  itemHeight: SizeConfig.safeWidth * 0.5,
                  itemWidth: SizeConfig.safeWidth * 0.5,
                )),
        ],
      ),
    );
  }
}
