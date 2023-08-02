import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hire_pro/constants.dart';

class StarRatingBar extends StatelessWidget {
  final double rating;
  final double size;
  int? ratingCount;
  StarRatingBar({required this.rating, this.ratingCount, this.size = 35});

  @override
  Widget build(BuildContext context) {
    List<Widget> _starList = [];
    int realNumber = rating.floor();
    int partNumber = ((rating - realNumber) * 10).ceil();

    for(int i = 0; i < 5; i++){
      if(i < realNumber){
        _starList.add(Icon(Icons.star, color: kMainYellow,size: size,));
      }else if (i == realNumber){
        _starList.add(SizedBox(
          height: size,
          width: size,
          child: Stack(
            children: [
              Icon(Icons.star, color: kMainYellow,size: size,),
              ClipRect(clipper: _Clipper(part: partNumber),
              child: Icon(Icons.star, color: Colors.grey,size: size,),),

            ],
          ),
        ));
      }else{
        _starList.add(Icon(Icons.star, color: Colors.grey,size: size,));
      }
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: _starList,
    );
  }
}

class _Clipper extends CustomClipper<Rect> {
  final int part;
  _Clipper({required this.part});

  @override
  Rect getClip( Size size) {
    // TODO: implement getClip
    return Rect.fromLTRB((size.width/10)*part, 0.0, size.width, size.height);
    throw UnimplementedError();
  }

  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) => true;
}