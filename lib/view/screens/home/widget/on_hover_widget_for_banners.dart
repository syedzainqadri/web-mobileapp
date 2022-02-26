import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_grocery/provider/banner_provider.dart';
import 'package:flutter_html/shims/dart_ui_real.dart';
import 'package:provider/provider.dart';

class OnHoverWidgetForBanner extends StatelessWidget {
  final CarouselController currentIndex;
   int length;
   OnHoverWidgetForBanner({Key key, this.currentIndex, this.length}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      child: Row(
        children: [
          MaterialButton(onPressed: (){
            currentIndex.animateToPage(
                length-1,
              duration: Duration(milliseconds: 200),
            );
           // if(Provider.of<BannerProvider>(context, listen: false).currentIndex>(0)){
           //   Provider.of<BannerProvider>(context, listen: false).setCurrentIndex( Provider.of<BannerProvider>(context, listen: false).currentIndex-1);
           // }
          },
            color: Colors.white,
            elevation: 4.0,
            minWidth: 60,
            height: 85,
            child: Icon(Icons.arrow_back_ios),
          ),
          Spacer(),
          MaterialButton(onPressed:(){

            currentIndex.animateToPage(
              length+1,
              duration: Duration(milliseconds: 100),
            );
            // currentIndex.nextPage(
            //   duration: Duration(milliseconds: 200),
            // );
            // if(Provider.of<BannerProvider>(context, listen: false).currentIndex<(Provider.of<BannerProvider>(context, listen: false).bannerList.length)){
            //   Provider.of<BannerProvider>(context, listen: false).setCurrentIndex(  Provider.of<BannerProvider>(context, listen: false).currentIndex+1);
            // }
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
