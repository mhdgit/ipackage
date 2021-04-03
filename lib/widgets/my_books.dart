import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:ipackage/localization/localizationValues.dart';
import 'package:ipackage/modules/my_icons.dart';
import 'package:ipackage/widgets/home/domestic_offer_main.dart';
import 'package:ipackage/widgets/home/home.dart';
import 'package:ipackage/widgets/plan_your_trip/plan_your_trip.dart';
import 'package:ipackage/widgets/settings.dart';

class MyBooks extends StatefulWidget {
  @override
  _MyBooksState createState() => _MyBooksState();
}

class _MyBooksState extends State<MyBooks> {
  @override
  Widget build(BuildContext context) {

    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final double screenHeight =
        MediaQuery.of(context).size.height - statusBarHeight - kToolbarHeight;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

          Row(
            children: [
              Container(
                width: screenWidth * 0.84,
                padding: EdgeInsetsDirectional.only(
                    start: screenWidth * 0.08, top: 20.0, bottom: 10.0),
                child: Row(
                  children: [
                    Flexible(
                      child: Text(
                        getTranslated(context, 'my_reservations_title'),
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          Padding(
            padding: EdgeInsetsDirectional.only(
                start: screenWidth * 0.06, top: 8.0, bottom: 20.0),
            child: Container(
              height: screenHeight * 0.65,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  Container(
                    width: screenWidth * 0.6,
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {},
                      child: InkWell(
                        borderRadius: BorderRadius.circular(4.0),
                        onTap: () {
                          Navigator.of(context).push(new MaterialPageRoute(
                              builder: (BuildContext context) =>
                              new DomesticOfferMain()));
                        },
                        child: Card(
                          elevation: 1.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          clipBehavior: Clip.antiAlias,
                          margin: const EdgeInsets.all(0.0),
                          color: Color(0xffFAFAFA),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(0),
                                child: Padding(
                                  padding: const EdgeInsets.all(0),
                                  child: ClipPath(
                                    clipper: ShapeBorderClipper(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(15)),
                                    ),
                                    child: Image.asset(
                                      'assets/images/c4.jpg',
                                      fit: BoxFit.fill,
                                      height: screenHeight * 0.28,
                                    ),
                                  ),
                                ),
                              ),
//
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  getTranslated(
                                      context, 'home_offer_card_city'),
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff07898B),
                                  ),
                                  softWrap: true,
                                ),
                              ),

                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      flex: 50,
                                      child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 0.0,
                                              right: 0.0,
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
                                          ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  getTranslated(
                                      context, 'home_offer_card_price') +
                                      ' 220\$',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Colors.black),
                                  softWrap: true,
                                ),
                              ),

                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 0.0,
                                          right: 0.0,
                                          left: 0.0,
                                          bottom: 0.0),
                                      child: GFButton(
                                        textColor: Colors.white,
                                        onPressed: (){},
                                        text: getTranslated(
                                            context, 'my_reservations_set'),
                                        color: Color(0xff07898B),
                                      )
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
                  Container(
                    width: screenWidth * 0.6,
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {},
                      child: InkWell(
                        borderRadius: BorderRadius.circular(4.0),
                        onTap: () {
                          Navigator.of(context).push(new MaterialPageRoute(
                              builder: (BuildContext context) =>
                              new DomesticOfferMain()));
                        },
                        child: Card(
                          elevation: 1.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          clipBehavior: Clip.antiAlias,
                          margin: const EdgeInsets.all(0.0),
                          color: Color(0xffFAFAFA),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(0),
                                child: Padding(
                                  padding: const EdgeInsets.all(0),
                                  child: ClipPath(
                                    clipper: ShapeBorderClipper(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(15)),
                                    ),
                                    child: Image.asset(
                                      'assets/images/c4.jpg',
                                      fit: BoxFit.fill,
                                      height: screenHeight * 0.28,
                                    ),
                                  ),
                                ),
                              ),
//
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  getTranslated(
                                      context, 'home_offer_card_city'),
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff07898B),
                                  ),
                                  softWrap: true,
                                ),
                              ),

                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      flex: 50,
                                      child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 0.0,
                                              right: 0.0,
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
                                          ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  getTranslated(
                                      context, 'home_offer_card_price') +
                                      ' 220\$',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Colors.black),
                                  softWrap: true,
                                ),
                              ),

                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 0.0,
                                          right: 0.0,
                                          left: 0.0,
                                          bottom: 0.0),
                                      child: GFButton(
                                        textColor: Colors.white,
                                        onPressed: (){},
                                        text: getTranslated(
                                            context, 'my_reservations_canceled'),
                                        color: Colors.redAccent,
                                      )
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
            ),
          )

        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        unselectedItemColor: Color(0xff9FD0D2),
        selectedItemColor: Color(0xff07898B),
        onTap: onTabTapped, // new
        currentIndex: 2,
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

  void onTabTapped(int index) {
    if (index == 0) {
      Navigator.of(context).push(
        new MaterialPageRoute(
            builder: (BuildContext context) => new Home()),
      );
    } else if (index == 1) {
      Navigator.of(context).push(
        new MaterialPageRoute(
            builder: (BuildContext context) => new PlanYourTrip()),
      );
    } else if (index == 2) {
      Navigator.of(context).push(new MaterialPageRoute(
          builder: (BuildContext context) => new MyBooks()));
    } else if (index == 3) {
      Navigator.of(context).push(new MaterialPageRoute(
          builder: (BuildContext context) => new Settings()));
    }
  }
}
