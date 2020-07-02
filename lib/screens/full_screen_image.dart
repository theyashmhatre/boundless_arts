import 'package:boundless_arts/constants.dart';
import 'package:flutter/material.dart';

class FullScreenImage extends StatelessWidget {
  FullScreenImage({@required this.url});
  final String url;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: url == null
          ? CircularProgressIndicator()
          : Image(
              image: NetworkImage(url),
              fit: BoxFit.scaleDown,
              height: double.infinity,
              width: double.infinity,
              alignment: Alignment.center,
            ),
    );
  }
}
