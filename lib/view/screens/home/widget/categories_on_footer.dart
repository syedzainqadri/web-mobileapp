import 'package:flutter/material.dart';
import 'package:flutter_grocery/data/model/response/category_model.dart';
import 'package:flutter_grocery/helper/route_helper.dart';
import 'package:flutter_grocery/provider/category_provider.dart';
import 'package:flutter_grocery/provider/localization_provider.dart';
import 'package:flutter_grocery/utill/dimensions.dart';
import 'package:flutter_grocery/utill/styles.dart';
import 'package:flutter_grocery/view/screens/product/category_product_screen.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class FooterCategories extends StatefulWidget {
  final String title;
  final int id;
  const FooterCategories({Key key, this.title, this.id}) : super(key: key);

  @override
  State<FooterCategories> createState() => _FooterCategoriesState();
}

class _FooterCategoriesState extends State<FooterCategories> {
  bool isLoading = true;
  var category;

  loadData() async {
    await Provider.of<CategoryProvider>(context, listen: false)
        .getSubCategoryList(
      context,
      widget.id.toString(),
      Provider.of<LocalizationProvider>(context, listen: false)
          .locale
          .languageCode,
    );
    setState(() {
      category =
          Provider.of<CategoryProvider>(context, listen: false).subCategoryList;
      isLoading = false;
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
    var width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: poppinsBold.copyWith(
              fontSize: Dimensions.FONT_SIZE_SMALL,
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Container(
            color: Colors.white,
            child: isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : category != null || category != []
                    ? Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: MasonryGridView.count(
                          crossAxisCount: width > 1100
                              ? 7
                              : width > 800
                                  ? 5
                                  : width > 600
                                      ? 4
                                      : 3,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: category.length,
                          mainAxisSpacing: 5,
                          crossAxisSpacing: 5,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                  RouteHelper.getCategoryProductsRoute(
                                    category[index].id,
                                  ),
                                  arguments: CategoryProductScreen(
                                      categoryModel: CategoryModel(
                                    id: category[index].id,
                                    name: category[index].name,
                                  )),
                                );
                              },
                              child: Text(
                                 category[index].name,
                                  // categoryProvider.categorySelectedIndex ==
                                  //     index,
                                  ),
                            );
                          },
                        ),
                      )
                    : Text("No Sub Categories For This Category"),
          )
        ],
      ),
    );
  }
}
