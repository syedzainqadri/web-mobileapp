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
import 'package:flutter_grocery/view/screens/home/widget/daily_item_view.dart';
import 'package:flutter_grocery/view/screens/home/widget/footer.dart';
import 'package:flutter_grocery/view/screens/home/widget/product_view.dart';
import 'package:flutter_grocery/view/screens/home/widget/search_bar.dart';
import 'package:provider/provider.dart';
import '../../../data/model/response/category_model.dart';
import '../../../helper/route_helper.dart';
import 'widget/ams_item_view.dart';
import 'widget/banners_two_view.dart';
import 'widget/categorylistview.dart';
import 'widget/fresh_item_view.dart';
import 'package:flutter/material.dart';

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
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
  _loadData(context, false);
  setState(() {
    isLoading=false;
  });
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    _scrollController = ScrollController(initialScrollOffset: 0.0);
    var weidth = MediaQuery.of(context).size.width;

    final ScrollController _scrollController2 = ScrollController();
    // _loadData(context, false);

    return isLoading?Center(child: CircularProgressIndicator(),):RefreshIndicator(
      onRefresh: () async {
        await _loadData(context, true);
      },
      backgroundColor: Theme.of(context).primaryColor,
      child: Scaffold(
          appBar: ResponsiveHelper.isDesktop(context) ? MainAppBar() : null,
          body: Scrollbar(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Container(
                // height: 7000,
                padding: EdgeInsets.symmetric(
                    horizontal: weidth > 800 ? weidth * 0.14 : 40),
                child: Column(children: [
                  Container(
                      height: 70.0,
                      child: SearchBar(
                        searchControlller: searchController,
                        categoryClick: () {
                          Navigator.pushNamed(context, RouteHelper.categorys);
                        },
                      )),
                  //categories
                  Provider.of<CategoryProvider>(context, listen: false).categoryList == null
                      ? Container(height: 335, child: CategoryListView())
                      :  Provider.of<CategoryProvider>(context, listen: false).categoryList.length == 0
                      ? SizedBox()
                      : Container(
                      height: 335, child: CategoryListView(
                  )),

                  //banner
                  Provider.of<BannerProvider>(context, listen: false).bannerList == null
                      ? BannersView()
                      : Provider.of<BannerProvider>(context, listen: false).bannerList.length == 0
                      ? SizedBox()
                      : BannersView(),

                  // daily item view
                  Provider.of<ProductProvider>(context, listen: false).dailyItemList == null
                      ? Container(height: 340, child: DailyItemView())
                      :  Provider.of<ProductProvider>(context, listen: false).dailyItemList.length == 0
                      ? SizedBox()
                      : Container(height: 382, child: DailyItemView()),

                  // Banner Two
                  Provider.of<BannerTwoProvider>(context, listen: false).bannerTwoList == null
                      ? BannerTwoView()
                      :   Provider.of<BannerTwoProvider>(context, listen: false).bannerTwoList.length == 0
                      ? SizedBox()
                      : BannerTwoView(),

                  // Akbari Mandi Special

                  Provider.of<ProductProvider>(context, listen: false).amsItemList == null
                      ? AmsItemView()
                      : Provider.of<ProductProvider>(context, listen: false).amsItemList.length == 0
                      ? SizedBox()
                      : AmsItemView(),

                  // Fresh Items

                  Provider.of<ProductProvider>(context, listen: false).freshItemList == null
                      ? FreshItemView()
                      :  Provider.of<ProductProvider>(context, listen: false).freshItemList.length == 0
                      ? SizedBox()
                      : FreshItemView(),

                  //All Categories with sub Categories
                  Container(
                    padding: EdgeInsets.all(10),
                    // padding: EdgeInsets.symmetric(
                    //     horizontal: weidth > 1150
                    //         ? weidth * 0.08
                    //         : weidth > 1000
                    //             ? weidth * 0.05
                    //             : 8),

                    child:Provider.of<CategoryProvider>(context, listen: false).categoryList==null?
                    SizedBox():
                    Provider.of<CategoryProvider>(context, listen: false).categoryList.length == 0
                            ?SizedBox(): ListView.builder(
                                itemCount: Provider.of<CategoryProvider>(context, listen: false).categoryList.length,
                                primary: false,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.all(4.0),
                                itemBuilder: (context, index) {
                                  CategoryModel _category =
                                  Provider.of<CategoryProvider>(context, listen: false).categoryList[index];

                                  var category = Provider.of<CategoryProvider>(
                                          context,
                                          listen: false)
                                      .subCategoryList;
                                  print("sub categoris list $category");

                                  return HomeCategory(
                                    title: _category.name,
                                    id: _category.id,
                                  );
                                }),


                  ),
                  // Popular Item
                  Padding(
                    padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                    child: TitleWidget(
                        title: getTranslated('popular_item', context)),
                  ),
                  ProductView(
                      productType: ProductType.POPULAR_PRODUCT,
                      scrollController: _scrollController2),
                  //Footer
                  isLoading
                      ? CircularProgressIndicator()
                      : Footer(
                          categoriesList: Provider.of<CategoryProvider>(context,
                                  listen: false)
                              .categoryList,
                          brandsList: Provider.of<CategoryProvider>(context,
                                  listen: false)
                              .brands,
                        )
                ]),
              ),
            ),
          ),
          floatingActionButton:
              // _scrollController.hasClients?_scrollController.position.pixels<800 ?Offstage():
              FloatingActionButton(
            child: Icon(Icons.keyboard_arrow_up_outlined),
            backgroundColor: Colors.green,
            onPressed: () {
              _scrollController.animateTo(
                0.0,
                duration: Duration(milliseconds: 300),
                curve: Curves.fastOutSlowIn,
              );
            },
          )
          // :Offstage(),
          ),
    );
  }
}
