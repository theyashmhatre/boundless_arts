import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:boundless_arts/util/size_util.dart';
import 'package:boundless_arts/screens/full_screen_image.dart';

class SwiperWidget extends StatelessWidget {
  SwiperWidget({
    @required this.photosData,
    @required this.imgUrl,
    @required this.showing,
    @required this.description,
  });

  final List photosData;
  final List<String> imgUrl;
  final bool showing;
  final List<String> description;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Swiper(
      scrollDirection: Axis.horizontal,
      loop: false,
      itemCount: photosData.length,
      scale: 0.9,
      control: SwiperControl(),
      itemBuilder: (BuildContext context, int index) {
        return FlatButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
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
                          image: NetworkImage('${imgUrl.elementAt(index)}'),
                          fit: BoxFit.cover,
                          height: SizeConfig.safeHeight * 0.6,
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                                Radius.circular(SizeConfig.safeWidth * 0.03)),
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
                          padding: EdgeInsets.all(SizeConfig.scaleText(6)),
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
    ));
  }
}
