import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:ipackage/localization/localizationValues.dart';
import 'package:ipackage/modules/my_icons.dart';
import 'package:ipackage/widgets/city_trips.dart';
import 'package:ipackage/widgets/home/special_foreign_offers.dart';
import 'package:ipackage/widgets/home/special_offers.dart';
import 'package:ipackage/widgets/my_books.dart';
import 'package:ipackage/widgets/plan_your_trip/plan_your_trip.dart';
import 'package:ipackage/widgets/settings.dart';
import 'package:ipackage/widgets/search/search_your_trip.dart';
import 'package:ipackage/widgets/users/new_account.dart';

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

              SizedBox(
                height: 30,
              ),

          //logo image
          Padding(
            padding: const EdgeInsetsDirectional.only(
                top: 40, end: 8.0, start: 18.0, bottom: 0),
            child: Image.asset(
                'assets/images/logo.jpg',
                //height: screenHeight * 0.07,
                fit: BoxFit.fill,
              ),),


              //btn
              Row(
                children: <Widget>[

                  Expanded(
                    flex: 50,
                    child: Padding(
                      padding: const EdgeInsetsDirectional.only(
                          top: 40, end: 8.0, start: 18.0, bottom: 8.0),
                      child: TextButton(
                        style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor: MaterialStateProperty.all<Color>(Color(0xffA57432)),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(new MaterialPageRoute(
                              builder: (BuildContext context) => new SearchYourTrip(initialTabIndex: 1,)));
                        },
                        child: Column(
                          children: [
                            Icon((MyIcons.bus),
                              size: 24.0,),
                            Text(getTranslated(context, 'home_national_tourism_btn'),style: TextStyle(fontFamily: "cairo",fontSize: 16, fontWeight: FontWeight.bold,),)
                          ],
                        )
                      )

                    ),
                  ),
                  Expanded(
                    flex: 50,
                    child: Padding(
                        padding: const EdgeInsetsDirectional.only(
                            top: 40, end: 8.0, start: 18.0, bottom: 8.0),
                        child: TextButton(
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                              backgroundColor: MaterialStateProperty.all<Color>(Color(0xffF8CB4E)),
                            ),
                            onPressed: () {
                              Navigator.of(context).push(new MaterialPageRoute(
                                  builder: (BuildContext context) => new SearchYourTrip(initialTabIndex: 0,)));
                            },
                            child: Column(
                              children: [
                                Icon((MyIcons.plane_arrival),
                                  size: 24.0,),
                                Text(getTranslated(context, 'home_international_tourism_btn'),style: TextStyle(fontFamily: "cairo",fontSize: 16, fontWeight: FontWeight.bold,),)
                              ],
                            )
                        )

                    ),
                  ),


                ],
              ),
              Row(
                children: <Widget>[

                  Expanded(

                    child: Padding(
                        padding: const EdgeInsetsDirectional.only(
                            top: 20, end: 8.0, start: 18.0, bottom: 8.0),
                        child: TextButton(
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                              backgroundColor: MaterialStateProperty.all<Color>(Color(0xff07898B)),
                            ),
                            onPressed: () {
                              Navigator.of(context).push(new MaterialPageRoute(
                                  builder: (BuildContext context) => new SearchYourTrip(initialTabIndex: 2,)));
                            },
                            child: Column(
                              children: [
                                Icon((Icons.people),
                                  size: 36.0,),
                                Text(getTranslated(context, 'home_ambassadors_btn'),style: TextStyle(fontFamily: "cairo",fontSize: 16, fontWeight: FontWeight.bold,),)
                              ],
                            )
                        )

                    ),
                  ),


                ],
              ),

              //account btn
              /*Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: GFButton(
                        color: Color(0xff07898B),
                        textColor: Colors.white,
                        text: 'account',
                        size: 50.0,
                        textStyle: TextStyle(
                          fontSize: 16.0,
                        ),
                        onPressed: () {
                          Navigator.of(context).push(new MaterialPageRoute(
                              builder: (BuildContext context) => new New_account()));
                        },
                      ),
                    ),
                  ),
                ],
              ),*/


              //home_national_tourism_offers
              Container(
                padding: const EdgeInsets.only(top: 35.0),
                child: Text(
                  getTranslated(context, 'home_national_tourism_offers_label'),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: "cairo",
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
                      fontFamily: "cairo",
                    ),
                  ),
                ),
              ),
              SpecialOffers(),

              //home_popular_foreign
              Container(
                padding: const EdgeInsets.only(top: 55.0 , bottom: 10.0 , right: 8 , left: 8),
                child: Text(
                  getTranslated(context, 'home_popular_foreign_label'),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: "cairo",
                  ),
                ),
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.only(top: 15.0  , right: 15 , left: 15),
                  child: Text(
                    getTranslated(
                        context, 'home_popular_foreign_label_2'),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: "cairo",
                    ),
                  ),
                ),
              ),
              SpecialForeignOffers(),



              //home_national_tourism_cities
              /*Container(
                padding: const EdgeInsets.only(top: 35.0),
                child: Text(
                  getTranslated(context, 'home_national_tourism_cities_label'),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 5.0, left: 10.0 , bottom: 0.0),
                height: screenHeight * 0.28,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    Container(
                      width: screenWidth * 0.65,
                      padding: const EdgeInsets.all(10.0),
                      child: GestureDetector(
                        onTap: () {},
                        child: InkWell(
                          borderRadius: BorderRadius.circular(4.0),
                          onTap: () {
                            Navigator.of(context).push(new MaterialPageRoute(
                                builder: (BuildContext context) => new CityTrips()));
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7.0),
                            ),
                            clipBehavior: Clip.antiAlias,
                            elevation: 0.5,
                            margin: const EdgeInsets.all(0.0),
                            color: Colors.white,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(0),
                                  child: Stack(
                                    fit: StackFit.passthrough,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(0),
                                        child: ClipPath(
                                          clipper: ShapeBorderClipper(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(7.0)),
                                          ),
                                          child: Image.asset(
                                            'assets/images/c3.jpg',
                                            fit: BoxFit.fill,
                                            height: screenHeight * 0.24,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(6),
                                        child: Flex(
                                          direction: Axis.horizontal,
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          children: <Widget>[
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  height: 20,
                                                  padding:
                                                  const EdgeInsets.all(0.0),
                                                  margin: EdgeInsets.only(
                                                      top: screenHeight * 0.15),
                                                  constraints: BoxConstraints(),
                                                  child: FittedBox(
                                                    child: Text(
                                                      'Saudi arabia',
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ),

                                                Container(
                                                  width: 80,
                                                  padding:
                                                  const EdgeInsets.all(3.0),
                                                  child: FittedBox(
                                                    child: GFRating(
                                                      color: Colors.amber,
                                                      borderColor: Colors.amber,
                                                      allowHalfRating: true,
                                                      value: 5,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),


                                          ],
                                        ),
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
                      width: screenWidth * 0.65,
                      padding: const EdgeInsets.all(10.0),
                      child: GestureDetector(
                        onTap: () {},
                        child: InkWell(
                          borderRadius: BorderRadius.circular(4.0),
                          onTap: () {
                            Navigator.of(context).push(new MaterialPageRoute(
                                builder: (BuildContext context) => new CityTrips()));
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7.0),
                            ),
                            clipBehavior: Clip.antiAlias,
                            elevation: 0.5,
                            margin: const EdgeInsets.all(0.0),
                            color: Colors.white,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(0),
                                  child: Stack(
                                    fit: StackFit.passthrough,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(0),
                                        child: ClipPath(
                                          clipper: ShapeBorderClipper(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(7.0)),
                                          ),
                                          child: Image.asset(
                                            'assets/images/c1.jpg',
                                            fit: BoxFit.fill,
                                            height: screenHeight * 0.24,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(6),
                                        child: Flex(
                                          direction: Axis.horizontal,
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          children: <Widget>[
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  height: 20,
                                                  padding:
                                                  const EdgeInsets.all(0.0),
                                                  margin: EdgeInsets.only(
                                                      top: screenHeight * 0.15),
                                                  constraints: BoxConstraints(),
                                                  child: FittedBox(
                                                    child: Text(
                                                      getTranslated(context,
                                                          'home_offer_card_city'),
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ),

                                                Container(
                                                  width: 80,
                                                  padding:
                                                  const EdgeInsets.all(3.0),
                                                  child: FittedBox(
                                                    child: GFRating(
                                                      color: Colors.amber,
                                                      borderColor: Colors.amber,
                                                      allowHalfRating: true,
                                                      value: 5,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),


                                          ],
                                        ),
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
                      width: screenWidth * 0.65,
                      padding: const EdgeInsets.all(10.0),
                      child: GestureDetector(
                        onTap: () {},
                        child: InkWell(
                          borderRadius: BorderRadius.circular(4.0),
                          onTap: () {
                            Navigator.of(context).push(new MaterialPageRoute(
                                builder: (BuildContext context) => new CityTrips()));
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7.0),
                            ),
                            clipBehavior: Clip.antiAlias,
                            elevation: 0.5,
                            margin: const EdgeInsets.all(0.0),
                            color: Colors.white,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(0),
                                  child: Stack(
                                    fit: StackFit.passthrough,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(0),
                                        child: ClipPath(
                                          clipper: ShapeBorderClipper(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(7.0)),
                                          ),
                                          child: Image.asset(
                                            'assets/images/c1.jpg',
                                            fit: BoxFit.fill,
                                            height: screenHeight * 0.24,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(6),
                                        child: Flex(
                                          direction: Axis.horizontal,
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          children: <Widget>[
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  height: 20,
                                                  padding:
                                                  const EdgeInsets.all(0.0),
                                                  margin: EdgeInsets.only(
                                                      top: screenHeight * 0.15),
                                                  constraints: BoxConstraints(),
                                                  child: FittedBox(
                                                    child: Text(
                                                      getTranslated(context,
                                                          'home_offer_card_city'),
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ),

                                                Container(
                                                  width: 80,
                                                  padding:
                                                  const EdgeInsets.all(3.0),
                                                  child: FittedBox(
                                                    child: GFRating(
                                                      color: Colors.amber,
                                                      borderColor: Colors.amber,
                                                      allowHalfRating: true,
                                                      value: 5,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),


                                          ],
                                        ),
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
              ),*/


              //home_ambassadors
              Container(
                padding: const EdgeInsets.only(top: 55.0 , bottom: 10.0 , right: 8 , left: 8),
                child: Text(
                  getTranslated(context, 'home_ambassadors_label'),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: "cairo",
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
                      fontFamily: "cairo",
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
                      fontFamily: "cairo",
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
                  getTranslated(context, 'home_help_label'),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: "cairo",
                  ),
                ),
              ),

              Row(
                children: <Widget>[
                  Container(
                    width: screenWidth * 0.5,
                    height: screenHeight * 0.35,
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
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(0),
                                child:
                                  Container(height: screenHeight * 0.1,
                                  child: Image.asset('assets/icons/payment.png',fit: BoxFit.fill,)),
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
                                    fontFamily: "cairo",
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
                                                'home_payment_choices_title'),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontFamily: "cairo",
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
                  Container(
                    width: screenWidth * 0.5,
                    height: screenHeight * 0.35,
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
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(0),
                                child:
                                Container(height: screenHeight * 0.1,
                                    child: Image.asset('assets/icons/payment.png',fit: BoxFit.fill,)),
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
                                                'home_payment_choices_title'),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 14,
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

              Row(
                children: <Widget>[
                  Container(
                    width: screenWidth * 0.5,
                    height: screenHeight * 0.35,
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
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(0),
                                child:
                                Container(height: screenHeight * 0.1,
                                    child: Image.asset('assets/icons/payment.png',fit: BoxFit.fill,)),
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
                                                'home_payment_choices_title'),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 14,
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
                  Container(
                    width: screenWidth * 0.5,
                    height: screenHeight * 0.35,
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
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(0),
                                child:
                                Container(height: screenHeight * 0.1,
                                    child: Image.asset('assets/icons/payment.png',fit: BoxFit.fill,)),
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
                                                'home_payment_choices_title'),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 14,
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
        },
        child: const Icon(MyIcons.chat),
        backgroundColor: Color(0xff07898B),

      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        unselectedItemColor: Color(0xff9FD0D2),
        selectedItemColor: Color(0xff07898B),
        onTap: onTabTapped, // new
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
