import 'package:flutter/material.dart';
import 'package:getwidget/components/rating/gf_rating.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';
import 'package:ipackage/localization/localizationValues.dart';
import 'package:ipackage/modules/Offer/Hotel/Hotel.dart';
import 'package:ipackage/modules/my_icons.dart';
import 'package:ipackage/widgets/change_activity.dart';
import 'package:ipackage/widgets/confirm_book.dart';
import 'package:ipackage/widgets/edit_book.dart';
import 'package:ipackage/widgets/home/domestic_offer_main.dart';
import 'package:responsive_grid/responsive_grid.dart';

import '../../modules/BetaApiAssistant.dart';
import '../../modules/LocalAssistant.dart';
import '../../modules/Offer/Offer.dart';

class ForeignOfferMain extends StatefulWidget {
  final int id;
  final String package;
  final String rating;

  ForeignOfferMain({this.id, this.package, this.rating});

  @override
  _ForeignOfferMainState createState() => _ForeignOfferMainState();
}

class _ForeignOfferMainState extends State<ForeignOfferMain> {
  BetaApiAssistant betaApiAssistant = new BetaApiAssistant();
  LocalAssistant localAssistant = new LocalAssistant();
  Offer offer;
  bool _isLoading = true;
  int dayIndex = -1;
  int widgetIndex = 0;
  int transferNumber = 0;
  int flightNumber = 0;
  int activitiesNumber = 0;
  List<Hotel> offerHotels = [];
  List<String> _imageList = [];
  int _adultsNumber = 1;
  int _childrenNumber = 0;
  int _babiesNumber = 0;
  var now = new DateTime.now();
  var formatter = new DateFormat('MM/dd');
  var _pickedDate;
  int _totalPassengersNumber = 1;

  List<String> _comments = [
    "لقد كانت رحلة رائعة لقد كانت رحلة رائعة لقد كانت رحلة رائعة",
    "لقد كانت رحلة رائعة",
  ];

  void buildHotelsList(Offer offer) {
    for (var day in offer.days) {
      setState(() {
        offerHotels = List.of(offerHotels)..addAll(day.hotels);
      });
    }
  }

  void calculateOfferNumber(Offer offer) {
    for (int i = 0; i < offer.days.length; i++) {
      setState(() {
        transferNumber++;
      });

      if (i == offer.days.length - 1)
        setState(() {
          transferNumber++;
        });

      for (int index = 0; index < offer.days[i].trips.length; index++) {
        setState(() {
          activitiesNumber++;
        });
      }
    }
  }

  _activityBar(width, height, String head) {
    return Row(
      children: [
        Container(
            padding: EdgeInsetsDirectional.only(start: width * 0.0),
            child: Container(
              child: Row(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(
                        width: 2,
                        height: height * 0.04,
                        color: Color(0xff07898B),
                      ),
                      Container(
                        padding: EdgeInsets.all(2.0),
                        width: 25,
                        height: 25,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(
                            width: 2,
                            color: Color(0xff07898B),
                            style: BorderStyle.solid,
                          ),
                        ),
                        child: Container(
                            width: 15,
                            height: 15,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Color(0xff07898B),
                            )),
                      ),
                      Container(
                        width: 2,
                        height: height * 0.04,
                        color: Color(0xff07898B),
                      ),
                    ],
                  ),
                  Container(
                    width: width * 0.79,
                    padding: EdgeInsetsDirectional.only(
                        start: width * 0.02, top: 0.0, bottom: 0.0),
                    child: Row(
                      children: [
                        Flexible(
                          child: Text(
                            head,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 14,
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
            )),
      ],
    );
  }

  _tripPlanWidget(screenWidth, screenHeight) {
    return Column(
      children: <Widget>[
        Row(
          children: [
            Container(
              padding: EdgeInsetsDirectional.only(
                  start: screenWidth * 0.08, top: 20.0, bottom: 10.0),
              child: Text(
                getTranslated(context, 'do_plan_tab'),
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
            ),
          ],
        ),

        // Container(
        //   width: screenWidth,
        //   height: screenHeight * 0.11,
        //   color: Color(0xff07898B),
        //   child: Row(
        //     children: <Widget>[
        //
        //       Padding(
        //         padding: EdgeInsetsDirectional.only(
        //             start: screenWidth * 0.1),
        //         child: GFButton(
        //           onPressed: (){
        //             Navigator.of(context).push(new MaterialPageRoute(
        //                 builder: (BuildContext context) => new ConfirmBook()));
        //           },
        //           color: Colors.black,
        //           child: Padding(
        //             padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
        //             child: Text(
        //               getTranslated(context, 'domestic_offer_book_btn'),
        //               style: TextStyle(fontSize: 14, color: Colors.white),
        //             ),
        //           ),
        //         ),
        //       ),
        //
        //       Container(
        //         padding: EdgeInsetsDirectional.only(
        //             start: screenWidth * 0.06),
        //         child: Text(
        //           '220 \$',
        //           style: TextStyle(fontSize: 18, color: Colors.white , fontWeight: FontWeight.bold),
        //         ),
        //       )
        //     ],
        //   ),
        // ),

        for (int index = 0; index < offer.days.length; index++)
          Builder(builder: (context) {
            return Container(
              width: screenWidth,
              child: Card(
                elevation: 3.0,
                child: Column(
                  children: [
                    // City
                    Row(
                      children: [
                        Container(
                          width: screenWidth * 0.8,
                          padding: EdgeInsetsDirectional.only(
                              start: screenWidth * 0.044,
                              top: 10.0,
                              bottom: 0.0),
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 10,
                                  child: Icon(
                                    Icons.location_on_outlined,
                                    color: Colors.blueGrey,
                                  )),
                              Expanded(
                                flex: 90,
                                child: Text(
                                  localAssistant.getDayCityByLocale(
                                      context, offer.days[index]),
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 25,
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

                    // Transfer label
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsetsDirectional.only(
                              start: screenWidth * 0.048, top: 5.0),
                          child: Row(
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Container(
                                    width: 2,
                                    height: screenHeight * 0.04,
                                    color: Color(0xff07898B),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(2.0),
                                    width: 25,
                                    height: 25,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      border: Border.all(
                                        width: 2,
                                        color: Color(0xff07898B),
                                        style: BorderStyle.solid,
                                      ),
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Icons.directions_car_rounded,
                                        color: Color(0xff07898B),
                                        size: 15,
                                      ),
                                    ),
                                    // Container(
                                    //     width: 15,
                                    //     height: 15,
                                    //     decoration: BoxDecoration(
                                    //       borderRadius: BorderRadius.circular(50),
                                    //       color: Color(0xff07898B),
                                    //     ),
                                    // ),
                                  ),
                                  Container(
                                    width: 2,
                                    height: screenHeight * 0.04,
                                    color: Color(0xff07898B),
                                  ),
                                ],
                              ),
                              Container(
                                width: screenWidth * 0.8,
                                padding: EdgeInsetsDirectional.only(
                                    start: screenWidth * 0.04,
                                    top: 0.0,
                                    bottom: 0.0),
                                child: Row(
                                  children: [
                                    Flexible(
                                      child: Text(
                                        getTranslated(
                                            context, 'do_transfer_tab'),
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xff07898B),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    Container(
                      width: screenWidth * 0.9,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(4.0),
                        child: Card(
                          child: Row(
                            children: <Widget>[
                              ClipPath(
                                clipper: ShapeBorderClipper(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4.0)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(0),
                                  child: offer.days[index].transportationMethods
                                              .defaultTrans ==
                                          null
                                      ? Image.network(
                                          'https://ipackagetours.com/storage/app/' +
                                              offer.airportTransferGo[0]
                                                  .transportation.image
                                                  .toString(),
                                          fit: BoxFit.cover,
                                          height: screenHeight * 0.16,
                                          width: screenWidth * 0.3,
                                        )
                                      : Image.network(
                                          'https://ipackagetours.com/storage/app/' +
                                              offer
                                                  .days[index]
                                                  .transportationMethods
                                                  .defaultTrans[0]
                                                  .transportation
                                                  .image
                                                  .toString(),
                                          fit: BoxFit.cover,
                                          height: screenHeight * 0.16,
                                          width: screenWidth * 0.3,
                                        ),
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    width: screenWidth * 0.56,
                                    padding: const EdgeInsets.all(0),
                                    child: Row(
                                      children: <Widget>[
                                        Flexible(
                                          child: Padding(
                                            padding: const EdgeInsetsDirectional
                                                .only(start: 4.0),
                                            child: Text(
                                              offer
                                                          .days[index]
                                                          .transportationMethods
                                                          .defaultTrans ==
                                                      null
                                                  ? localAssistant
                                                      .getTransportationByLocale(
                                                          context,
                                                          offer
                                                              .airportTransferGo[
                                                                  0]
                                                              .transportation)
                                                      .toString()
                                                  : localAssistant
                                                      .getTransportationByLocale(
                                                          context,
                                                          offer
                                                              .days[index]
                                                              .transportationMethods
                                                              .defaultTrans[0]
                                                              .transportation)
                                                      .toString(),
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
                                  Container(
                                    width: screenWidth * 0.56,
                                    padding: const EdgeInsets.all(0),
                                    child: Row(
                                      children: <Widget>[
                                        Flexible(
                                          child: Padding(
                                            padding: const EdgeInsetsDirectional
                                                .only(start: 4.0),
                                            child: Text(
                                              offer
                                                              .days[index]
                                                              .transportationMethods
                                                              .defaultTrans ==
                                                          null &&
                                                      index == 0
                                                  ? getTranslated(context,
                                                          'do_plan_car_from') +
                                                      localAssistant
                                                          .getAirportByLocale(
                                                              context,
                                                              offer.airportGo)
                                                          .toString() +
                                                      getTranslated(
                                                          context, 'do_plan_car_to')
                                                  : getTranslated(context,
                                                          'do_plan_car_from') +
                                                      localAssistant
                                                          .getDayCityByLocale(
                                                              context,
                                                              offer.days[
                                                                  index - 1])
                                                          .toString() +
                                                      getTranslated(context,
                                                          'do_plan_car_to_2') +
                                                      localAssistant
                                                          .getDayCityByLocale(
                                                              context,
                                                              offer.days[index])
                                                          .toString(),
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.black54),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  // Container(
                                  //   height: screenHeight * 0.05,
                                  //   width: screenWidth * 0.56,
                                  //   padding: const EdgeInsets.all(4.0),
                                  //   child: Row(
                                  //     mainAxisAlignment: MainAxisAlignment.start,
                                  //     children: [
                                  //       Expanded(
                                  //         flex: 50,
                                  //         child: FittedBox(
                                  //           child: GFRating(
                                  //             color: Colors.amber,
                                  //             borderColor: Colors.amber,
                                  //             allowHalfRating: true,
                                  //             value: double.parse(offer.days[index].hotels[0].rating.toString()) ?? 0.0,
                                  //           ),
                                  //         ),
                                  //       ),
                                  //       Expanded(
                                  //         flex: 50,
                                  //         child: Padding(
                                  //           padding: const EdgeInsets.only(
                                  //               top: 0.0,
                                  //               right: 0.0,
                                  //               left: 0.0,
                                  //               bottom: 0.0),
                                  //           child: Text(
                                  //             ' ',
                                  //             textAlign: TextAlign.start,
                                  //             style: TextStyle(
                                  //                 fontWeight: FontWeight.bold,
                                  //                 fontSize: 15,
                                  //                 color: Colors.black),
                                  //           ),
                                  //         ),
                                  //       ),
                                  //     ],
                                  //   ),
                                  // ),
                                  Container(
                                    height: screenHeight * 0.06,
                                    width: screenWidth * 0.56,
                                    padding: const EdgeInsets.all(4.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Expanded(
                                          flex: 56,
                                          child: Text(''),
                                        ),
                                        Expanded(
                                          flex: 22,
                                          child: Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: GFButton(
                                              onPressed: () {},
                                              color: Colors.teal,
                                              child: Icon(
                                                Icons.edit,
                                                size: 14,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 22,
                                          child: Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: GFButton(
                                              color: Colors.redAccent,
                                              onPressed: () {},
                                              child: Icon(
                                                Icons.delete,
                                                size: 14,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                        // Padding(
                                        //   padding: const EdgeInsets.all(2.0),
                                        //   child: IconButton(
                                        //     color: Colors.teal,
                                        //     icon: Icon(Icons.edit , size: 20),
                                        //     onPressed: (){},
                                        //   ),
                                        // ),
                                        // Padding(
                                        //   padding: const EdgeInsets.all(2.0),
                                        //   child: IconButton(
                                        //     color: Colors.redAccent,
                                        //     icon: Icon(Icons.delete , size: 20,),
                                        //     onPressed: (){},
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Residence label
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsetsDirectional.only(
                              start: screenWidth * 0.048, top: 5.0),
                          child: Row(
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Container(
                                    width: 2,
                                    height: screenHeight * 0.04,
                                    color: Color(0xff07898B),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(2.0),
                                    width: 25,
                                    height: 25,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      border: Border.all(
                                        width: 2,
                                        color: Color(0xff07898B),
                                        style: BorderStyle.solid,
                                      ),
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Icons.apartment,
                                        color: Color(0xff07898B),
                                        size: 15,
                                      ),
                                    ),
                                    // Container(
                                    //     width: 15,
                                    //     height: 15,
                                    //     decoration: BoxDecoration(
                                    //       borderRadius: BorderRadius.circular(50),
                                    //       color: Color(0xff07898B),
                                    //     ),
                                    // ),
                                  ),
                                  Container(
                                    width: 2,
                                    height: screenHeight * 0.04,
                                    color: Color(0xff07898B),
                                  ),
                                ],
                              ),
                              Container(
                                width: screenWidth * 0.8,
                                padding: EdgeInsetsDirectional.only(
                                    start: screenWidth * 0.04,
                                    top: 0.0,
                                    bottom: 0.0),
                                child: Row(
                                  children: [
                                    Flexible(
                                      child: Text(
                                        getTranslated(context, 'fo_residence'),
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xff07898B),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    // Container(
                    //   margin: EdgeInsets.only(top: 5.0, left: 10.0 , bottom: 0.0),
                    //   height: screenHeight * 0.25,
                    //   child: ListView(
                    //     scrollDirection: Axis.horizontal,
                    //     children: <Widget>[
                    //       for(int i = 0 ; i < _imageList.length ; i++)
                    //         Container(
                    //           width: screenWidth * 0.65,
                    //           padding: const EdgeInsets.all(10.0),
                    //           child: GestureDetector(
                    //             onTap: () {},
                    //             child: InkWell(
                    //               onTap: () {},
                    //               child: Card(
                    //                 clipBehavior: Clip.antiAlias,
                    //                 elevation: 0.5,
                    //                 margin: const EdgeInsets.all(0.0),
                    //                 color: Colors.white,
                    //                 child: Padding(
                    //                   padding: const EdgeInsets.all(0),
                    //                   child: Padding(
                    //                     padding: const EdgeInsets.all(0),
                    //                     child: ClipPath(
                    //                       clipper: ShapeBorderClipper(
                    //                         shape: RoundedRectangleBorder(
                    //                             borderRadius:
                    //                             BorderRadius.circular(4.0)),
                    //                       ),
                    //                       child: Image.asset(
                    //                         _imageList[i].toString(),
                    //                         fit: BoxFit.fill,
                    //                         height: screenHeight * 0.24,
                    //                       ),
                    //                     ),
                    //                   ),
                    //                 ),
                    //               ),
                    //             ),
                    //           ),
                    //         ),
                    //     ],
                    //   ),
                    // ),

                    // Hotel
                    Container(
                      width: screenWidth * 0.9,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(4.0),
                        child: Card(
                          child: Row(
                            children: <Widget>[
                              ClipPath(
                                clipper: ShapeBorderClipper(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4.0)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(0),
                                  child: offer.days[index].hotels[0].images !=
                                          null
                                      ? Image.network(
                                          'https://ipackagetours.com/storage/app/' +
                                              offer.days[index].hotels[0].images
                                                  .toString(),
                                          fit: BoxFit.fill,
                                          height: screenHeight * 0.16,
                                          width: screenWidth * 0.3,
                                        )
                                      : Image.asset(
                                          'assets/images/hotel.jpg',
                                          fit: BoxFit.fill,
                                          height: screenHeight * 0.16,
                                          width: screenWidth * 0.3,
                                        ),
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    width: screenWidth * 0.56,
                                    padding: const EdgeInsets.all(0),
                                    child: Row(
                                      children: <Widget>[
                                        Flexible(
                                          child: Padding(
                                            padding: const EdgeInsetsDirectional
                                                .only(start: 4.0),
                                            child: Text(
                                              localAssistant
                                                  .getHotelByLocale(
                                                      context,
                                                      offer.days[index]
                                                          .hotels[0],
                                                      'name')
                                                  .toString(),
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
                                  Container(
                                    height: screenHeight * 0.05,
                                    width: screenWidth * 0.56,
                                    padding: const EdgeInsets.all(4.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          flex: 50,
                                          child: FittedBox(
                                            child: GFRating(
                                              color: Colors.amber,
                                              borderColor: Colors.amber,
                                              allowHalfRating: true,
                                              value: double.parse(offer
                                                      .days[index]
                                                      .hotels[0]
                                                      .rating
                                                      .toString()) ??
                                                  0.0,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 50,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 0.0,
                                                right: 0.0,
                                                left: 0.0,
                                                bottom: 0.0),
                                            child: Text(
                                              ' ',
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
                                  Container(
                                    height: screenHeight * 0.06,
                                    width: screenWidth * 0.56,
                                    padding: const EdgeInsets.all(4.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Expanded(
                                          flex: 56,
                                          child: Text(''),
                                        ),
                                        Expanded(
                                          flex: 22,
                                          child: Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: GFButton(
                                              onPressed: () {},
                                              color: Colors.teal,
                                              child: Icon(
                                                Icons.edit,
                                                size: 14,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 22,
                                          child: Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: GFButton(
                                              color: Colors.redAccent,
                                              onPressed: () {},
                                              child: Icon(
                                                Icons.delete,
                                                size: 14,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                        // Padding(
                                        //   padding: const EdgeInsets.all(2.0),
                                        //   child: IconButton(
                                        //     color: Colors.teal,
                                        //     icon: Icon(Icons.edit , size: 20),
                                        //     onPressed: (){},
                                        //   ),
                                        // ),
                                        // Padding(
                                        //   padding: const EdgeInsets.all(2.0),
                                        //   child: IconButton(
                                        //     color: Colors.redAccent,
                                        //     icon: Icon(Icons.delete , size: 20,),
                                        //     onPressed: (){},
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Trips label
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsetsDirectional.only(
                              start: screenWidth * 0.048, top: 0.0),
                          child: Row(
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Container(
                                    width: 2,
                                    height: screenHeight * 0.04,
                                    color: Color(0xff07898B),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(2.0),
                                    width: 25,
                                    height: 25,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      border: Border.all(
                                        width: 2,
                                        color: Color(0xff07898B),
                                        style: BorderStyle.solid,
                                      ),
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Icons.terrain,
                                        color: Color(0xff07898B),
                                        size: 15,
                                      ),
                                    ),
                                    // Container(
                                    //     width: 15,
                                    //     height: 15,
                                    //     decoration: BoxDecoration(
                                    //       borderRadius: BorderRadius.circular(50),
                                    //       color: Color(0xff07898B),
                                    //     ),
                                    // ),
                                  ),
                                  Container(
                                    width: 2,
                                    height: screenHeight * 0.04,
                                    color: Color(0xff07898B),
                                  ),
                                ],
                              ),
                              Container(
                                width: screenWidth * 0.8,
                                padding: EdgeInsetsDirectional.only(
                                    start: screenWidth * 0.04,
                                    top: 0.0,
                                    bottom: 0.0),
                                child: Row(
                                  children: [
                                    Flexible(
                                      child: Text(
                                        getTranslated(
                                            context, 'do_plan_label_16'),
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xff07898B),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    for (int i = 0; i < offer.days[index].trips.length; i++)
                      Builder(builder: (context) {
                        dayIndex++;
                        return Column(
                          children: <Widget>[
                            // Day label
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsetsDirectional.only(
                                      start: screenWidth * 0.048, top: 0.0),
                                  child: Row(
                                    children: <Widget>[
                                      Column(
                                        children: <Widget>[
                                          Container(
                                            width: 2,
                                            height: screenHeight * 0.04,
                                            color: Color(0xff07898B),
                                          ),
                                          Container(
                                            padding: EdgeInsets.all(2.0),
                                            width: 25,
                                            height: 25,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              border: Border.all(
                                                width: 2,
                                                color: Color(0xff07898B),
                                                style: BorderStyle.solid,
                                              ),
                                            ),
                                            child: Container(
                                                width: 15,
                                                height: 15,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  color: Color(0xff07898B),
                                                )),
                                          ),
                                          Container(
                                            width: 2,
                                            height: screenHeight * 0.04,
                                            color: Color(0xff07898B),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        width: screenWidth * 0.8,
                                        padding: EdgeInsetsDirectional.only(
                                            start: screenWidth * 0.04,
                                            top: 0.0,
                                            bottom: 0.0),
                                        child: Row(
                                          children: [
                                            Flexible(
                                              child: Text(
                                                getTranslated(
                                                    context,
                                                    'do_day_' +
                                                        dayIndex.toString() +
                                                        '_begin'),
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
                                ),
                              ],
                            ),

                            // Trip
                            Container(
                              width: screenWidth * 0.9,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(4.0),
                                child: Card(
                                  child: Row(
                                    children: <Widget>[
                                      ClipPath(
                                        clipper: ShapeBorderClipper(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(4.0)),
                                        ),
                                        child: Padding(
                                            padding: const EdgeInsets.all(0),
                                            child: Image.network(
                                              'https://ipackagetours.com/storage/app/' +
                                                  offer.days[index].trips[i]
                                                      .image
                                                      .toString(),
                                              fit: BoxFit.fill,
                                              height: screenHeight * 0.16,
                                              width: screenWidth * 0.3,
                                            )),
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                            width: screenWidth * 0.56,
                                            padding: const EdgeInsets.all(0),
                                            child: Row(
                                              children: <Widget>[
                                                Flexible(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .only(start: 4.0),
                                                    child: Text(
                                                      localAssistant
                                                          .getTripByLocale(
                                                              context,
                                                              offer.days[index]
                                                                  .trips[i],
                                                              'name')
                                                          .toString(),
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15,
                                                          color: Colors.black),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),

                                          // Container(
                                          //   height: screenHeight * 0.05,
                                          //   width: screenWidth * 0.56,
                                          //   padding: const EdgeInsets.all(4.0),
                                          //   child: Row(
                                          //     mainAxisAlignment: MainAxisAlignment.start,
                                          //     children: [
                                          //       Expanded(
                                          //         flex: 50,
                                          //         child: FittedBox(
                                          //           child: GFRating(
                                          //             color: Colors.amber,
                                          //             borderColor: Colors.amber,
                                          //             allowHalfRating: true,
                                          //             value: double.parse(offer.days[index].hotels[0].rating.toString()) ?? 0.0,
                                          //           ),
                                          //         ),
                                          //       ),
                                          //       Expanded(
                                          //         flex: 50,
                                          //         child: Padding(
                                          //           padding: const EdgeInsets.only(
                                          //               top: 0.0,
                                          //               right: 0.0,
                                          //               left: 0.0,
                                          //               bottom: 0.0),
                                          //           child: Text(
                                          //             ' ',
                                          //             textAlign: TextAlign.start,
                                          //             style: TextStyle(
                                          //                 fontWeight: FontWeight.bold,
                                          //                 fontSize: 15,
                                          //                 color: Colors.black),
                                          //           ),
                                          //         ),
                                          //       ),
                                          //     ],
                                          //   ),
                                          // ),
                                          Container(
                                            height: screenHeight * 0.06,
                                            width: screenWidth * 0.56,
                                            padding: const EdgeInsets.all(4.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Expanded(
                                                  flex: 56,
                                                  child: Text(''),
                                                ),
                                                Expanded(
                                                  flex: 22,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            2.0),
                                                    child: GFButton(
                                                      onPressed: () {},
                                                      color: Colors.teal,
                                                      child: Icon(
                                                        Icons.edit,
                                                        size: 14,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 22,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            2.0),
                                                    child: GFButton(
                                                      color: Colors.redAccent,
                                                      onPressed: () {},
                                                      child: Icon(
                                                        Icons.delete,
                                                        size: 14,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                // Padding(
                                                //   padding: const EdgeInsets.all(2.0),
                                                //   child: IconButton(
                                                //     color: Colors.teal,
                                                //     icon: Icon(Icons.edit , size: 20),
                                                //     onPressed: (){},
                                                //   ),
                                                // ),
                                                // Padding(
                                                //   padding: const EdgeInsets.all(2.0),
                                                //   child: IconButton(
                                                //     color: Colors.redAccent,
                                                //     icon: Icon(Icons.delete , size: 20,),
                                                //     onPressed: (){},
                                                //   ),
                                                // ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }),

                    index == offer.days.length - 1
                        ? Container(
                            width: screenWidth * 0.9,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(4.0),
                              child: Card(
                                child: Row(
                                  children: <Widget>[
                                    ClipPath(
                                      clipper: ShapeBorderClipper(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(4.0)),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(0),
                                        child: offer
                                                    .days[index]
                                                    .transportationMethods
                                                    .defaultTrans ==
                                                null
                                            ? Image.network(
                                                'https://ipackagetours.com/storage/app/' +
                                                    offer.airportTransferBack[0]
                                                        .transportation.image
                                                        .toString(),
                                                fit: BoxFit.cover,
                                                height: screenHeight * 0.16,
                                                width: screenWidth * 0.3,
                                              )
                                            : Image.network(
                                                'https://ipackagetours.com/storage/app/' +
                                                    offer
                                                        .days[index]
                                                        .transportationMethods
                                                        .defaultTrans[0]
                                                        .transportation
                                                        .image
                                                        .toString(),
                                                fit: BoxFit.cover,
                                                height: screenHeight * 0.16,
                                                width: screenWidth * 0.3,
                                              ),
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                          width: screenWidth * 0.56,
                                          padding: const EdgeInsets.all(0),
                                          child: Row(
                                            children: <Widget>[
                                              Flexible(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                          .only(start: 4.0),
                                                  child: Text(
                                                    offer
                                                                .days[index]
                                                                .transportationMethods
                                                                .defaultTrans ==
                                                            null
                                                        ? localAssistant
                                                            .getTransportationByLocale(
                                                                context,
                                                                offer
                                                                    .airportTransferBack[
                                                                        0]
                                                                    .transportation)
                                                            .toString()
                                                        : localAssistant
                                                            .getTransportationByLocale(
                                                                context,
                                                                offer
                                                                    .days[index]
                                                                    .transportationMethods
                                                                    .defaultTrans[
                                                                        0]
                                                                    .transportation)
                                                            .toString(),
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 15,
                                                        color: Colors.black),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: screenWidth * 0.56,
                                          padding: const EdgeInsets.all(0),
                                          child: Row(
                                            children: <Widget>[
                                              Flexible(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                          .only(start: 4.0),
                                                  child: Text(
                                                    getTranslated(context,
                                                            'do_plan_car_from_2') +
                                                        localAssistant
                                                            .getAirportByLocale(
                                                                context,
                                                                offer
                                                                    .airportBack)
                                                            .toString(),
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.black54),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        // Container(
                                        //   height: screenHeight * 0.05,
                                        //   width: screenWidth * 0.56,
                                        //   padding: const EdgeInsets.all(4.0),
                                        //   child: Row(
                                        //     mainAxisAlignment: MainAxisAlignment.start,
                                        //     children: [
                                        //       Expanded(
                                        //         flex: 50,
                                        //         child: FittedBox(
                                        //           child: GFRating(
                                        //             color: Colors.amber,
                                        //             borderColor: Colors.amber,
                                        //             allowHalfRating: true,
                                        //             value: double.parse(offer.days[index].hotels[0].rating.toString()) ?? 0.0,
                                        //           ),
                                        //         ),
                                        //       ),
                                        //       Expanded(
                                        //         flex: 50,
                                        //         child: Padding(
                                        //           padding: const EdgeInsets.only(
                                        //               top: 0.0,
                                        //               right: 0.0,
                                        //               left: 0.0,
                                        //               bottom: 0.0),
                                        //           child: Text(
                                        //             ' ',
                                        //             textAlign: TextAlign.start,
                                        //             style: TextStyle(
                                        //                 fontWeight: FontWeight.bold,
                                        //                 fontSize: 15,
                                        //                 color: Colors.black),
                                        //           ),
                                        //         ),
                                        //       ),
                                        //     ],
                                        //   ),
                                        // ),
                                        Container(
                                          height: screenHeight * 0.06,
                                          width: screenWidth * 0.56,
                                          padding: const EdgeInsets.all(4.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Expanded(
                                                flex: 56,
                                                child: Text(''),
                                              ),
                                              Expanded(
                                                flex: 22,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(2.0),
                                                  child: GFButton(
                                                    onPressed: () {},
                                                    color: Colors.teal,
                                                    child: Icon(
                                                      Icons.edit,
                                                      size: 14,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 22,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(2.0),
                                                  child: GFButton(
                                                    color: Colors.redAccent,
                                                    onPressed: () {},
                                                    child: Icon(
                                                      Icons.delete,
                                                      size: 14,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              // Padding(
                                              //   padding: const EdgeInsets.all(2.0),
                                              //   child: IconButton(
                                              //     color: Colors.teal,
                                              //     icon: Icon(Icons.edit , size: 20),
                                              //     onPressed: (){},
                                              //   ),
                                              // ),
                                              // Padding(
                                              //   padding: const EdgeInsets.all(2.0),
                                              //   child: IconButton(
                                              //     color: Colors.redAccent,
                                              //     icon: Icon(Icons.delete , size: 20,),
                                              //     onPressed: (){},
                                              //   ),
                                              // ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : Container(
                            width: 1,
                            height: 1,
                          ),

                    Container(
                      width: screenWidth,
                      child: GFAccordion(
                        title: getTranslated(context, 'fo_details'),
                        textStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff07898B),
                        ),
                        collapsedIcon: Icon(
                          Icons.keyboard_arrow_down,
                          color: Color(0xff07898B),
                        ),
                        expandedIcon: Icon(
                          Icons.keyboard_arrow_up,
                          color: Color(0xff07898B),
                        ),
                        contentChild: Container(
                          width: screenWidth,
                          child: Column(
                            children: <Widget>[
                              for (int i = 0;
                                  i < offer.days[index].trips.length;
                                  i++)
                                _activityBar(
                                  screenWidth,
                                  screenHeight,
                                  localAssistant
                                      .getTripByLocale(context,
                                          offer.days[index].trips[i], 'name')
                                      .toString(),
                                ),
                              // Row(
                              //   children: [
                              //     Container(
                              //       // padding: EdgeInsetsDirectional.only(start: screenWidth * 0.02),
                              //       child: Container(
                              //         child: Row(
                              //           children: <Widget>[
                              //             Column(
                              //               children: <Widget>[
                              //                 Container(
                              //                   width: 2,
                              //                   height: screenHeight * 0.06,
                              //                   color: Color(0xff07898B),
                              //                 ),
                              //                 Container(
                              //                   padding: EdgeInsets.all(2.0),
                              //                   width: 25,
                              //                   height: 25,
                              //                   decoration: BoxDecoration(
                              //                     borderRadius:
                              //                         BorderRadius.circular(50),
                              //                     border: Border.all(
                              //                       width: 2,
                              //                       color: Color(0xffDDDDDD),
                              //                       style: BorderStyle.solid,
                              //                     ),
                              //                   ),
                              //                   child: Container(
                              //                       width: 15,
                              //                       height: 15,
                              //                       decoration: BoxDecoration(
                              //                         borderRadius:
                              //                             BorderRadius.circular(
                              //                                 50),
                              //                         color: Color(0xffDDDDDD),
                              //                       )),
                              //                 ),
                              //               ],
                              //             ),
                              //             Container(
                              //               width: screenWidth * 0.75,
                              //               height: screenHeight * 0.08,
                              //               color: Color(0xffDDDDDD),
                              //               margin: EdgeInsetsDirectional.only(
                              //                   start: screenWidth * 0.02,
                              //                   top: 10.0,
                              //                   bottom: 0.0),
                              //               padding: EdgeInsets.all(5.0),
                              //               child: Row(
                              //                 children: [
                              //                   Expanded(
                              //                     flex: 60,
                              //                     child: Text(
                              //                       getTranslated(
                              //                           context, 'fo_label_2'),
                              //                       textAlign: TextAlign.start,
                              //                       style: TextStyle(
                              //                         fontSize: 16,
                              //                         fontWeight:
                              //                             FontWeight.bold,
                              //                         color: Colors.black,
                              //                       ),
                              //                     ),
                              //                   ),
                              //                   Expanded(
                              //                       flex: 40,
                              //                       child: TextButton(
                              //                         onPressed: () {
                              //                           Navigator.of(context).push(
                              //                               new MaterialPageRoute(
                              //                                   builder: (BuildContext
                              //                                           context) =>
                              //                                       new ChangeActivity()));
                              //                         },
                              //                         child: Text(
                              //                           getTranslated(context,
                              //                               'fo_add_btn'),
                              //                           textAlign:
                              //                               TextAlign.start,
                              //                           style: TextStyle(
                              //                             fontSize: 15,
                              //                             color:
                              //                                 Color(0xff07898B),
                              //                           ),
                              //                         ),
                              //                       )),
                              //                 ],
                              //               ),
                              //             ),
                              //           ],
                              //         ),
                              //       ),
                              //     ),
                              //   ],
                              // ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
      ],
    );
  }

  _hotelWidget(screenWidth, screenHeight) {
    return Column(
      children: <Widget>[
        Row(
          children: [
            Container(
              padding: EdgeInsetsDirectional.only(
                  start: screenWidth * 0.08, top: 20.0, bottom: 10.0),
              child: Text(
                getTranslated(context, 'do_hotels_tab'),
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
            ),
          ],
        ),
        for (int index = 0; index < offerHotels.length; index++)
          // Hotel
          Container(
            width: screenWidth * 0.9,
            child: InkWell(
              borderRadius: BorderRadius.circular(4.0),
              child: Card(
                child: Row(
                  children: <Widget>[
                    ClipPath(
                      clipper: ShapeBorderClipper(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(0),
                        child: offer.days[index].hotels[0].images != null
                            ? Image.network(
                                'https://ipackagetours.com/storage/app/' +
                                    offer.days[index].hotels[0].images
                                        .toString(),
                                fit: BoxFit.fill,
                                height: screenHeight * 0.16,
                                width: screenWidth * 0.3,
                              )
                            : Image.asset(
                                'assets/images/hotel.jpg',
                                fit: BoxFit.fill,
                                height: screenHeight * 0.16,
                                width: screenWidth * 0.3,
                              ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: screenWidth * 0.56,
                          padding: const EdgeInsets.all(0),
                          child: Row(
                            children: <Widget>[
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.only(
                                      start: 4.0),
                                  child: Text(
                                    localAssistant
                                        .getHotelByLocale(context,
                                            offer.days[index].hotels[0], 'name')
                                        .toString(),
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
                        Container(
                          height: screenHeight * 0.05,
                          width: screenWidth * 0.56,
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 50,
                                child: FittedBox(
                                  child: GFRating(
                                    color: Colors.amber,
                                    borderColor: Colors.amber,
                                    allowHalfRating: true,
                                    value: double.parse(offer
                                            .days[index].hotels[0].rating
                                            .toString()) ??
                                        0.0,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 50,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 0.0,
                                      right: 0.0,
                                      left: 0.0,
                                      bottom: 0.0),
                                  child: Text(
                                    ' ',
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
                        Container(
                          height: screenHeight * 0.06,
                          width: screenWidth * 0.56,
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Expanded(
                                flex: 56,
                                child: Text(''),
                              ),
                              Expanded(
                                flex: 22,
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: GFButton(
                                    onPressed: () {},
                                    color: Colors.teal,
                                    child: Icon(
                                      Icons.edit,
                                      size: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 22,
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: GFButton(
                                    color: Colors.redAccent,
                                    onPressed: () {},
                                    child: Icon(
                                      Icons.delete,
                                      size: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              // Padding(
                              //   padding: const EdgeInsets.all(2.0),
                              //   child: IconButton(
                              //     color: Colors.teal,
                              //     icon: Icon(Icons.edit , size: 20),
                              //     onPressed: (){},
                              //   ),
                              // ),
                              // Padding(
                              //   padding: const EdgeInsets.all(2.0),
                              //   child: IconButton(
                              //     color: Colors.redAccent,
                              //     icon: Icon(Icons.delete , size: 20,),
                              //     onPressed: (){},
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }

  _transportWidget(screenWidth, screenHeight) {
    return Column(
      children: <Widget>[
        Row(
          children: [
            Container(
              padding: EdgeInsetsDirectional.only(
                  start: screenWidth * 0.08, top: 20.0, bottom: 10.0),
              child: Text(
                getTranslated(context, 'do_transfer_tab'),
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
            ),
          ],
        ),
        for (int index = 0; index < offer.days.length; index++)
          Column(
            children: [
              Container(
                width: screenWidth * 0.9,
                child: InkWell(
                  borderRadius: BorderRadius.circular(4.0),
                  child: Card(
                    child: Row(
                      children: <Widget>[
                        ClipPath(
                          clipper: ShapeBorderClipper(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4.0)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(0),
                            child: offer.days[index].transportationMethods
                                        .defaultTrans ==
                                    null
                                ? Image.network(
                                    'https://ipackagetours.com/storage/app/' +
                                        offer.airportTransferGo[0]
                                            .transportation.image
                                            .toString(),
                                    fit: BoxFit.cover,
                                    height: screenHeight * 0.16,
                                    width: screenWidth * 0.3,
                                  )
                                : Image.network(
                                    'https://ipackagetours.com/storage/app/' +
                                        offer
                                            .days[index]
                                            .transportationMethods
                                            .defaultTrans[0]
                                            .transportation
                                            .image
                                            .toString(),
                                    fit: BoxFit.cover,
                                    height: screenHeight * 0.16,
                                    width: screenWidth * 0.3,
                                  ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              width: screenWidth * 0.56,
                              padding: const EdgeInsets.all(0),
                              child: Row(
                                children: <Widget>[
                                  Flexible(
                                    child: Padding(
                                      padding: const EdgeInsetsDirectional.only(
                                          start: 4.0),
                                      child: Text(
                                        offer.days[index].transportationMethods
                                                    .defaultTrans ==
                                                null
                                            ? localAssistant
                                                .getTransportationByLocale(
                                                    context,
                                                    offer.airportTransferGo[0]
                                                        .transportation)
                                                .toString()
                                            : localAssistant
                                                .getTransportationByLocale(
                                                    context,
                                                    offer
                                                        .days[index]
                                                        .transportationMethods
                                                        .defaultTrans[0]
                                                        .transportation)
                                                .toString(),
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
                            Container(
                              width: screenWidth * 0.56,
                              padding: const EdgeInsets.all(0),
                              child: Row(
                                children: <Widget>[
                                  Flexible(
                                    child: Padding(
                                      padding: const EdgeInsetsDirectional.only(
                                          start: 4.0),
                                      child: Text(
                                        offer.days[index].transportationMethods
                                                        .defaultTrans ==
                                                    null &&
                                                index == 0
                                            ? getTranslated(context,
                                                    'do_plan_car_from') +
                                                localAssistant
                                                    .getAirportByLocale(context,
                                                        offer.airportGo)
                                                    .toString() +
                                                getTranslated(
                                                    context, 'do_plan_car_to')
                                            : getTranslated(context,
                                                    'do_plan_car_from') +
                                                localAssistant
                                                    .getDayCityByLocale(context,
                                                        offer.days[index - 1])
                                                    .toString() +
                                                getTranslated(context,
                                                    'do_plan_car_to_2') +
                                                localAssistant
                                                    .getDayCityByLocale(context,
                                                        offer.days[index])
                                                    .toString(),
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black54),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Container(
                            //   height: screenHeight * 0.05,
                            //   width: screenWidth * 0.56,
                            //   padding: const EdgeInsets.all(4.0),
                            //   child: Row(
                            //     mainAxisAlignment: MainAxisAlignment.start,
                            //     children: [
                            //       Expanded(
                            //         flex: 50,
                            //         child: FittedBox(
                            //           child: GFRating(
                            //             color: Colors.amber,
                            //             borderColor: Colors.amber,
                            //             allowHalfRating: true,
                            //             value: double.parse(offer.days[index].hotels[0].rating.toString()) ?? 0.0,
                            //           ),
                            //         ),
                            //       ),
                            //       Expanded(
                            //         flex: 50,
                            //         child: Padding(
                            //           padding: const EdgeInsets.only(
                            //               top: 0.0,
                            //               right: 0.0,
                            //               left: 0.0,
                            //               bottom: 0.0),
                            //           child: Text(
                            //             ' ',
                            //             textAlign: TextAlign.start,
                            //             style: TextStyle(
                            //                 fontWeight: FontWeight.bold,
                            //                 fontSize: 15,
                            //                 color: Colors.black),
                            //           ),
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            Container(
                              height: screenHeight * 0.06,
                              width: screenWidth * 0.56,
                              padding: const EdgeInsets.all(4.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Expanded(
                                    flex: 56,
                                    child: Text(''),
                                  ),
                                  Expanded(
                                    flex: 22,
                                    child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: GFButton(
                                        onPressed: () {},
                                        color: Colors.teal,
                                        child: Icon(
                                          Icons.edit,
                                          size: 14,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 22,
                                    child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: GFButton(
                                        color: Colors.redAccent,
                                        onPressed: () {},
                                        child: Icon(
                                          Icons.delete,
                                          size: 14,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  // Padding(
                                  //   padding: const EdgeInsets.all(2.0),
                                  //   child: IconButton(
                                  //     color: Colors.teal,
                                  //     icon: Icon(Icons.edit , size: 20),
                                  //     onPressed: (){},
                                  //   ),
                                  // ),
                                  // Padding(
                                  //   padding: const EdgeInsets.all(2.0),
                                  //   child: IconButton(
                                  //     color: Colors.redAccent,
                                  //     icon: Icon(Icons.delete , size: 20,),
                                  //     onPressed: (){},
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              index == offer.days.length - 1
                  ? Container(
                      width: screenWidth * 0.9,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(4.0),
                        child: Card(
                          child: Row(
                            children: <Widget>[
                              ClipPath(
                                clipper: ShapeBorderClipper(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4.0)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(0),
                                  child: offer.days[index].transportationMethods
                                              .defaultTrans ==
                                          null
                                      ? Image.network(
                                          'https://ipackagetours.com/storage/app/' +
                                              offer.airportTransferBack[0]
                                                  .transportation.image
                                                  .toString(),
                                          fit: BoxFit.cover,
                                          height: screenHeight * 0.16,
                                          width: screenWidth * 0.3,
                                        )
                                      : Image.network(
                                          'https://ipackagetours.com/storage/app/' +
                                              offer
                                                  .days[index]
                                                  .transportationMethods
                                                  .defaultTrans[0]
                                                  .transportation
                                                  .image
                                                  .toString(),
                                          fit: BoxFit.cover,
                                          height: screenHeight * 0.16,
                                          width: screenWidth * 0.3,
                                        ),
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    width: screenWidth * 0.56,
                                    padding: const EdgeInsets.all(0),
                                    child: Row(
                                      children: <Widget>[
                                        Flexible(
                                          child: Padding(
                                            padding: const EdgeInsetsDirectional
                                                .only(start: 4.0),
                                            child: Text(
                                              offer
                                                          .days[index]
                                                          .transportationMethods
                                                          .defaultTrans ==
                                                      null
                                                  ? localAssistant
                                                      .getTransportationByLocale(
                                                          context,
                                                          offer
                                                              .airportTransferBack[
                                                                  0]
                                                              .transportation)
                                                      .toString()
                                                  : localAssistant
                                                      .getTransportationByLocale(
                                                          context,
                                                          offer
                                                              .days[index]
                                                              .transportationMethods
                                                              .defaultTrans[0]
                                                              .transportation)
                                                      .toString(),
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
                                  Container(
                                    width: screenWidth * 0.56,
                                    padding: const EdgeInsets.all(0),
                                    child: Row(
                                      children: <Widget>[
                                        Flexible(
                                          child: Padding(
                                            padding: const EdgeInsetsDirectional
                                                .only(start: 4.0),
                                            child: Text(
                                              getTranslated(context,
                                                      'do_plan_car_from_2') +
                                                  localAssistant
                                                      .getAirportByLocale(
                                                          context,
                                                          offer.airportBack)
                                                      .toString(),
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.black54),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  // Container(
                                  //   height: screenHeight * 0.05,
                                  //   width: screenWidth * 0.56,
                                  //   padding: const EdgeInsets.all(4.0),
                                  //   child: Row(
                                  //     mainAxisAlignment: MainAxisAlignment.start,
                                  //     children: [
                                  //       Expanded(
                                  //         flex: 50,
                                  //         child: FittedBox(
                                  //           child: GFRating(
                                  //             color: Colors.amber,
                                  //             borderColor: Colors.amber,
                                  //             allowHalfRating: true,
                                  //             value: double.parse(offer.days[index].hotels[0].rating.toString()) ?? 0.0,
                                  //           ),
                                  //         ),
                                  //       ),
                                  //       Expanded(
                                  //         flex: 50,
                                  //         child: Padding(
                                  //           padding: const EdgeInsets.only(
                                  //               top: 0.0,
                                  //               right: 0.0,
                                  //               left: 0.0,
                                  //               bottom: 0.0),
                                  //           child: Text(
                                  //             ' ',
                                  //             textAlign: TextAlign.start,
                                  //             style: TextStyle(
                                  //                 fontWeight: FontWeight.bold,
                                  //                 fontSize: 15,
                                  //                 color: Colors.black),
                                  //           ),
                                  //         ),
                                  //       ),
                                  //     ],
                                  //   ),
                                  // ),
                                  Container(
                                    height: screenHeight * 0.06,
                                    width: screenWidth * 0.56,
                                    padding: const EdgeInsets.all(4.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Expanded(
                                          flex: 56,
                                          child: Text(''),
                                        ),
                                        Expanded(
                                          flex: 22,
                                          child: Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: GFButton(
                                              onPressed: () {},
                                              color: Colors.teal,
                                              child: Icon(
                                                Icons.edit,
                                                size: 14,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 22,
                                          child: Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: GFButton(
                                              color: Colors.redAccent,
                                              onPressed: () {},
                                              child: Icon(
                                                Icons.delete,
                                                size: 14,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                        // Padding(
                                        //   padding: const EdgeInsets.all(2.0),
                                        //   child: IconButton(
                                        //     color: Colors.teal,
                                        //     icon: Icon(Icons.edit , size: 20),
                                        //     onPressed: (){},
                                        //   ),
                                        // ),
                                        // Padding(
                                        //   padding: const EdgeInsets.all(2.0),
                                        //   child: IconButton(
                                        //     color: Colors.redAccent,
                                        //     icon: Icon(Icons.delete , size: 20,),
                                        //     onPressed: (){},
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : Container(
                      width: 1,
                      height: 1,
                    ),
            ],
          ),
      ],
    );
  }

  _activitiesWidget(screenWidth, screenHeight) {
    return Column(
      children: <Widget>[
        Row(
          children: [
            Container(
              padding: EdgeInsetsDirectional.only(
                  start: screenWidth * 0.08, top: 20.0, bottom: 10.0),
              child: Text(
                getTranslated(context, 'do_activities_tab'),
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
            ),
          ],
        ),
        for (int index = 0; index < offer.days.length; index++)
          for (int tIndex = 0;
              tIndex < offer.days[index].trips.length;
              tIndex++)
            // Trip
            Container(
              width: screenWidth * 0.9,
              child: InkWell(
                borderRadius: BorderRadius.circular(4.0),
                child: Card(
                  child: Row(
                    children: <Widget>[
                      ClipPath(
                        clipper: ShapeBorderClipper(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.0)),
                        ),
                        child: Padding(
                            padding: const EdgeInsets.all(0),
                            child: Image.network(
                              'https://ipackagetours.com/storage/app/' +
                                  offer.days[index].trips[tIndex].image
                                      .toString(),
                              fit: BoxFit.fill,
                              height: screenHeight * 0.16,
                              width: screenWidth * 0.3,
                            )),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: screenWidth * 0.56,
                            padding: const EdgeInsets.all(0),
                            child: Row(
                              children: <Widget>[
                                Flexible(
                                  child: Padding(
                                    padding: const EdgeInsetsDirectional.only(
                                        start: 4.0),
                                    child: Text(
                                      localAssistant
                                          .getTripByLocale(
                                              context,
                                              offer.days[index].trips[tIndex],
                                              'name')
                                          .toString(),
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

                          // Container(
                          //   height: screenHeight * 0.05,
                          //   width: screenWidth * 0.56,
                          //   padding: const EdgeInsets.all(4.0),
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.start,
                          //     children: [
                          //       Expanded(
                          //         flex: 50,
                          //         child: FittedBox(
                          //           child: GFRating(
                          //             color: Colors.amber,
                          //             borderColor: Colors.amber,
                          //             allowHalfRating: true,
                          //             value: double.parse(offer.days[index].hotels[0].rating.toString()) ?? 0.0,
                          //           ),
                          //         ),
                          //       ),
                          //       Expanded(
                          //         flex: 50,
                          //         child: Padding(
                          //           padding: const EdgeInsets.only(
                          //               top: 0.0,
                          //               right: 0.0,
                          //               left: 0.0,
                          //               bottom: 0.0),
                          //           child: Text(
                          //             ' ',
                          //             textAlign: TextAlign.start,
                          //             style: TextStyle(
                          //                 fontWeight: FontWeight.bold,
                          //                 fontSize: 15,
                          //                 color: Colors.black),
                          //           ),
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          Container(
                            height: screenHeight * 0.06,
                            width: screenWidth * 0.56,
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Expanded(
                                  flex: 56,
                                  child: Text(''),
                                ),
                                Expanded(
                                  flex: 22,
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: GFButton(
                                      onPressed: () {},
                                      color: Colors.teal,
                                      child: Icon(
                                        Icons.edit,
                                        size: 14,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 22,
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: GFButton(
                                      color: Colors.redAccent,
                                      onPressed: () {},
                                      child: Icon(
                                        Icons.delete,
                                        size: 14,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                // Padding(
                                //   padding: const EdgeInsets.all(2.0),
                                //   child: IconButton(
                                //     color: Colors.teal,
                                //     icon: Icon(Icons.edit , size: 20),
                                //     onPressed: (){},
                                //   ),
                                // ),
                                // Padding(
                                //   padding: const EdgeInsets.all(2.0),
                                //   child: IconButton(
                                //     color: Colors.redAccent,
                                //     icon: Icon(Icons.delete , size: 20,),
                                //     onPressed: (){},
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
      ],
    );
  }

  _flightsWidget(screenWidth, screenHeight) {
    return Column(
      children: <Widget>[
        Row(
          children: [
            Container(
              padding: EdgeInsetsDirectional.only(
                  start: screenWidth * 0.08, top: 20.0, bottom: 10.0),
              child: Text(
                getTranslated(context, 'do_flights_tab'),
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  _widgetRouter(screenWidth, screenHeight) {
    switch (widgetIndex) {
      case 0:
        return _tripPlanWidget(screenWidth, screenHeight);
        break;
      case 1:
        return _hotelWidget(screenWidth, screenHeight);
        break;
      case 2:
        return _flightsWidget(screenWidth, screenHeight);
        break;
      case 3:
        return _transportWidget(screenWidth, screenHeight);
        break;
      case 4:
        return _activitiesWidget(screenWidth, screenHeight);
        break;
    }
  }

  void _presentDatePicker() {
    showDatePicker(
        confirmText: 'Set',
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2018),
        lastDate: DateTime.now(),
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: Color(0xff07898B),
              accentColor: Color(0xff07898B),
              colorScheme: ColorScheme.light(primary: const Color(0xff07898B)),
              buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
            ),
            child: child,
          );
        }).then((selectedDate) {
      if (selectedDate == null) return;
      setState(() {
        _pickedDate = selectedDate;
      });
    });
  }

  void increaseProperty(index)
  {
    setState(() {
      index++;
    });
  }

  void decreaseProperty(index)
  {
    setState(() {
      index--;
    });
  }

  _openEditPackageWidget(screenWidth, screenHeight) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return Container(
              padding: EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: screenHeight * 0.1,
                      width: screenWidth * 0.9,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            flex: 50,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0),
                              child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                alignment: AlignmentDirectional.centerStart,
                                child: Text(
                                  getTranslated(
                                      context, 'book_trip_adults_number'),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 40,
                            child: FittedBox(
                              child: Row(
                                children: <Widget>[
                                  MaterialButton(
                                    padding: const EdgeInsets.all(2.0),
                                    shape: CircleBorder(
                                      side: BorderSide(
                                          width: 2,
                                          color: Color(0xff07898B),
                                          style: BorderStyle.solid),
                                    ),
                                    child: Icon(
                                      MyIcons.minus,
                                      size: 10,
                                      color: Color(0xff07898B),
                                    ),
                                    color: Colors.white,
                                    onPressed: () {
                                      if (_adultsNumber > 1)
                                        setState(() {
                                          _adultsNumber -= 1;
                                          _totalPassengersNumber = _adultsNumber + _childrenNumber + _babiesNumber;
                                        });
                                    },
                                  ),
                                  Container(
                                    child: Text(
                                      _adultsNumber.toString(),
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xff07898B),
                                      ),
                                    ),
                                  ),
                                  MaterialButton(
                                    padding: const EdgeInsets.all(2.0),
                                    shape: CircleBorder(
                                      side: BorderSide(
                                          width: 2,
                                          color: Color(0xff07898B),
                                          style: BorderStyle.solid),
                                    ),
                                    child: Icon(
                                      Icons.add,
                                      size: 15,
                                      color: Color(0xff07898B),
                                    ),
                                    color: Colors.white,
                                    onPressed: () {
                                      if (_adultsNumber < 50)
                                        setState(() {
                                          _adultsNumber += 1;
                                        });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: screenHeight * 0.1,
                      width: screenWidth * 0.9,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            flex: 50,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0),
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                alignment: AlignmentDirectional.centerStart,
                                child: Text(
                                  getTranslated(
                                      context, 'book_trip_children_number'),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 40,
                            child: FittedBox(
                              child: Row(
                                children: <Widget>[
                                  MaterialButton(
                                    padding: const EdgeInsets.all(2.0),
                                    shape: CircleBorder(
                                      side: BorderSide(
                                          width: 2,
                                          color: Color(0xff07898B),
                                          style: BorderStyle.solid),
                                    ),
                                    child: Icon(
                                      MyIcons.minus,
                                      size: 10,
                                      color: Color(0xff07898B),
                                    ),
                                    color: Colors.white,
                                    onPressed: () {
                                      if (_childrenNumber > 0)
                                        setState(() {
                                          _childrenNumber -= 1;
                                        });
                                    },
                                  ),
                                  Container(
                                    child: Text(
                                      _childrenNumber.toString(),
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xff07898B),
                                      ),
                                    ),
                                  ),
                                  MaterialButton(
                                    padding: const EdgeInsets.all(2.0),
                                    shape: CircleBorder(
                                      side: BorderSide(
                                          width: 2,
                                          color: Color(0xff07898B),
                                          style: BorderStyle.solid),
                                    ),
                                    child: Icon(
                                      Icons.add,
                                      size: 15,
                                      color: Color(0xff07898B),
                                    ),
                                    color: Colors.white,
                                    onPressed: () {
                                      if (_childrenNumber < 50)
                                        setState(() {
                                          _childrenNumber += 1;
                                        });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: screenHeight * 0.1,
                      width: screenWidth * 0.9,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            flex: 50,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0),
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                alignment: AlignmentDirectional.centerStart,
                                child: Text(
                                  getTranslated(
                                      context, 'book_trip_babies_number'),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 40,
                            child: FittedBox(
                              child: Row(
                                children: <Widget>[
                                  MaterialButton(
                                    padding: const EdgeInsets.all(2.0),
                                    shape: CircleBorder(
                                      side: BorderSide(
                                          width: 2,
                                          color: Color(0xff07898B),
                                          style: BorderStyle.solid),
                                    ),
                                    child: Icon(
                                      MyIcons.minus,
                                      size: 10,
                                      color: Color(0xff07898B),
                                    ),
                                    color: Colors.white,
                                    onPressed: () {
                                      if (_babiesNumber > 0)
                                        setState(() {
                                          _babiesNumber -= 1;
                                        });
                                    },
                                  ),
                                  Container(
                                    child: Text(
                                      _babiesNumber.toString(),
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xff07898B),
                                      ),
                                    ),
                                  ),
                                  MaterialButton(
                                    padding: const EdgeInsets.all(2.0),
                                    shape: CircleBorder(
                                      side: BorderSide(
                                          width: 2,
                                          color: Color(0xff07898B),
                                          style: BorderStyle.solid),
                                    ),
                                    child: Icon(
                                      Icons.add,
                                      size: 15,
                                      color: Color(0xff07898B),
                                    ),
                                    color: Colors.white,
                                    onPressed: () {
                                      if (_babiesNumber < 50)
                                        setState(() {
                                          _babiesNumber += 1;
                                        });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: screenWidth * 0.9,
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Container(
                        width: screenWidth * 0.84,
                        padding:
                        EdgeInsets.only(top: 0.0, right: 0.0, left: 0.0, bottom: 0.0),
                        child: TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.white,
                            side: BorderSide(color: Colors.black, width: 1),
                          ),
                          onPressed: () {
                            _presentDatePicker();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                flex: 90,
                                child: Text(
                                  getTranslated(context, 'pyt_in_t_date_btn'),
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0XFFbbbbbb),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 10,
                                child: Icon(
                                  Icons.date_range_outlined,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: screenWidth * 0.9,
                      child: TextField(
                        keyboardType: TextInputType.text,
                        // controller: _emailController,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.start,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 1.0 , horizontal: 6.0),
                            hintText: getTranslated(context, 'book_trip_email'),
                            hintStyle: TextStyle(
                              fontSize: 14.0,
                              color: Color(0xffC3C2C3),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: BorderSide(
                                width: 1,
                                color: Colors.black,
                              ),
                            ),
                            fillColor: Colors.white,
                            focusColor: Colors.black,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: BorderSide(
                                width: 1,
                                color: Colors.black,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: BorderSide(
                                width: 1,
                                color: Colors.black,
                              ),
                            ),
                            filled: true),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
                      child: GFButton(
                        color: Color(0xff07898b),
                        textColor: Colors.white,
                        fullWidthButton: true,
                        text: getTranslated(context, 'fo_edit_save'),
                        size: 50.0,
                        textStyle: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                        onPressed: () {
                          setState((){
                            _totalPassengersNumber = _adultsNumber + _childrenNumber + _babiesNumber;
                          });

                          Navigator.pop(context);

                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
        });
  }

  @override
  void initState() {
    super.initState();

    betaApiAssistant.getOffer(widget.id, '2021-05-04').then((value) {
      setState(() {
        offer = value;
        _isLoading = false;
        getOfferImages();
        buildHotelsList(offer);
        calculateOfferNumber(offer);
        _pickedDate = DateFormat('MM/dd').parse(offer.days[0].trips[0].date.toString());
      });
    });
  }

  _commentsWidget(width, height) {
    return Column(
      children: <Widget>[
        for (int i = 0; i < _comments.length; i++)
          Row(
            children: [
              Container(
                  width: width * 0.94,
                  padding: EdgeInsetsDirectional.only(
                      start: width * 0.08, top: 10.0, bottom: 10.0),
                  child: Card(
                    elevation: 2.0,
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundImage:
                            AssetImage('assets/images/profile.jpg'),
                      ),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 70,
                            child: Row(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: width * 0.35,
                                      child: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        alignment: AlignmentDirectional.centerStart,
                                        child: Text(
                                          getTranslated(
                                              context, 'do_comments_username'),
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 75,
                                      child: FittedBox(
                                        child: GFRating(
                                          color: Colors.amber,
                                          borderColor: Colors.amber,
                                          allowHalfRating: true,
                                          value: 3.5,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 30,
                            child: Text(
                              '12-1-2021',
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                        ],
                      ),
                      subtitle: Text(_comments[i].toString()),
                    ),
                  )),
            ],
          ),
      ],
    );
  }

  void getOfferImages() {
    for (int index = 0; index < offer.days.length; index++)
      for (int tIndex = 0; tIndex < offer.days[index].trips.length; tIndex++)
        _imageList.add(offer.days[index].trips[tIndex].image);
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final double screenHeight =
        MediaQuery.of(context).size.height - statusBarHeight - kToolbarHeight;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // backgroundColor: Color(0xffE9F7F8),
        backgroundColor: Colors.white,
        elevation: 0.0,
        shadowColor: Colors.white,
        // title: Text(
        //   widget.package,
        // ),
        centerTitle: true,
      ),
      floatingActionButton: GFButton(
        onPressed: () {
          Navigator.of(context).push(new MaterialPageRoute(
            builder: (BuildContext context) => new ConfirmBook()));
        },
        size: 40,
        shape: GFButtonShape.pills,
        color: Color(0xff07898B),
        child: Container(
          width: screenWidth * 0.6,
          height: screenHeight * 0.07,
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 60,
                child: Text(
                  '550 \$',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Expanded(
                flex: 40,
                child: Text(
                  getTranslated(context, 'domestic_offer_book_btn'),
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 16,
                    // fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
        textStyle: TextStyle(
          fontFamily: 'cairo',
        ),
      ),
      // Container(
      //   width: screenWidth * 1.02,
      //   child: Stack(
      //     fit: StackFit.passthrough,
      //     children: <Widget>[
      //
      //       Padding(
      //         padding: const EdgeInsets.all(0),
      //         child: Flex(
      //           direction: Axis.vertical,
      //           mainAxisAlignment:
      //           MainAxisAlignment.end,
      //           children: <Widget>[
      //             Opacity(
      //               opacity: 0.4,
      //               child: Container(
      //                 color: Colors.blueGrey,
      //                 width: screenWidth * 1.02,
      //                 height: screenHeight * 0.07,
      //               ),
      //             ),
      //           ],
      //         ),
      //       ),
      //
      //     //   Row(
      //     //   children: <Widget>[
      //     //     Expanded(
      //     //       flex: 70,
      //     //       child: Text(
      //     //         '550 \$',
      //     //         textAlign: TextAlign.start,
      //     //         style: TextStyle(
      //     //           fontSize: 18,
      //     //           fontWeight: FontWeight.bold,
      //     //           color: Color(0xff07898B),
      //     //         ),
      //     //       ),
      //     //     ),
      //     //   ],
      //     // ),
      //     ],
      //   ),
      // ),
      body: _isLoading
          ? Center(
              child: GFLoader(
                type: GFLoaderType.circle,
                loaderColorOne: Color(0xff07898B),
                loaderColorTwo: Color(0xff07898B),
                loaderColorThree: Color(0xff07898B),
              ),
            )
          : SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: screenWidth * 0.84,
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: GestureDetector(
                      onTap: () {},
                      child: InkWell(
                        borderRadius: BorderRadius.circular(4.0),
                        onTap: () {},
                        child: Card(
                          shadowColor: Colors.white,
                          elevation: 0.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          clipBehavior: Clip.antiAlias,
                          margin: const EdgeInsets.all(0.0),
                          color: Color(0xffFAFAFA),
                          child: Padding(
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
                                    child: Image.network(
                                      'https://ipackagetours.com/storage/app/' +
                                          offer.image.toString(),
                                      fit: BoxFit.fill,
                                      height: screenHeight * 0.26,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(6),
                                  child: Flex(
                                    direction: Axis.horizontal,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(0.0),
                                            margin: EdgeInsets.only(
                                                top: screenHeight * 0.17),
                                            constraints: BoxConstraints(),
                                            child: Container(
                                              width: 100,
                                              padding:
                                                  const EdgeInsets.all(3.0),
                                              child: FittedBox(
                                                child: GFRating(
                                                  color: Colors.amber,
                                                  borderColor: Colors.amber,
                                                  allowHalfRating: true,
                                                  value: double.parse(
                                                      widget.rating.toString()),
                                                ),
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
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: screenWidth * 0.84,
                    child: Column(
                      children: <Widget>[
                        ResponsiveGridRow(
                          children: [
                            for (var i = 0; i < _imageList.length; i++)
                              ResponsiveGridCol(
                                xs: 3,
                                md: 3,
                                child: Container(
                                    margin: const EdgeInsets.all(5.0),
                                    padding: const EdgeInsets.all(0.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    alignment: Alignment(0, 0),
                                    //color: Colors.grey,
                                    child: InkWell(
                                      onTap: () {},
                                      child: Card(
                                        margin: const EdgeInsets.all(0),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(7),
                                        ),
                                        clipBehavior: Clip.antiAlias,
                                        child: Image.network(
                                          'https://ipackagetours.com/storage/app/' +
                                              _imageList[i].toString(),
                                          fit: BoxFit.fill,
                                          height: screenHeight * 0.07,
                                          width: screenWidth * 0.2,
                                        ),
                                      ),
                                    )),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        width: screenWidth * 0.84,
                        padding: EdgeInsetsDirectional.only(
                            start: screenWidth * 0.08, top: 20.0, bottom: 5.0),
                        child: Row(
                          children: [
                            Flexible(
                              child: Text(
                                localAssistant
                                    .getOfferByLocale(context, offer, 'des')
                                    .toString(),
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff07898B),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  // Days number
                  Row(
                    children: [
                      Container(
                        width: screenWidth * 0.9,
                        padding: EdgeInsetsDirectional.only(
                            start: screenWidth * 0.08, top: 10.0, bottom: 10.0),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 40,
                              child: Row(
                                children: [
                                  Flexible(
                                    child: Text(
                                      offer.daysNumber.toString() +
                                          ' ' +
                                          getTranslated(
                                              context, 'home_offer_card_days'),
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
                            Expanded(
                              flex: 60,
                              child: Text(
                                widget.package.toString(),
                                textAlign: TextAlign.end,
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

                  // Divider
                  Container(
                    width: screenWidth * 0.84,
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Divider(
                      color: Colors.black54,
                      thickness: 1,
                    ),
                  ),

                  // Country
                  Container(
                    width: screenWidth * 0.84,
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 25,
                          child: FittedBox(
                            child: Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Text(
                                localAssistant
                                    .getOfferByLocale(context, offer, 'country')
                                    .toString(),
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 35,
                          child: FittedBox(
                              fit: BoxFit.scaleDown,
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(
                                _totalPassengersNumber.toString() + ' ' +
                                getTranslated(context, 'fo_passengers'),
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 20,
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Text(
                                formatter.format(_pickedDate).toString(),
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                            flex: 20,
                            child: TextButton(
                              onPressed: () {
                                _openEditPackageWidget(screenWidth, screenHeight);
                              },
                              child: Text(
                                getTranslated(context, 'fo_edit'),
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xff07898B),
                                ),
                              ),
                            )),
                      ],
                    ),
                  ),

                  // Divider
                  Container(
                    width: screenWidth * 0.84,
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Divider(
                      color: Colors.black54,
                      thickness: 1,
                    ),
                  ),

                  Row(
                    children: [
                      Container(
                        padding: EdgeInsetsDirectional.only(
                            start: screenWidth * 0.08, top: 20.0, bottom: 10.0),
                        child: Text(
                          getTranslated(context, 'do_plan_label_15'),
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Tab bar
                  Padding(
                    padding: EdgeInsetsDirectional.only(
                        start: screenWidth * 0.06, top: 8.0, bottom: 20.0),
                    child: Container(
                      height: screenHeight * 0.1,
                      child: ListView(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          Padding(
                            padding:
                                const EdgeInsetsDirectional.only(end: 10.0),
                            child: GFButtonBadge(
                              onPressed: () {
                                setState(() {
                                  widgetIndex = 0;
                                  dayIndex = -1;
                                });
                              },
                              color: Colors.white,
                              textColor: Colors.black,
                              elevation: 3.0,
                              text: getTranslated(context, 'fo_trip_plan'),
                              textStyle: TextStyle(
                                fontFamily: 'cairo',
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsetsDirectional.only(end: 10.0),
                            child: GFButtonBadge(
                              onPressed: () {
                                setState(() {
                                  widgetIndex = 1;
                                });
                              },
                              color: Colors.white,
                              textColor: Colors.black,
                              elevation: 3.0,
                              text: getTranslated(context, 'do_hotels_tab'),
                              textStyle: TextStyle(
                                fontFamily: 'cairo',
                                color: Colors.black,
                              ),
                              icon: GFBadge(
                                color: Color(0xffBDBDBD),
                                textColor: Colors.black,
                                child: Text(
                                  offerHotels.length.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                                shape: GFBadgeShape.circle,
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsetsDirectional.only(end: 10.0),
                            child: GFButtonBadge(
                              onPressed: () {
                                setState(() {
                                  widgetIndex = 2;
                                });
                              },
                              color: Colors.white,
                              textColor: Colors.black,
                              elevation: 3.0,
                              text: getTranslated(context, 'do_flights_tab'),
                              textStyle: TextStyle(
                                fontFamily: 'cairo',
                                color: Colors.black,
                              ),
                              icon: GFBadge(
                                color: Color(0xffBDBDBD),
                                textColor: Colors.black,
                                child: Text(
                                  "0",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                                shape: GFBadgeShape.circle,
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsetsDirectional.only(end: 10.0),
                            child: GFButtonBadge(
                              onPressed: () {
                                setState(() {
                                  widgetIndex = 3;
                                });
                              },
                              color: Colors.white,
                              textColor: Colors.black,
                              elevation: 3.0,
                              text: getTranslated(context, 'do_transfer_tab'),
                              textStyle: TextStyle(
                                fontFamily: 'cairo',
                                color: Colors.black,
                              ),
                              icon: GFBadge(
                                color: Color(0xffBDBDBD),
                                textColor: Colors.black,
                                child: Text(
                                  transferNumber.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                                shape: GFBadgeShape.circle,
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsetsDirectional.only(end: 10.0),
                            child: GFButtonBadge(
                              onPressed: () {
                                setState(() {
                                  widgetIndex = 4;
                                });
                              },
                              color: Colors.white,
                              textColor: Colors.black,
                              elevation: 3.0,
                              text: getTranslated(context, 'do_activities_tab'),
                              textStyle: TextStyle(
                                fontFamily: 'cairo',
                                color: Colors.black,
                              ),
                              icon: GFBadge(
                                color: Color(0xffBDBDBD),
                                textColor: Colors.black,
                                child: Text(
                                  activitiesNumber.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                                shape: GFBadgeShape.circle,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  _widgetRouter(screenWidth, screenHeight),

                  Row(
                    children: [
                      Container(
                        padding: EdgeInsetsDirectional.only(
                            start: screenWidth * 0.08, top: 20.0, bottom: 10.0),
                        child: Text(
                          getTranslated(context, 'do_comments'),
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

                  _commentsWidget(screenWidth, screenHeight),

                  Row(
                    children: [
                      Container(
                        padding: EdgeInsetsDirectional.only(
                            start: screenWidth * 0.08, top: 20.0, bottom: 8.0),
                        child: Text(
                          getTranslated(context, 'do_similar_packages'),
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
                  Padding(
                    padding: EdgeInsetsDirectional.only(
                        start: screenWidth * 0.06, top: 8.0, bottom: 20.0),
                    child: Container(
                      height: screenHeight * 0.66,
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
                                  Navigator.of(context).push(
                                      new MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              new DomesticOfferMain()));
                                },
                                child: Card(
                                  shadowColor: Colors.white,
                                  elevation: 0.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  clipBehavior: Clip.antiAlias,
                                  margin: const EdgeInsets.all(0.0),
                                  color: Color(0xffFAFAFA),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
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
                                                          BorderRadius.circular(
                                                              15)),
                                                ),
                                                child: Image.asset(
                                                  'assets/images/c4.jpg',
                                                  fit: BoxFit.fill,
                                                  height: screenHeight * 0.28,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(6),
                                              child: Flex(
                                                direction: Axis.horizontal,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: <Widget>[
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            3.0),
                                                    margin:
                                                        const EdgeInsets.only(
                                                            top: 20.0),
                                                    constraints:
                                                        BoxConstraints(),
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      border: Border.all(
                                                        color: Colors.white,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(10.0),
                                                      ),
                                                    ),
                                                    child: Text(
                                                      getTranslated(context,
                                                          'home_offer_card_tag'),
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              flex: 50,
                                              child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 0.0,
                                                          right: 0.0,
                                                          left: 0.0,
                                                          bottom: 0.0),
                                                  child: Text(
                                                    getTranslated(context,
                                                        'home_offer_card_days'),
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 15,
                                                        color: Colors.black),
                                                  )),
                                            ),
                                            Expanded(
                                              flex: 50,
                                              child: FittedBox(
                                                child: GFRating(
                                                  color: Colors.amber,
                                                  borderColor: Colors.amber,
                                                  allowHalfRating: true,
                                                  value: 3.5,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          getTranslated(context,
                                                  'home_offer_card_price') +
                                              ' 220\$',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                              color: Colors.black),
                                          softWrap: true,
                                        ),
                                      ),

                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Text(
                                          getTranslated(context,
                                              'home_offer_card_details'),
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: Colors.brown,
                                          ),
                                          softWrap: true,
                                        ),
                                      ),

                                      Padding(
                                        padding: const EdgeInsets.all(0.0),
                                        child: Container(
                                          padding: const EdgeInsets.all(5.0),
                                          color: Color(0xff07898B),
                                          height: screenHeight * 0.11,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: <Widget>[
                                              Expanded(
                                                flex: 25,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(2.0),
                                                  child: Column(
                                                    children: <Widget>[
                                                      Icon(
                                                        MyIcons.bed,
                                                        color: Colors.white,
                                                      ),
                                                      Container(
                                                        margin: const EdgeInsets
                                                            .only(top: 6.0),
                                                        child: FittedBox(
                                                          child: Text(
                                                            getTranslated(
                                                                context,
                                                                'home_offer_card_rate'),
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 25,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(2.0),
                                                  child: Column(
                                                    children: <Widget>[
                                                      Icon(
                                                        Icons
                                                            .airplanemode_inactive,
                                                        color: Colors.white,
                                                      ),
                                                      Container(
                                                        margin: const EdgeInsets
                                                            .only(top: 4.0),
                                                        child: FittedBox(
                                                          child: Text(
                                                            getTranslated(
                                                                context,
                                                                'home_offer_card_flight'),
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 25,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(2.0),
                                                  child: Column(
                                                    children: <Widget>[
                                                      Image.asset(
                                                          'assets/icons/dish.png'),
                                                      Container(
                                                        margin: const EdgeInsets
                                                            .only(top: 4.0),
                                                        child: FittedBox(
                                                          child: Text(
                                                            getTranslated(
                                                                context,
                                                                'home_offer_card_breakfast'),
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 25,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(2.0),
                                                  child: Column(
                                                    children: <Widget>[
                                                      Icon(
                                                        Icons
                                                            .directions_car_outlined,
                                                        color: Colors.white,
                                                      ),
                                                      Container(
                                                        margin: const EdgeInsets
                                                            .only(top: 4.0),
                                                        child: FittedBox(
                                                          child: Text(
                                                            getTranslated(
                                                                context,
                                                                'home_offer_card_transportation'),
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
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
                                onTap: () {},
                                child: Card(
                                  shadowColor: Colors.white,
                                  elevation: 0.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  clipBehavior: Clip.antiAlias,
                                  margin: const EdgeInsets.all(0.0),
                                  color: Color(0xffFAFAFA),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
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
                                                          BorderRadius.circular(
                                                              15)),
                                                ),
                                                child: Image.asset(
                                                  'assets/images/c4.jpg',
                                                  fit: BoxFit.fill,
                                                  height: screenHeight * 0.28,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(6),
                                              child: Flex(
                                                direction: Axis.horizontal,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: <Widget>[
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            3.0),
                                                    margin:
                                                        const EdgeInsets.only(
                                                            top: 20.0),
                                                    constraints:
                                                        BoxConstraints(),
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      border: Border.all(
                                                        color: Colors.white,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(10.0),
                                                      ),
                                                    ),
                                                    child: Text(
                                                      getTranslated(context,
                                                          'home_offer_card_tag'),
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              flex: 50,
                                              child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 0.0,
                                                          right: 0.0,
                                                          left: 0.0,
                                                          bottom: 0.0),
                                                  child: Text(
                                                    getTranslated(context,
                                                        'home_offer_card_days'),
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 15,
                                                        color: Colors.black),
                                                  )),
                                            ),
                                            Expanded(
                                              flex: 50,
                                              child: FittedBox(
                                                child: GFRating(
                                                  color: Colors.amber,
                                                  borderColor: Colors.amber,
                                                  allowHalfRating: true,
                                                  value: 3.5,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          getTranslated(context,
                                                  'home_offer_card_price') +
                                              ' 220\$',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                              color: Colors.black),
                                          softWrap: true,
                                        ),
                                      ),

                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Text(
                                          getTranslated(context,
                                              'home_offer_card_details'),
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: Colors.brown,
                                          ),
                                          softWrap: true,
                                        ),
                                      ),

                                      Padding(
                                        padding: const EdgeInsets.all(0.0),
                                        child: Container(
                                          padding: const EdgeInsets.all(5.0),
                                          color: Color(0xff07898B),
                                          height: screenHeight * 0.11,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: <Widget>[
                                              Expanded(
                                                flex: 25,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(2.0),
                                                  child: Column(
                                                    children: <Widget>[
                                                      Icon(
                                                        MyIcons.bed,
                                                        color: Colors.white,
                                                      ),
                                                      Container(
                                                        margin: const EdgeInsets
                                                            .only(top: 4.0),
                                                        child: FittedBox(
                                                          child: Text(
                                                            getTranslated(
                                                                context,
                                                                'home_offer_card_rate'),
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 25,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(2.0),
                                                  child: Column(
                                                    children: <Widget>[
                                                      Icon(
                                                        Icons
                                                            .airplanemode_inactive,
                                                        color: Colors.white,
                                                      ),
                                                      Container(
                                                        margin: const EdgeInsets
                                                            .only(top: 4.0),
                                                        child: FittedBox(
                                                          child: Text(
                                                            getTranslated(
                                                                context,
                                                                'home_offer_card_flight'),
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 25,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(2.0),
                                                  child: Column(
                                                    children: <Widget>[
                                                      Image.asset(
                                                          'assets/icons/dish.png'),
                                                      Container(
                                                        margin: const EdgeInsets
                                                            .only(top: 4.0),
                                                        child: FittedBox(
                                                          child: Text(
                                                            getTranslated(
                                                                context,
                                                                'home_offer_card_breakfast'),
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 25,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(2.0),
                                                  child: Column(
                                                    children: <Widget>[
                                                      Icon(
                                                        Icons
                                                            .directions_car_outlined,
                                                        color: Colors.white,
                                                      ),
                                                      Container(
                                                        margin: const EdgeInsets
                                                            .only(top: 4.0),
                                                        child: FittedBox(
                                                          child: Text(
                                                            getTranslated(
                                                                context,
                                                                'home_offer_card_transportation'),
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
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
                                onTap: () {},
                                child: Card(
                                  shadowColor: Colors.white,
                                  elevation: 0.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  clipBehavior: Clip.antiAlias,
                                  margin: const EdgeInsets.all(0.0),
                                  color: Color(0xffFAFAFA),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
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
                                                          BorderRadius.circular(
                                                              15)),
                                                ),
                                                child: Image.asset(
                                                  'assets/images/c4.jpg',
                                                  fit: BoxFit.fill,
                                                  height: screenHeight * 0.28,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(6),
                                              child: Flex(
                                                direction: Axis.horizontal,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: <Widget>[
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            3.0),
                                                    margin:
                                                        const EdgeInsets.only(
                                                            top: 20.0),
                                                    constraints:
                                                        BoxConstraints(),
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      border: Border.all(
                                                        color: Colors.white,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(10.0),
                                                      ),
                                                    ),
                                                    child: Text(
                                                      getTranslated(context,
                                                          'home_offer_card_tag'),
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              flex: 50,
                                              child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 0.0,
                                                          right: 0.0,
                                                          left: 0.0,
                                                          bottom: 0.0),
                                                  child: Text(
                                                    getTranslated(context,
                                                        'home_offer_card_days'),
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 15,
                                                        color: Colors.black),
                                                  )),
                                            ),
                                            Expanded(
                                              flex: 50,
                                              child: FittedBox(
                                                child: GFRating(
                                                  color: Colors.amber,
                                                  borderColor: Colors.amber,
                                                  allowHalfRating: true,
                                                  value: 3.5,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          getTranslated(context,
                                                  'home_offer_card_price') +
                                              ' 220\$',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                              color: Colors.black),
                                          softWrap: true,
                                        ),
                                      ),

                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Text(
                                          getTranslated(context,
                                              'home_offer_card_details'),
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: Colors.brown,
                                          ),
                                          softWrap: true,
                                        ),
                                      ),

                                      Padding(
                                        padding: const EdgeInsets.all(0.0),
                                        child: Container(
                                          padding: const EdgeInsets.all(5.0),
                                          color: Color(0xff07898B),
                                          height: screenHeight * 0.11,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: <Widget>[
                                              Expanded(
                                                flex: 25,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(2.0),
                                                  child: Column(
                                                    children: <Widget>[
                                                      Icon(
                                                        MyIcons.bed,
                                                        color: Colors.white,
                                                      ),
                                                      Container(
                                                        margin: const EdgeInsets
                                                            .only(top: 4.0),
                                                        child: FittedBox(
                                                          child: Text(
                                                            getTranslated(
                                                                context,
                                                                'home_offer_card_rate'),
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 25,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(2.0),
                                                  child: Column(
                                                    children: <Widget>[
                                                      Icon(
                                                        Icons
                                                            .airplanemode_inactive,
                                                        color: Colors.white,
                                                      ),
                                                      Container(
                                                        margin: const EdgeInsets
                                                            .only(top: 4.0),
                                                        child: FittedBox(
                                                          child: Text(
                                                            getTranslated(
                                                                context,
                                                                'home_offer_card_flight'),
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 25,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(2.0),
                                                  child: Column(
                                                    children: <Widget>[
                                                      Image.asset(
                                                          'assets/icons/dish.png'),
                                                      Container(
                                                        margin: const EdgeInsets
                                                            .only(top: 4.0),
                                                        child: FittedBox(
                                                          child: Text(
                                                            getTranslated(
                                                                context,
                                                                'home_offer_card_breakfast'),
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 25,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(2.0),
                                                  child: Column(
                                                    children: <Widget>[
                                                      Icon(
                                                        Icons
                                                            .directions_car_outlined,
                                                        color: Colors.white,
                                                      ),
                                                      Container(
                                                        margin: const EdgeInsets
                                                            .only(top: 4.0),
                                                        child: FittedBox(
                                                          child: Text(
                                                            getTranslated(
                                                                context,
                                                                'home_offer_card_transportation'),
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
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
            ),
    );
  }
}
