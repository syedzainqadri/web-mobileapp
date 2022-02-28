
import 'package:flutter/material.dart';
import 'package:flutter_grocery/helper/route_helper.dart';
import 'package:flutter_grocery/localization/language_constrants.dart';
import 'package:flutter_grocery/view/base/custom_button.dart';
import 'package:flutter_grocery/view/base/custom_text_field.dart';
class SearchBar extends StatelessWidget {
  final TextEditingController searchControlller;
  final Function() categoryClick;
  const SearchBar({Key key, this.searchControlller, this.categoryClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        MaterialButton(
          onPressed: categoryClick
        ,
          color: Colors.green,
          textColor: Colors.white,
          height: 40.0,
          padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.menu,

            ),
            Text("Categories")


          ],
        ),
        ),
        // SizedBox(width: 20.0,),
        Container(
          height: 35.0,
          width: MediaQuery.of(context).size.width*0.6,
          child: CustomTextField(
            hintText: getTranslated('search', context),
            isShowBorder: true,
            isPassword: false,
            onTap: (){
              Navigator.pushNamed(context, RouteHelper.searchProduct);
            },
            isShowSuffixIcon: true,
            prefixIconUrl: Icons.search,
           suffixIconUrl: Icons.search,
            isShowPrefixIcon: true,
            controller: searchControlller,
            inputAction: TextInputAction.done,
          ),
        ),
        // MaterialButton(onPressed: (){
        //
        // },
        //   color: Colors.green,
        //   textColor: Colors.white,
        //   height: 40.0,
        //   minWidth: 35,
        //   padding: EdgeInsets.all(8),
        //   child:   Icon(
        //     Icons.search,
        //
        //   ),
        // ),

      ],
    );
  }
}
