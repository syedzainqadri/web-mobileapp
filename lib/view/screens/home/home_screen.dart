import 'package:flutter/material.dart';
import 'package:flutter_grocery/helper/product_type.dart';
import 'package:flutter_grocery/helper/responsive_helper.dart';
import 'package:flutter_grocery/localization/language_constrants.dart';
import 'package:flutter_grocery/provider/banner_provider.dart';
import 'package:flutter_grocery/provider/banner_two_provider.dart';
import 'package:flutter_grocery/provider/category_provider.dart';
import 'package:flutter_grocery/provider/localization_provider.dart';
import 'package:flutter_grocery/provider/product_provider.dart';
import 'package:flutter_grocery/utill/dimensions.dart';
import 'package:flutter_grocery/view/base/main_app_bar.dart';
import 'package:flutter_grocery/view/base/title_widget.dart';
import 'package:flutter_grocery/view/screens/home/widget/banners_view.dart';
import 'package:flutter_grocery/view/screens/home/widget/categories_on_home.dart';
import 'package:flutter_grocery/view/screens/home/widget/category_view.dart';
import 'package:flutter_grocery/view/screens/home/widget/daily_item_view.dart';
import 'package:flutter_grocery/view/screens/home/widget/product_view.dart';
import 'package:provider/provider.dart';
import '../../../data/model/response/category_model.dart';
import '../../../helper/route_helper.dart';
import '../../../provider/theme_provider.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/styles.dart';
import '../category/all_category_screen.dart';
import '../product/category_product_screen.dart';
import 'widget/banners_two_view.dart';
import 'widget/categorylistview.dart';

class HomeScreen extends StatelessWidget {
  Future<void> _loadData(BuildContext context, bool reload) async {
    // await Provider.of<CategoryProvider>(context, listen: false).getCategoryList(context, reload);

    await Provider.of<CategoryProvider>(context, listen: false).getCategoryList(
      context,
      Provider.of<LocalizationProvider>(context, listen: false)
          .locale
          .languageCode,
      reload,
    );
    await Provider.of<BannerProvider>(context, listen: false)
        .getBannerList(context, reload);
    await Provider.of<BannerTwoProvider>(context, listen: false)
        .getBannerTwoList(context, reload);
    await Provider.of<ProductProvider>(context, listen: false).getDailyItemList(
      context,
      reload,
      Provider.of<LocalizationProvider>(context, listen: false)
          .locale
          .languageCode,
    );
    // await Provider.of<ProductProvider>(context, listen: false).getPopularProductList(context, '1', true);
    Provider.of<ProductProvider>(context, listen: false).getPopularProductList(
      context,
      '1',
      reload,
      Provider.of<LocalizationProvider>(context, listen: false)
          .locale
          .languageCode,
    );
  }

  @override
  Widget build(BuildContext context) {
    final ScrollController _scrollController = ScrollController();
    _loadData(context, false);

    return RefreshIndicator(
      onRefresh: () async {
        await _loadData(context, true);
      },
      backgroundColor: Theme.of(context).primaryColor,
      child: Scaffold(
        appBar: ResponsiveHelper.isDesktop(context) ? MainAppBar() : null,
        body: Scrollbar(
          child: SingleChildScrollView(
            // controller: _scrollController,

            child: Container(
              height: 7000,
              padding: EdgeInsets.symmetric(horizontal: 40.0),
              child: Column(
                  // controller: _scrollController,
                  children: [
                    // Category
                    Consumer<CategoryProvider>(
                        builder: (context, category, child) {
                      return category.categoryList == null
                          ? CategoryListView()
                          : category.categoryList.length == 0
                              ? SizedBox()
                              : CategoryListView();
                    }),
                    //banner
                    Consumer<BannerProvider>(
                        builder: (context, banner, child) {
                      return banner.bannerList == null
                          ? BannersView()
                          : banner.bannerList.length == 0
                              ? SizedBox()
                              : BannersView();
                    }),
                    // DailyNeeds
                    Consumer<ProductProvider>(
                        builder: (context, product, child) {
                      return product.dailyItemList == null
                          ? DailyItemView()
                          : product.dailyItemList.length == 0
                              ? SizedBox()
                              : DailyItemView();
                    }),
                    // Banner Two
                    Consumer<BannerTwoProvider>(
                        builder: (context, bannerTwo, child) {
                      return bannerTwo.bannerTwoList == null
                          ? BannerTwoView()
                          : bannerTwo.bannerTwoList.length == 0
                              ? SizedBox()
                              : BannerTwoView();
                    }),
                    //AllCategories with sub Categories
                    Expanded(
                      child: Container(
                        width: 800,
                        child:Consumer<CategoryProvider>(
                          builder: (context, categoryProvider, child) {
                            return categoryProvider.categoryList.length != 0
                                ? ListView.builder(
                                    itemCount: categoryProvider
                                        .categoryList.length,
                                    primary: false,
                                    physics: NeverScrollableScrollPhysics(),
                                    padding: EdgeInsets.all(8.0),
                                    itemBuilder: (context, index) {
                                      CategoryModel _category =
                                      categoryProvider
                                          .categoryList[index];

                                  var category=Provider.of<CategoryProvider>(context,listen: false).subCategoryList;
                                  print("sub categoris list $category");

                                      return HomeCategory(
                                              title: _category.name,
                                              id: _category.id,
                                            );

                                    })
                                : Container(
                                    child: Text('category View'),
                                  );
                          },
                        ),
                      ),
                    ),
                    // Popular Item
                    Padding(
                      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                      child: TitleWidget(
                          title: getTranslated('popular_item', context)),
                    ),
                    ProductView(
                        productType: ProductType.POPULAR_PRODUCT,
                        scrollController: _scrollController),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
