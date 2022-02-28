import 'package:flutter/material.dart';
List<String> brands=[
"  Unilever (124)",

"  WBM (118)",

"  Reckitt (113)",

"  National (100)",

"  Hilal Care (99)",

"  Nestle (87)",

"  Shan-Foods (75)",

"  Reckitt-Health (60)",

"  Mitchell's (55)",

"  Dawn Foods (50)",

"  Bold (46)",

"  Nivea (43)",

"  RB Hygiene Home (40)",

 " Bake-Parlor (40)",

  "K&N's (39)",

 " Dawn Bread (39)",

"  Bunnys (39)",

"  Shangrila (38)",

"  Sabroso (38)",

"  Shezan (34)",

"  Dettol (34)",

"  Giggly (34)",

"  Peek-Freans (33)",

"  American-Garden (32)",

"  LU (32)"
,
"  Kausar (31)",

 " Kolson (30)",

"  Veet (29)",

"  Colgate (29)",

"  Youngs (29)",

"  Food-Net (29)",

 " Dove By Unilever (28)",

"  LifeBuoy (26)",

"  Marhaba (26)",

"  Spontex (24)",

"  Kiwi (23)",
"  Happy Cow (22)",

"  Canbebe (22)",

"  Tresemme (22)",

"  Scotch-Brite (22)",

"  Guard-Rice (22)",

"  Mundial (22)",

"  Fruitien (21)",

"  Scrub-Shine (21)",

"  Super-Crisp (21)",

"  Sunsilk (20)",

" Hilal (20)",

"  Marios (20)",

"  Astonish (20)",

"  Dalda (19)"
] ;
class Footer extends StatelessWidget {
  const Footer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        margin: EdgeInsets.all(15),
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            topHeading(text: "Akbari Mandi Online aims to deliver happiness by trying to be the best in following 3 things.")
         ,SizedBox(height:15.0),

            Divider(color: Colors.grey.shade200,height: 1,),
            SizedBox(height: 20,),
           tile(
             icon: Icons.monetization_on_outlined,
             title: "Best Prices & Offers",
             subTitle: "Cheaper prices than your local supermarket, great cashback offers to top it off."
           ),
            SizedBox(height: 20,),
            tile(
                icon: Icons.panorama_wide_angle,
                title: "Wide Assortment",
                subTitle: "Choose from 5000+ products across food, personal care, household & other categories."
            ),
            SizedBox(height: 20,),
            tile(
                icon: Icons.assignment_return,
                title: "Easy Returns",
                subTitle: "Not satisfied with a product? Return it at the doorstep & get a refund within hours."
            ),
            SizedBox(height: 20,),
            Divider(color: Colors.grey.shade200,height: 1,),
            SizedBox(height: 20,),
            topHeading(text: "Categories"),
            SizedBox(height: 80,),
            Divider(color: Colors.grey.shade300,height: 1,),
            SizedBox(height: 20,),
            topHeading(text: "Top Brands"),

            SizedBox(height: 80,),
            Divider(color: Colors.grey.shade300,height: 1,),
            SizedBox(height: 20,),
            topHeading(text: "Useful Links"),

            SizedBox(height: 80,),
            Divider(color: Colors.grey.shade300,height: 1,),
            SizedBox(height: 20,),
            topHeading(text: "GrocerApp - Online Grocery Shopping"),
            SizedBox(height: 15,),
            normalText(text: "GrocerApp makes shopping easier and more convenient than ever."),

            SizedBox(height: 15,),
            subHeading(text: "Online grocery store in Pakistan"),
            normalText(text: "Order online. All your favourite products from the low price online supermarket for grocery home delivery in Lahore, Pakistan. Best experience guaranteed."),

            SizedBox(height: 15,),
            subHeading(text: "One stop shop for all your daily needs"),
            normalText(text: "GrocerApp is a low-price online supermarket that allows you to order products across categories like grocery, vegetables, beauty & wellness, household care, baby care, pet care and meats & seafood and gets them delivered to your doorstep."),



            SizedBox(height: 15,),
            subHeading(text: "For best of prices, deals and offers; order online in Lahore, Islamabad, Rawalpindi and Faisalabad"),
            normalText(text: "The delivery service is operational in all areas of Lahore: Ravi, Shalimar, Data Gunj Bakhsh, Samanabad, Gulberg, Allama Iqbal, Nishtar, Pak arab society, Bahria town, SA Gardens, DHA 1 to 7, wapda town, Capital Housing, Cantt and all other areas, Islamabad: Pakistan Secretariat Diplomatic Enclave A-17, Islamabad A-18, Islamabad B-17, Islamabad B-18, Islamabad C-15, Islamabad C-16, Islamabad"),

            SizedBox(height: 15,),
            subHeading(text: "Payment Options"),
            normalText(text: "Credit and Debit Cards, Cash on Delivery (COD) and EasyPaisa (Coming Soon)"),
            SizedBox(height: 15,),
            normalText(text: "info@grocerapps.com, 042111476237 \n "
                "Peco Rd, 110 - M Quaid e Azam Industrial Estate, Lahore, Punjab \n"
                "© GrocerApp Pakistan Pvt. Ltd., 2016-2021"),

          ],
        ),
      ),
    );
  }

  Widget tile({icon,title,subTitle}){
   return ListTile(
     leading: Icon(
       icon,
       size: 20,
       color: Colors.grey.shade700,
     ),
     title: Text(
       title,
       style: TextStyle(
         fontSize: 16.0,
         color: Colors.grey.shade900
       ),
     ),
     subtitle: Text(
       subTitle,
       style: TextStyle(
           fontSize: 13.0,
           color: Colors.grey.shade700
       ),
     ),
   );
  }

  Widget topHeading({text}){
    return Text(
      text,
      style: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w600,
        color: Colors.grey.shade900
      ),
    );
  }

  Widget subHeading({text}){
    return Text(
      text,
      style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w500,
          color: Colors.grey.shade800
      ),
    );
  }

  normalText({text}){
    return  Text(
      text,
      style: TextStyle(
        color: Colors.grey.shade700,
        fontSize: 14
      ),
    );
  }
}
