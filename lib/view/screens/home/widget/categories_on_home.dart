import 'package:flutter/material.dart';
import 'package:flutter_grocery/data/model/response/category_model.dart';
import 'package:flutter_grocery/provider/category_provider.dart';
import 'package:flutter_grocery/provider/localization_provider.dart';
import 'package:flutter_grocery/view/screens/category/all_category_screen.dart';
import 'package:provider/provider.dart';

class HomeCategory extends StatefulWidget {
  final  String title;
  final int id;
  const HomeCategory({Key key, this.title, this.id}) : super(key: key);

  @override
  State<HomeCategory> createState() => _HomeCategoryState();
}

class _HomeCategoryState extends State<HomeCategory> {
  bool isLoading=true;
  var category;

  loadData() async{
    await Provider.of<CategoryProvider>(context, listen: false).getSubCategoryList(
      context,
      widget.id.toString(),
      Provider.of<LocalizationProvider>(context, listen: false)
          .locale
          .languageCode,

    );
    setState(() {
      category=Provider.of<CategoryProvider>(context,listen: false).subCategoryList;
      isLoading=false;
    });
  }
@override
  void initState() {
    // TODO: implement initState
  loadData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.only(top: 10.0),
      child: Card(
        elevation: 6.0,

        child: Column(
              children: [
                Container(
                  color: Colors.yellow.shade200,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(vertical: 15.0,horizontal: 10.0),
                  child:Text(
                    widget.title
                  ),
                ),
                 Container(
                   color:Colors.blueGrey,
                   height: category.length>8?300:category.length>16?600:1000,
                   child:  isLoading?Center(child: CircularProgressIndicator(),):category!=null || category!=[]?GridView.builder(
                     scrollDirection: Axis.horizontal,
                     // itemCount: titles.length,
                     itemCount: category.length,
                     itemBuilder: (context,index){


                       return InkWell(
                         onTap: () {
                           // categoryProvider.changeSelectedIndex(index);
                           // categoryProvider.getSubCategoryList(
                           //     context,
                           //     _category.id.toString(),
                           //     Provider.of<LocalizationProvider>(context,
                           //         listen: false)
                           //         .locale
                           //         .languageCode);
                         },
                         child: CategoryItem(
                           title: category[index].name,
                           icon: category[index].image,
                           isSelected:false
                           // categoryProvider.categorySelectedIndex ==
                           //     index,
                         ),
                       );

                     },
                     gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                       crossAxisSpacing: 10.0,
                       mainAxisSpacing: 10.0,
                       crossAxisCount: 2

                       // crossAxisCount: width>800?1:width>600?2:3,
                       // mainAxisExtent: width>800?width*0.15:width>600?width*0.3:width*0.5,
                     ),


                   ):Text("No Sub Categories For This Category"),
                 )

              ],
            ),

      ),
    );
  }
}
