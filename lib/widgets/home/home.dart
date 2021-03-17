import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:ipackage/localization/localizationValues.dart';
import 'package:ipackage/modules/my_icons.dart';
import 'package:ipackage/widgets/home/special_foreign_offers.dart';
import 'package:ipackage/widgets/home/special_offers.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final double screenHeight =
        MediaQuery.of(context).size.height - statusBarHeight - kToolbarHeight;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 50,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 40, right: 8.0, left: 18.0, bottom: 8.0),
                      child: GFButton(
                        color: Color(0xffA57432),
                        textColor: Colors.white,
                        text:
                            getTranslated(context, 'home_national_tourism_btn'),
                        size: 50.0,
                        textStyle: TextStyle(
                          fontSize: 16.0,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 50,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 40, right: 18.0, left: 8.0, bottom: 8.0),
                      child: GFButton(
                        color: Color(0xffF8CB4E),
                        textColor: Colors.white,
                        text: getTranslated(
                            context, 'home_international_tourism_btn'),
                        size: 50.0,
                        textStyle: TextStyle(
                          fontSize: 16.0,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 50,
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: GFButton(
                        color: Color(0xff07898B),
                        textColor: Colors.white,
                        text: getTranslated(context, 'home_ambassadors_btn'),
                        size: 50.0,
                        textStyle: TextStyle(
                          fontSize: 16.0,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ],
              ),

              Container(
                padding: const EdgeInsets.only(top: 35.0),
                child: Text(
                  getTranslated(context, 'home_national_tourism_offers_label'),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    getTranslated(
                        context, 'home_national_tourism_offers_label_2'),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
              ),

              SpecialOffers(),

              Container(
                padding: const EdgeInsets.only(top: 55.0 , bottom: 10.0 , right: 8 , left: 8),
                child: Text(
                  getTranslated(context, 'home_ambassadors_label'),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              Container(
                child: Padding(
                  padding: const EdgeInsets.only(top: 15.0 , bottom: 10.0 , right: 15 , left: 15),
                  child: Text(
                    getTranslated(
                        context, 'home_ambassadors_label_2'),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
              ),

              Container(
                child: Padding(
                  padding: const EdgeInsets.only(top: 5.0 , bottom: 15.0 , right: 15 , left: 15),
                  child: Text(
                    getTranslated(
                        context, 'home_ambassadors_label_3'),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
              ),

              Container(
                child: Padding(
                  padding: const EdgeInsets.only(top: 15.0 , bottom: 15.0 , right: 15 , left: 15),
                  child: Image.asset(
                    'assets/images/group.jpg',
                    fit: BoxFit.fill,
                    width: screenWidth * 0.88,
                    height: screenHeight * 0.5,
                  ),
                ),
              ),

              Container(
                padding: const EdgeInsets.only(top: 55.0 , bottom: 10.0 , right: 8 , left: 8),
                child: Text(
                  getTranslated(context, 'home_popular_foreign_label'),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              Container(
                child: Padding(
                  padding: const EdgeInsets.only(top: 15.0 , bottom: 10.0 , right: 15 , left: 15),
                  child: Text(
                    getTranslated(
                        context, 'home_popular_foreign_label_2'),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
              ),

              SpecialForeignOffers(),

              Container(
                padding: const EdgeInsets.only(top: 55.0 , bottom: 10.0 , right: 8 , left: 8),
                child: Text(
                  getTranslated(context, 'home_help_label'),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              Row(
                children: <Widget>[
                  Container(
                    width: screenWidth * 0.5,
                    height: screenHeight * 0.4,
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {},
                      child: InkWell(
                        borderRadius: BorderRadius.circular(4.0),
                        onTap: () {},
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          clipBehavior: Clip.antiAlias,
                          elevation: 0.5,
                          margin: const EdgeInsets.all(0.0),
                          color: Colors.white,
                          child: Column(
                            // crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(0),
                                child:
                                  Image.asset('assets/icons/payment.png',),
                              ),

                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  getTranslated(
                                      context, 'home_payment_choices_title'),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                  softWrap: true,
                                ),
                              ),

                              Container(
                                color: Colors.white,
                                margin: const EdgeInsets.all(8.0),
                                padding: const EdgeInsets.all(0.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      flex: 50,
                                      child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 0.0,
                                              right: 8.0,
                                              left: 0.0,
                                              bottom: 0.0),
                                          child: Text(
                                            getTranslated(context,
                                                'home_offer_card_days'),
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                                color: Colors.black),
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        unselectedItemColor: Color(0xff9FD0D2),
        selectedItemColor: Color(0xff07898B),
        onTap: null, // new
        currentIndex: 0,
        type: BottomNavigationBarType.fixed, // new
        items: [
          new BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: getTranslated(
                context, 'bottom_bar_home_btn'),
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: getTranslated(
                context, 'bottom_bar_trip_plan_btn'),
          ),
          new BottomNavigationBarItem(
              icon: Icon(MyIcons.basket),
              label: getTranslated(
                  context, 'bottom_bar_my_reservations_btn'),),
          new BottomNavigationBarItem(icon: Icon(Icons.settings),
              label: getTranslated(
                  context, 'bottom_bar_settings_btn'),),
        ],
      ),
    );
  }
}
