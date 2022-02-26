import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_grocery/helper/price_converter.dart';
import 'package:flutter_grocery/helper/route_helper.dart';
import 'package:flutter_grocery/localization/language_constrants.dart';
import 'package:flutter_grocery/provider/product_provider.dart';
import 'package:flutter_grocery/provider/splash_provider.dart';
import 'package:flutter_grocery/utill/color_resources.dart';
import 'package:flutter_grocery/utill/dimensions.dart';
import 'package:flutter_grocery/utill/images.dart';
import 'package:flutter_grocery/utill/styles.dart';
import 'package:flutter_grocery/view/base/title_widget.dart';
import 'package:flutter_grocery/view/screens/home/widget/on_hover_affect.dart';
import 'package:flutter_grocery/view/screens/home/widget/on_hover_widget.dart';
import 'package:flutter_grocery/view/screens/product/product_details_screen.dart';
import 'package:provider/provider.dart';

class AmsItemView extends StatelessWidget {
  final ScrollController controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
        builder: (context, productProvider, child) {
      return productProvider.amsItemList != null
          ? Column(children: [
              Padding(
                padding: EdgeInsets.fromLTRB(10, 20, 15, 10),
                child: TitleWidget(
                    title: getTranslated('ams_items', context) ?? " ",
                    onTap: () {
                      Navigator.pushNamed(
                          context, RouteHelper.getAmsItemRoute());
                    }),
              ),
              OnHover(
                builder: (isHover) {
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        height: 330,
                        child: ScrollConfiguration(
                          behavior:
                              ScrollConfiguration.of(context).copyWith(dragDevices: {
                            PointerDeviceKind.touch,
                            PointerDeviceKind.mouse,
                          }),
                          child: Scrollbar(
                            isAlwaysShown: true,
                            // trackVisibility: true,
                            scrollbarOrientation: ScrollbarOrientation.bottom,
                            interactive: true,
                            thickness: 8,
                            controller: controller,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: ListView.builder(
                                controller: controller,
                                itemCount: productProvider.amsItemList.length,
                                // padding: EdgeInsets.symmetric(
                                //     horizontal: Dimensions.PADDING_SIZE_SMALL),
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: EdgeInsets.only(
                                        right: Dimensions.PADDING_SIZE_SMALL),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.of(context).pushNamed(
                                            RouteHelper.getProductDetailsRoute(
                                                productProvider.amsItemList[index].id),
                                            arguments: ProductDetailsScreen(
                                                product:
                                                    productProvider.amsItemList[index],
                                                cart: null));
                                      },
                                      child: Container(
                                        width: 200,
                                        padding: EdgeInsets.all(
                                            Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: Theme.of(context).cardColor,
                                        ),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                height: 150,
                                                width: 200,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  border: Border.all(
                                                      width: 1,
                                                      color:
                                                          ColorResources.getGreyColor(
                                                              context)),
                                                ),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: FadeInImage.assetNetwork(
                                                    placeholder: Images.placeholder,
                                                    width: 100,
                                                    height: 150,
                                                    fit: BoxFit.cover,
                                                    image:
                                                        '${Provider.of<SplashProvider>(context, listen: false).baseUrls.productImageUrl}'
                                                        '/${productProvider.amsItemList[index].image[0]}',
                                                    imageErrorBuilder: (c, o, s) =>
                                                        Image.asset(Images.placeholder,
                                                            width: 80,
                                                            height: 80,
                                                            fit: BoxFit.fill),
                                                  ),
                                                ),
                                              ),
                                              // SizedBox(
                                              //     height: Dimensions
                                              //         .PADDING_SIZE_EXTRA_SMALL),
                                              Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.only(
                                                          bottom: 20.0),
                                                      child: Text(
                                                        productProvider
                                                            .amsItemList[index].name,
                                                        style: poppinsMedium.copyWith(
                                                            fontSize: Dimensions
                                                                .FONT_SIZE_SMALL),
                                                        // maxLines: 1, overflow: TextOverflow.ellipsis,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(
                                                          bottom: 8.0),
                                                      child: Text(
                                                        '${productProvider.amsItemList[index].capacity} ${productProvider.amsItemList[index].unit}',
                                                        style: poppinsRegular.copyWith(
                                                            fontSize: Dimensions
                                                                .FONT_SIZE_EXTRA_SMALL),
                                                        // maxLines: 2,
                                                        // overflow: TextOverflow.ellipsis,
                                                      ),
                                                    ),
                                                    Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color:
                                                                      Colors.green[900],
                                                                  shape: BoxShape
                                                                      .rectangle,
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                    Radius.circular(10),
                                                                  ),
                                                                ),
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(4.0),
                                                                  child: Text(
                                                                    PriceConverter
                                                                        .convertPrice(
                                                                      context,
                                                                      productProvider
                                                                          .amsItemList[
                                                                              index]
                                                                          .price,
                                                                      discount:
                                                                          productProvider
                                                                              .amsItemList[
                                                                                  index]
                                                                              .discount,
                                                                      discountType:
                                                                          productProvider
                                                                              .amsItemList[
                                                                                  index]
                                                                              .discountType,
                                                                    ),
                                                                    style: poppinsBold
                                                                        .copyWith(
                                                                            color: Colors
                                                                                .white,
                                                                            fontSize:
                                                                                Dimensions
                                                                                    .FONT_SIZE_SMALL),
                                                                  ),
                                                                ),
                                                              ),
                                                              productProvider
                                                                          .amsItemList[
                                                                              index]
                                                                          .discount >
                                                                      0
                                                                  ? Text(
                                                                      PriceConverter
                                                                          .convertPrice(
                                                                        context,
                                                                        productProvider
                                                                            .amsItemList[
                                                                                index]
                                                                            .price,
                                                                        discount: productProvider
                                                                            .amsItemList[
                                                                                index]
                                                                            .discount,
                                                                        discountType: productProvider
                                                                            .amsItemList[
                                                                                index]
                                                                            .discountType,
                                                                      ),
                                                                      style: poppinsRegular.copyWith(
                                                                          fontSize:
                                                                              Dimensions
                                                                                  .FONT_SIZE_EXTRA_SMALL,
                                                                          decoration:
                                                                              TextDecoration
                                                                                  .lineThrough,
                                                                          decorationColor:
                                                                              Colors
                                                                                  .black,
                                                                          color: Colors
                                                                              .red),
                                                                    )
                                                                  : SizedBox(),
                                                            ],
                                                          ),
                                                          Container(
                                                            margin: EdgeInsets.all(2),
                                                            alignment: Alignment.center,
                                                            decoration: BoxDecoration(
                                                              border: Border.all(
                                                                  width: 1,
                                                                  color: ColorResources
                                                                          .getHintColor(
                                                                              context)
                                                                      .withOpacity(
                                                                          0.2)),
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                      10),
                                                            ),
                                                            child: Icon(Icons.add,
                                                                size: 20,
                                                                color: Theme.of(context)
                                                                    .primaryColor),
                                                          ),
                                                        ]),
                                                  ]),
                                            ]),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      isHover?OnHoverWidget(controller: controller,):Offstage(),
                    ],
                  );
                }
              ),
            ])
          : SizedBox();
    });
  }
}
