
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ipackage/localization/localizationValues.dart';

class HotelDetails extends StatefulWidget {
  @override
  _HotelDetailsState createState() => _HotelDetailsState();
}

class _HotelDetailsState extends State<HotelDetails> {
  @override
  Widget build(BuildContext context) {

    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final double screenHeight =
        MediaQuery.of(context).size.height - statusBarHeight - kToolbarHeight;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        shadowColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsetsDirectional.only(start: 0 ,top: 10.0 , bottom: 20.0),
              child: ClipPath(
                clipper: ShapeBorderClipper(
                  shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(7.0)),
                ),
                child: Image.asset(
                  'assets/images/c1.jpg',
                  fit: BoxFit.fill,
                  height: screenHeight * 0.32,
                ),
              ),
            ),

            Row(
              children: [
                Container(
                  padding: EdgeInsetsDirectional.only(start: screenWidth * 0.08 ,top: 20.0 , bottom: 10.0),
                  child: Text(
                    getTranslated(context, 'city_trips_label'),
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),

            Container(
              padding: EdgeInsetsDirectional.only(start: 0.0),
              height: screenHeight * 0.5,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  Container(width: screenWidth * 0.07,),
                  Container(
                    width: screenWidth * 0.55,
                    padding: const EdgeInsets.all(5.0),
                    child: GestureDetector(
                      onTap: () {},
                      child: InkWell(
                        borderRadius: BorderRadius.circular(4.0),
                        onTap: () {},
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
                                child: ClipPath(
                                  clipper: ShapeBorderClipper(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(15)),
                                  ),
                                  child: Image.asset(
                                    'assets/images/c4.jpg',
                                    fit: BoxFit.fill,
                                    height: screenHeight * 0.26,
                                  ),
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal:8.0 , vertical: 4.0),
                                child: Text(
                                  getTranslated(
                                      context, 'city_trips_card_title'),
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                  softWrap: true,
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal:10.0 , vertical: 4.0),
                                child: Text(
                                  getTranslated(
                                      context, 'city_trips_card_body'),
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black),
                                  softWrap: true,
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal:10.0 , vertical: 4.0),
                                child: Text(
                                  getTranslated(
                                      context, 'city_trips_card_body'),
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black),
                                  softWrap: true,
                                ),
                              ),

                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: screenWidth * 0.55,
                    padding: const EdgeInsets.all(5.0),
                    child: GestureDetector(
                      onTap: () {},
                      child: InkWell(
                        borderRadius: BorderRadius.circular(4.0),
                        onTap: () {},
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
                                child: ClipPath(
                                  clipper: ShapeBorderClipper(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(15)),
                                  ),
                                  child: Image.asset(
                                    'assets/images/c4.jpg',
                                    fit: BoxFit.fill,
                                    height: screenHeight * 0.26,
                                  ),
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal:8.0 , vertical: 4.0),
                                child: Text(
                                  getTranslated(
                                      context, 'city_trips_card_title'),
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                  softWrap: true,
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal:10.0 , vertical: 4.0),
                                child: Text(
                                  getTranslated(
                                      context, 'city_trips_card_body'),
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black),
                                  softWrap: true,
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal:10.0 , vertical: 4.0),
                                child: Text(
                                  getTranslated(
                                      context, 'city_trips_card_body'),
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black),
                                  softWrap: true,
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
            )
          ],
        ),
      ),
    );
  }
}
