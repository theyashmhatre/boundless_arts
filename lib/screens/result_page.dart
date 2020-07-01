import 'package:flutter/material.dart';

class ResultsPage extends StatelessWidget {
  ResultsPage(this.imageUrl);
  final List<String> imageUrl;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(itemBuilder: (BuildContext context, int index) {
        return Container(
          child: Image(image: NetworkImage(imageUrl[index])),
        );
      }),
    );
  }
}
