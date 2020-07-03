import 'package:boundless_arts/util/size_util.dart';
import 'package:flutter/material.dart';
import 'package:boundless_arts/constants.dart';
import 'package:boundless_arts/screens/result_page.dart';

class BottomContainerSheet extends StatefulWidget {
  @override
  _BottomContainerSheetState createState() => _BottomContainerSheetState();
}

class _BottomContainerSheetState extends State<BottomContainerSheet> {
  final _controller = TextEditingController();
  String inputValue;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      color: Color(0xFF757575),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(40), topLeft: Radius.circular(40)),
        ),
        child: Column(
          children: <Widget>[
            Flexible(
              child: TextField(
                autofocus: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  setState(() {
                    inputValue = value;
                  });
                },
                controller: _controller,
                decoration: InputDecoration(
                    hintText: 'Enter your keyword...',
                    fillColor: kPrimaryColor,
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide.none)),
              ),
            ),
            RaisedButton(
                padding: EdgeInsets.symmetric(vertical: 6, horizontal: 15),
                color: kTertiaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                splashColor: Colors.grey,
                onPressed: () {
                  if (inputValue != null) {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) {
                      return ResultsPage(
                        categoryNamePressed: inputValue,
                      );
                    }));
                  }
                },
                child: Text(
                  'Search',
                  style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: SizeConfig.scaleText(20),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
