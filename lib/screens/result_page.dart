import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:boundless_arts/services/networking.dart';
import 'package:boundless_arts/constants.dart';
import 'package:boundless_arts/util/size_util.dart';
import 'full_screen_image.dart';

enum WidgetMarker { list, grid2, grid3 }

class ResultsPage extends StatefulWidget {
  ResultsPage({this.categoryNamePressed});
  final String categoryNamePressed;

  @override
  _ResultsPageState createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  List<String> imageUrl = [];
  List listPhotos = [];
  bool show = false;
  List<String> description = [];
  WidgetMarker selectedWidget = WidgetMarker.list;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  void getData() async {
    print('home getData was called');
    NetworkHelper networkHelper = NetworkHelper(
        'http://api.unsplash.com/search/photos/?client_id=',
        kAccessKey,
        '&query=${widget.categoryNamePressed}');

    print('category $categoryName');
    var searchData1 = await networkHelper.getData();
    listPhotos = searchData1['results'];
    print('photo length - ${listPhotos.length}');
    print('$listPhotos');
    _assign();
    setState(() {
      show = true;
    });
  }

  _assign() {
    for (int i = 0; i < listPhotos.length; i++) {
      imageUrl.add(listPhotos.elementAt(i)['urls']['regular']);
      description.add(listPhotos.elementAt(i)['alt_description']);
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kSecondaryColor,
        centerTitle: true,
        title: Text(
          '${widget.categoryNamePressed[0].toUpperCase()}${widget.categoryNamePressed.substring(1)}',
          style: TextStyle(
            color: kTertiaryColor,
            fontWeight: FontWeight.bold,
            fontSize: SizeConfig.scaleText(22),
            fontFamily: 'Acme',
            letterSpacing: 1,
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(height: SizeConfig.safeHeight * 0.01),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.all(Radius.circular(40))),
                  child: Row(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                            color: selectedWidget == WidgetMarker.list
                                ? kActiveContainer
                                : kInactiveContainer,
                            borderRadius:
                                BorderRadius.all(Radius.circular(40))),
                        child: IconButton(
                          icon: Icon(Icons.photo),
                          iconSize: 20,
                          onPressed: () {
                            setState(() {
                              selectedWidget = WidgetMarker.list;
                            });
                          },
                          splashColor: Colors.cyan,
                          color: selectedWidget == WidgetMarker.list
                              ? kActiveIcon
                              : kInactiveIcon,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: selectedWidget == WidgetMarker.grid2
                                ? kActiveContainer
                                : kInactiveContainer,
                            borderRadius:
                                BorderRadius.all(Radius.circular(40))),
                        child: IconButton(
                          icon: ImageIcon(
                            AssetImage('assets/images/grid2.png'),
                            size: 20,
                            color: selectedWidget == WidgetMarker.grid2
                                ? kActiveIcon
                                : kInactiveIcon,
                          ),
                          iconSize: 20,
                          onPressed: () {
                            setState(() {
                              selectedWidget = WidgetMarker.grid2;
                            });
                          },
                          color: selectedWidget == WidgetMarker.grid2
                              ? kActiveIcon
                              : kInactiveIcon,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: selectedWidget == WidgetMarker.grid3
                                ? kActiveContainer
                                : kInactiveContainer,
                            borderRadius:
                                BorderRadius.all(Radius.circular(40))),
                        child: IconButton(
                          icon: Icon(Icons.grid_on),
                          iconSize: 20,
                          onPressed: () {
                            setState(() {
                              selectedWidget = WidgetMarker.grid3;
                            });
                          },
                          color: selectedWidget == WidgetMarker.grid3
                              ? kActiveIcon
                              : kInactiveIcon,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: SizeConfig.safeWidth * 0.03),
              ],
            ),
          ),
          SizedBox(height: 9),
          Container(
            child: getCustomContainer(),
          ),
        ],
      ),
    );
  }

  Widget getCustomContainer() {
    switch (selectedWidget) {
      case WidgetMarker.list:
        return getListContainer();
      case WidgetMarker.grid2:
        return get2GridContainer();
      case WidgetMarker.grid3:
        return get3GridContainer();
    }
    return getListContainer();
  }

  Widget getListContainer() {
    return Expanded(
      child: ListView.separated(
          itemCount: imageUrl.length,
          separatorBuilder: (BuildContext context, int index) {
            return Container(
              child: SizedBox(height: SizeConfig.safeHeight * 0.01),
            );
          },
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return FullScreenImage(
                    url: imageUrl[index],
                  );
                }));
              },
              child: Container(
                padding: EdgeInsets.all(SizeConfig.safeWidth * 0.02),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: !show
                      ? CircularProgressIndicator()
                      : Column(
                          children: <Widget>[
                            ClipRRect(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20)),
                                child: Image(
                                    image: NetworkImage(imageUrl[index]))),
                            Container(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                '${description.elementAt(index)[0].toUpperCase()}${description.elementAt(index).substring(1)}',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                          ],
                        ),
                ),
              ),
            );
          }),
    );
  }

  Widget get2GridContainer() {
    return Expanded(
      child: GridView.count(
        crossAxisCount: 2,
        children: (List.generate(categoryName.length, (index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return FullScreenImage(
                  url: imageUrl[index],
                );
              }));
            },
            child: Container(
              padding: EdgeInsets.all(SizeConfig.safeWidth * 0.02),
              child: !show
                  ? CircularProgressIndicator()
                  : ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      child: Image(
                        image: NetworkImage(imageUrl[index]),
                        fit: BoxFit.cover,
                      )),
            ),
          );
        })),
      ),
    );
  }

  Widget get3GridContainer() {
    return Expanded(
      child: GridView.count(
        crossAxisCount: 3,
        children: (List.generate(categoryName.length, (index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return FullScreenImage(
                  url: imageUrl[index],
                );
              }));
            },
            child: Container(
              padding: EdgeInsets.all(SizeConfig.safeWidth * 0.02),
              child: !show
                  ? CircularProgressIndicator()
                  : ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      child: Image(
                        image: NetworkImage(imageUrl[index]),
                        fit: BoxFit.cover,
                      )),
            ),
          );
        })),
      ),
    );
  }
}
