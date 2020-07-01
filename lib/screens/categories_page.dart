import 'package:boundless_arts/constants.dart';
import 'package:boundless_arts/util/size_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoriesPage extends StatefulWidget {
  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  final _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: SizeConfig.safeHeight * 0.05),
            height: SizeConfig.safeHeight * 0.2,
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
                    fontSize: SizeConfig.scaleText(20),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.safeWidth * 0.04),
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        child: TextField(
                          onChanged: (value) {},
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
                        padding: EdgeInsets.all(SizeConfig.safeWidth * 0.028),
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
                        child: Icon(
                          Icons.search,
                          color: Colors.white,
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
              crossAxisCount: 3,
              children: (List.generate(18, (index) {
                return FlatButton(
                  onPressed: null,
                  child: Container(
                    height: SizeConfig.safeHeight * 0.4,
                    child: Column(
                      children: <Widget>[
                        Card(
                          child: Container(
                            width: SizeConfig.safeWidth * 0.23,
                            height: SizeConfig.safeHeight * 0.13,
                            child: Image(
                              image: NetworkImage(
                                'http://via.placeholder.com/350x150',
                              ),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Text('category'),
                      ],
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
