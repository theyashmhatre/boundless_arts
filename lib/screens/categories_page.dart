import 'package:boundless_arts/constants.dart';
import 'package:boundless_arts/screens/result_page.dart';
import 'package:boundless_arts/services/networking.dart';
import 'package:boundless_arts/util/size_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui';

class CategoriesPage extends StatefulWidget {
  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  final _controller = TextEditingController();
  List<String> imageUrl = [];
  List searchData = [];
  bool show = false;
  String inputValue;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: SizeConfig.safeHeight * 0.05),
            height: SizeConfig.safeHeight * 0.22,
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  'Categories',
                  style: TextStyle(
                    color: kTertiaryColor,
                    fontSize: SizeConfig.scaleText(22),
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Acme',
                    letterSpacing: 1,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.safeWidth * 0.04),
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        child: TextField(
                          onChanged: (value) {
                            setState(() {
                              inputValue = value;
                            });
                          },
                          controller: _controller,
                          decoration: InputDecoration(
                              hintText: 'Search your keyword...',
                              fillColor: kPrimaryColor,
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  borderSide: BorderSide.none)),
                        ),
                      ),
                      SizedBox(width: SizeConfig.safeWidth * 0.02),
                      Container(
                        width: SizeConfig.safeWidth * 0.15,
                        decoration: BoxDecoration(
                            border: Border.all(width: 1),
                            boxShadow: [
                              BoxShadow(
                                color: kTertiaryColor,
                                blurRadius: 0.1,
                              ),
                            ],
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: FlatButton(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return ResultsPage(
                                  categoryNamePressed: inputValue);
                            }));
                          },
                          child: Icon(
                            Icons.search,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
              child: Flexible(
            child: GridView.count(
              mainAxisSpacing: 1,
              crossAxisSpacing: 5,
              crossAxisCount: 3,
              children: (List.generate(categoryName.length, (index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return ResultsPage(
                          categoryNamePressed: categoryName[index]);
                    }));
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Container(
                      height: SizeConfig.safeHeight * 0.1,
                      width: SizeConfig.safeWidth * 0.4,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [kTertiaryColor, Color(0xFF090909)]),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Center(
                          child: Text(
                        categoryName[index],
                        style: TextStyle(
                          color: kPrimaryColor,
                          fontFamily: 'Bitter',
                        ),
                      )),
                    ),
                  ),
                );
              })),
            ),
          )),
        ],
      ),
    );
  }
}
