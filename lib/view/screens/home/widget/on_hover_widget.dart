import 'package:flutter/material.dart';

class OnHoverWidget extends StatelessWidget {
  final controller;
   OnHoverWidget({Key key, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      child: Row(
        children: [
          MaterialButton(onPressed: (){
            controller.animateTo(
              controller.position.pixels-500,
              duration: Duration(milliseconds: 300),
              curve: Curves.fastOutSlowIn,);
          },
            color: Colors.white,
            elevation: 4.0,
            minWidth: 60,
            height: 85,
            child: Icon(Icons.arrow_back_ios),
          ),
          Spacer(),
          MaterialButton(onPressed:(){
            controller.animateTo(
              controller.position.pixels+500,
              duration: Duration(milliseconds: 300),
              curve: Curves.fastOutSlowIn,);
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
