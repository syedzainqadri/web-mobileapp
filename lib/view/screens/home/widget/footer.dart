import 'package:flutter/material.dart';

import 'package:flutter_grocery/helper/route_helper.dart';

import 'package:flutter_grocery/view/screens/home/widget/categories_on_footer.dart';

class Footer extends StatefulWidget {
  final categoriesList;
  final brandsList;

  const Footer({Key key, this.categoriesList, this.brandsList})
      : super(key: key);

  @override
  State<Footer> createState() => _FooterState();
}

class _FooterState extends State<Footer> {
  bool isLoading = true;
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      child: Card(
        child: Container(
          margin: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              topHeading(
                  text:
                      "Akbari Mandi Online aims to deliver happiness by trying to be the best in following 3 things."),
              SizedBox(height: 15.0),

              Divider(
                color: Colors.grey.shade200,
                height: 1,
              ),
              SizedBox(
                height: 20,
              ),
              tile(
                  icon: Icons.monetization_on_outlined,
                  title: "Best Prices & Offers",
                  subTitle:
                      "Cheaper prices than your local supermarket, great cashback offers to top it off."),
              SizedBox(
                height: 20,
              ),
              tile(
                  icon: Icons.panorama_wide_angle,
                  title: "Wide Assortment",
                  subTitle:
                      "Choose from 5000+ products across food, personal care, household & other categories."),
              SizedBox(
                height: 20,
              ),
              tile(
                  icon: Icons.assignment_return,
                  title: "Easy Returns",
                  subTitle:
                      "Not satisfied with a product? Return it at the doorstep & get a refund within hours."),
              SizedBox(
                height: 20,
              ),
              Divider(
                color: Colors.grey.shade200,
                height: 1,
              ),
              SizedBox(
                height: 20,
              ),
              topHeading(text: "Categories"),
              SizedBox(
                height: 20,
              ),

              Wrap(
                direction: Axis.horizontal,
                spacing: 10.0,
                runSpacing: 10.0,
                children: List.generate(
                    widget.categoriesList.length,
                    (index) => FooterCategories(
                          title: widget.categoriesList[index].name,
                          // id: widget.categoriesList[index].id,
                        )),
              ),
              SizedBox(
                height: 10.0,
              ),
              Divider(
                color: Colors.grey.shade300,
                height: 1,
              ),
              SizedBox(
                height: 20,
              ),
              topHeading(text: "Top Brands"),
              // FooterBrands(),
              Container(
                child: Wrap(
                  spacing: 10.0,
                  runSpacing: 10.0,
                  direction: Axis.horizontal,
                  children: List.generate(
                      widget.brandsList.length,
                      (index) =>
                          normalText(text: widget.brandsList[index].brandName)),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Divider(
                color: Colors.grey.shade300,
                height: 1,
              ),
              SizedBox(
                height: 20,
              ),
              topHeading(text: "Useful Links"),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, RouteHelper.getPolicyRoute());
                },
                child: normalText(text: "privacy_policy"),
              ),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, RouteHelper.getTermsRoute());
                },
                child: normalText(text: "terms_and_condition"),
              ),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, RouteHelper.getAboutUsRoute());
                },
                child: normalText(text: "about_us"),
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                color: Colors.grey.shade300,
                height: 1,
              ),
              SizedBox(
                height: 20,
              ),
              topHeading(text: "Akbarimandi -From Mandi to your door step"),
              SizedBox(
                height: 15,
              ),
              normalText(
                  text:
                      "Akbarimandi makes shopping easier and more convenient than ever."),

              SizedBox(
                height: 15,
              ),
              subHeading(text: "Online grocery store in Pakistan"),
              normalText(
                  text:
                      "Order online. All your favourite products from the low price online supermarket for grocery home delivery in Lahore, Pakistan. Best experience guaranteed."),

              SizedBox(
                height: 15,
              ),
              subHeading(text: "One stop shop for all your daily needs"),
              normalText(
                  text:
                      "GrocerApp is a low-price online supermarket that allows you to order products across categories like grocery, vegetables, beauty & wellness, household care, baby care, pet care and meats & seafood and gets them delivered to your doorstep."),

              SizedBox(
                height: 15,
              ),
              normalText(
                  text: "akbarimandionlin@gmail.com, +92-304-1110055 \n "
                      "House-304, Street-A1, MADR-E-MILLAT ROAD TOWN SHIP LAHORE \n"
                      "Al-Hajvery Coorporation, 2016-2021"),
            ],
          ),
        ),
      ),
    );
  }

  Widget tile({icon, title, subTitle}) {
    return ListTile(
      leading: Icon(
        icon,
        size: 20,
        color: Colors.grey.shade700,
      ),
      title: Text(
        title,
        style: TextStyle(fontSize: 16.0, color: Colors.grey.shade900),
      ),
      subtitle: Text(
        subTitle,
        style: TextStyle(fontSize: 13.0, color: Colors.grey.shade700),
      ),
    );
  }

  Widget topHeading({text}) {
    return Text(
      text,
      style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w600,
          color: Colors.grey.shade900),
    );
  }

  Widget subHeading({text}) {
    return Text(
      text,
      style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w500,
          color: Colors.grey.shade800),
    );
  }

  normalText({text}) {
    return Text(
      text,
      style: TextStyle(color: Colors.grey.shade700, fontSize: 14),
    );
  }
}
