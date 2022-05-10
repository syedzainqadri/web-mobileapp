import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_grocery/provider/banner_provider.dart';
import 'package:flutter_html/shims/dart_ui_real.dart';
import 'package:provider/provider.dart';

class OnHoverWidgetForBanner extends StatelessWidget {
  final CarouselController carouselController;
  int length;
  OnHoverWidgetForBanner({Key key, this.carouselController, this.length})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      child: Row(
        children: [
          MaterialButton(
            onPressed: () {
              print("length is : $length");
              carouselController.animateToPage(
                length > 0 ? length - 1 : length,
                duration: Duration(milliseconds: 200),
              );
            },
            color: Colors.white,
            elevation: 4.0,
            minWidth: 60,
            height: 85,
            child: Icon(Icons.arrow_back_ios),
          ),
          Spacer(),
          MaterialButton(
            onPressed: () {
              carouselController.animateToPage(
                length + 1,
                duration: Duration(milliseconds: 100),
              );
            },
            color: Colors.white,
            elevation: 4.0,
            minWidth: 60,
            height: 85,
            child: Icon(Icons.arrow_forward_ios),
          )
        ],
      ),
    );
  }
}
