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
import 'package:flutter_grocery/view/screens/home/widget/ams_list_view.dart';
import 'package:flutter_grocery/view/screens/home/widget/banners_view.dart';
import 'package:flutter_grocery/view/screens/home/widget/category_view.dart';
import 'package:flutter_grocery/view/screens/home/widget/daily_item_view.dart';
import 'package:flutter_grocery/view/screens/home/widget/product_view.dart';
import 'package:provider/provider.dart';
import 'widget/banners_two_view.dart';
import 'widget/fresh_item_view.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = true;
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
    await Provider.of<CategoryProvider>(context, listen: false).getBrands(
      context,
    );
    await Provider.of<ProductProvider>(context, listen: false).getFreshItemList(
      context,
      reload,
      Provider.of<LocalizationProvider>(context, listen: false)
          .locale
          .languageCode,
    );
    await Provider.of<ProductProvider>(context, listen: false).getAmsItemList(
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

    setState(() {
      isLoading = false;
    });
  }

  var searchController = TextEditingController();

  ScrollController _scrollController;
  @override
  Widget build(BuildContext context) {
    final ScrollController _scrollController = ScrollController();
    _loadData(context, false);
    var weidth = MediaQuery.of(context).size.width;
    final ScrollController _scrollController2 = ScrollController();

    return RefreshIndicator(
      onRefresh: () async {
        await _loadData(context, true);
      },
      backgroundColor: Theme.of(context).primaryColor,
      child: Scaffold(
        appBar: ResponsiveHelper.isDesktop(context) ? MainAppBar() : null,
        body: Scrollbar(
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Center(
              child: SizedBox(
                width: 1170,
                child: Column(
                    // controller: _scrollController,
                    children: [
                      Consumer<BannerProvider>(
                          builder: (context, banner, child) {
                        return banner.bannerList == null
                            ? BannersView()
                            : banner.bannerList.length == 0
                                ? SizedBox()
                                : BannersView();
                      }),
                      // Category
                      Consumer<CategoryProvider>(
                          builder: (context, category, child) {
                        return category.categoryList == null
                            ? CategoryView()
                            : category.categoryList.length == 0
                                ? SizedBox()
                                : CategoryView();
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
                      // daily item view
                      Provider.of<ProductProvider>(context, listen: false)
                                  .dailyItemList ==
                              null
                          ? Container(height: 340, child: DailyItemView())
                          : Provider.of<ProductProvider>(context, listen: false)
                                      .dailyItemList
                                      .length ==
                                  0
                              ? SizedBox()
                              : Container(height: 382, child: DailyItemView()),
                      // Ams Item View
                      Provider.of<ProductProvider>(context, listen: false)
                                  .amsItemList ==
                              null
                          ? AmsItemView()
                          : Provider.of<ProductProvider>(context, listen: false)
                                      .amsItemList
                                      .length ==
                                  0
                              ? SizedBox()
                              : AmsItemView(),

                      // Fresh Items

                      Provider.of<ProductProvider>(context, listen: false)
                                  .freshItemList ==
                              null
                          ? FreshItemView()
                          : Provider.of<ProductProvider>(context, listen: false)
                                      .freshItemList
                                      .length ==
                                  0
                              ? SizedBox()
                              : FreshItemView(),

                      // Popular Item
                      // Popular Item
                      Padding(
                        padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                        child: TitleWidget(
                            title: getTranslated('popular_item', context)),
                      ),
                      ProductView(
                          productType: ProductType.POPULAR_PRODUCT,
                          scrollController: _scrollController2),
                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
