import 'package:flutter/material.dart';
import 'package:getwidget/components/rating/gf_rating.dart';
import 'package:getwidget/getwidget.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:intl/intl.dart';
import 'package:ipackage/localization/localizationValues.dart';
import 'package:ipackage/modules/Offer/Airport.dart';
import 'package:ipackage/modules/Offer/Flight/Flight.dart';
import 'package:ipackage/modules/Offer/Flight/FlightSegment.dart';
import 'package:ipackage/modules/Offer/Hotel/Hotel.dart';
import 'package:ipackage/modules/Offer/Transportations/MinTransportation.dart';
import 'package:ipackage/modules/Offer/Transportations/Transportation.dart';
import 'package:ipackage/modules/Offer/Trip.dart';
import 'package:ipackage/modules/my_icons.dart';
import 'package:ipackage/widgets/confirm_book.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  SharedPreferences prefs;
  Offer offer;
  bool _isLoading = true;
  int dayIndex = -1;
  int widgetIndex = 0;
  int transferNumber = 0;
  int flightNumber = 0;
  int activitiesNumber = 0;
  List<Hotel> offerHotels = [];
  List<String> _imageList = [];
  int _adultsNumber = 2;
  int _childrenNumber = 0;
  int _babiesNumber = 0;
  var now = new DateTime.now();
  var formatter = new DateFormat('MM/dd');
  var fullFormatter = new DateFormat('yyyy-MM-dd');
  int _totalPassengersNumber = 1;
  MinTransportation shiftTransportation;
  List<FlightSegment> shiftFlightSegments;
  Trip shiftTrip;
  Hotel shiftHotel;
  double _totalOfferPrice = 0;
  int carNumber = 0;
  String _originCode = ' ';
  String _destinationCode;
  List<Flight> _flights = [];
  List<Flight> _flightsBack = [];
  List<Airport> _airports = [];
  bool _isPriceLoading = true;
  bool _isAirportResults = false;
  bool _isAirportLoading = true;
  bool _isFlightsLoading = false;
  bool _isNotLocked = true;
  final TextEditingController _nameController = new TextEditingController();
  int totalTripDays = 0;
  String firstFlightDate = ' ';
  String hotelsCheckInDate = ' ';
  String lastFlightDate;
  String day;
  String month;
  String year;
  int totalFlightsNumber = 0;
  bool _isFlight = false;
  List<String> _hotelsCheckInDates = [];

  // List<String> _comments = [
  //   "لقد كانت رحلة رائعة لقد كانت رحلة رائعة لقد كانت رحلة رائعة",
  //   "لقد كانت رحلة رائعة",
  // ];

  Future _loadUserPreferences() async {
    final key = 'source_airport_code';
    final value = prefs.getString(key);
    if (value != null)
      setState(() {
        _originCode = value;
      });

    final key6 = 'source_airport';
    final value6 = prefs.getString(key6);
    if (value6 != null)
      setState(() {
        _nameController.text = value6 + ' - ' + value.toString();
      });

    // final key2 = 'destination_country';
    // final value2 = prefs.getString(key2);
    // if(value2 != null)
    //   setState(() {
    //     _destinationBtnLabel = value2;
    //   });

    // final key8 = 'destination_country_id';
    // final value8 = prefs.getInt(key8);
    // if(value8 != null)
    //   setState(() {
    //     _destinationCountryId = value8;
    //   });

    final key3 = 'departure_date';
    final value3 = prefs.getString(key3);
    if (value3 != null)
      setState(() {
        firstFlightDate = value3;
      });

    final key4 = 'adults_number';
    final value4 = prefs.getInt(key4);
    if (value4 != null)
      setState(() {
        _adultsNumber = value4;
      });

    final key5 = 'children_number';
    final value5 = prefs.getInt(key5);
    if (value5 != null)
      setState(() {
        _childrenNumber = value5;
      });

    final key7 = 'is_flight';
    final value7 = prefs.getBool(key7);
    if (value7 != null)
      setState(() {
        _isFlight = value7;
      });

    // final key9 = 'package_name';
    // final value9 = prefs.getString(key9);
    // if(value9 != null)
    //   setState(() {
    //     _packageBtnLabel = value9;
    //   });

    // final key10 = 'package_id';
    // final value10 = prefs.getInt(key10);
    // if(value10 != null)
    //   setState(() {
    //     _packageId = value10;
    //   });
  }

  void calculateFlightsDates() {
    setState(() {
      // Calculate total trip days
      for (int index = 0; index < offer.days.length; index++)
        for (int pointer = 0;
            pointer < offer.days[index].trips.length;
            pointer++) totalTripDays += 1;

      // Generate last flight date
      lastFlightDate = fullFormatter
          .format(DateTime.parse(firstFlightDate)
              .add(Duration(days: totalTripDays)))
          .toString();
      print(lastFlightDate);
    });
  }

  void calculateHotelsCheckInDates() {
    for (int index = 1; index < offer.days.length; index++) {
      _hotelsCheckInDates.add(fullFormatter
          .format(DateTime.parse(_hotelsCheckInDates[index - 1])
              .add(Duration(days: offer.days[index].trips.length)))
          .toString());

      print('Hotel date: '+ _hotelsCheckInDates[index]);
    }
  }

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

  void getOfferHotelsImages()
  {
    for(int index = 0 ; index < offer.days.length ; index++)
      betaApiAssistant.getHotelImage(offer.days[index].hotels[0].id).then((value) {
        setState(() {
          offer.days[index].hotels[0].images = value.toString();
        });
      });
  }

  changeTransportationVisibility(Transportation transportation) {
      showDialog(
          context: context,
          builder: (_) => AssetGiffyDialog(
                onlyOkButton: true,
                buttonCancelText: Text(
                    getTranslated(context, 'login_alert_d_cancel'),
                    style: TextStyle(fontSize: 16)),
                buttonOkText: Text(getTranslated(context, 'edit_book_delete'),
                    style: TextStyle(fontSize: 16, color: Colors.white)),
                buttonOkColor: Colors.redAccent,
                image: Image.asset('assets/images/alert.png', fit: BoxFit.cover),
                title: Text(
                  getTranslated(context, 'home_alert_login_title'),
                  style: TextStyle(fontSize: 18.0, color: Colors.teal),
                ),
                description: Text(
                  getTranslated(context, 'fo_remove_note'),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
                onOkButtonPressed: () {
                  setState(() {
                    transportation.visibility = false;
                    dayIndex = -1;
                  });
                  Navigator.pop(context);
                  calculateOfferPrice();
                },
              ));
  }

  void changeTransportation(context, screenWidth, screenHeight, type, dIndex,
      List<MinTransportation> transportationList) {
    showDialog(
        context: context,
        builder: (BuildContext bc) {
          return Dialog(
            child: Container(
              width: screenWidth * 0.9,
              height: screenHeight * 0.7,
              child: Column(
                children: [
                  Container(
                    width: screenWidth * 0.9,
                    color: Color(0xff07898B),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        getTranslated(context, 'fo_change_trans_title'),
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                  ListView.builder(
                      itemCount: transportationList.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Container(
                          width: screenWidth * 0.8,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(4.0),
                            child: Card(
                              elevation: 2.0,
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
                                            transportationList[index]
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
                                        width: screenWidth * 0.45,
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
                                                      .getTransportationByLocale(
                                                          context,
                                                          transportationList[
                                                                  index]
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
                                        height: screenHeight * 0.06,
                                        width: screenWidth * 0.45,
                                        padding: const EdgeInsets.all(4.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Expanded(
                                              flex: 78,
                                              child: Text(''),
                                            ),
                                            Expanded(
                                              flex: 22,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(2.0),
                                                child: GFButton(
                                                  onPressed: () {
                                                    if (type == 2) {
                                                      setState(() {
                                                        shiftTransportation =
                                                            offer.airportTransferBack[
                                                                0];
                                                        offer.airportTransferBack[
                                                                0] =
                                                            transportationList[
                                                                index];
                                                        transportationList[
                                                                index] =
                                                            shiftTransportation;
                                                        dayIndex = -1;
                                                      });
                                                      Navigator.pop(context);
                                                    } else if (type == 1) {
                                                      setState(() {
                                                        shiftTransportation = offer
                                                            .days[dIndex]
                                                            .transportationMethods
                                                            .additionalTrans[0];
                                                        offer
                                                                .days[dIndex]
                                                                .transportationMethods
                                                                .additionalTrans[0] =
                                                            transportationList[
                                                                index];
                                                        transportationList[
                                                                index] =
                                                            shiftTransportation;
                                                        dayIndex = -1;
                                                      });
                                                      Navigator.pop(context);
                                                    } else {
                                                      setState(() {
                                                        shiftTransportation =
                                                            offer.airportTransferGo[
                                                                0];
                                                        offer.airportTransferGo[
                                                                0] =
                                                            transportationList[
                                                                index];
                                                        transportationList[
                                                                index] =
                                                            shiftTransportation;
                                                        dayIndex = -1;
                                                      });
                                                      Navigator.pop(context);
                                                      calculateOfferPrice();
                                                    }
                                                  },
                                                  color: Colors.teal,
                                                  child: Icon(
                                                    Icons.add,
                                                    size: 14,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ],
              ),
            ),
          );
        });
  }

  void changeDepartureFlight(context, screenWidth, screenHeight) {
    showDialog(
        context: context,
        builder: (BuildContext bc) {
          return Dialog(
            child: Container(
              width: screenWidth * 0.9,
              // height: screenHeight * 0.7,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: screenWidth * 0.85,
                      color: Color(0xff07898B),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          getTranslated(context, 'change_flight'),
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                    for (int index = 0; index < _flights.length; index++)
                      Container(
                        width: screenWidth * 0.8,
                        child: Card(
                          elevation: 2.0,
                          child: Column(
                            children: <Widget>[
                              for (int index2 = 0;
                                  index2 <
                                      _flights[index]
                                          .originDestinationOptions[0]
                                          .flightSegments
                                          .length;
                                  index2++)
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 33,
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            // mainAxisAlignment: MainAxisAlignment.end,
                                            children: <Widget>[
                                              Align(
                                                alignment: AlignmentDirectional
                                                    .centerStart,
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .only(
                                                          start: screenWidth *
                                                              0.02),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            4.0),
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.all(2.0),
                                                      width: 25,
                                                      height: 25,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Color(0xffFFCECF),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50),
                                                        border: Border.all(
                                                          width: 3,
                                                          color:
                                                              Colors.redAccent,
                                                          style:
                                                              BorderStyle.solid,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Text(
                                                  _flights[index]
                                                      .originDestinationOptions[
                                                          0]
                                                      .flightSegments[index2]
                                                      .departureAirportLocationCode
                                                      .toString(),
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              )
                                            ],
                                          ),
                                          // Row(
                                          //   mainAxisAlignment: MainAxisAlignment.end,
                                          //   children: [
                                          //     Flexible(
                                          //       child: Text(
                                          //         localAssistant.getFlightSegmentByLocale(context, 'd', _flights[0].originDestinationOptions[0].flightSegments[index]).toString(),
                                          //         style: TextStyle(
                                          //           fontSize: 14,
                                          //           color: Colors.black38,
                                          //         ),
                                          //         textAlign: TextAlign.end,
                                          //       ),
                                          //     ),
                                          //   ],
                                          // ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                _flights[index]
                                                    .originDestinationOptions[0]
                                                    .flightSegments[index2]
                                                    .departureDateTime
                                                    .toString()
                                                    .substring(11),
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.black38,
                                                ),
                                                textAlign: TextAlign.end,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 33,
                                      child: Column(
                                        children: <Widget>[
                                          Icon(
                                            Icons.flight,
                                            color: Color(0xff07898B),
                                          ),
                                          Text(
                                            _flights[index]
                                                .originDestinationOptions[0]
                                                .flightSegments[index2]
                                                .journeyDuration
                                                .toString(),
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black38,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 33,
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Container(
                                                  padding: EdgeInsets.all(2.0),
                                                  width: 25,
                                                  height: 25,
                                                  decoration: BoxDecoration(
                                                    color: Color(0xffFFCECF),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                    border: Border.all(
                                                      width: 3,
                                                      color: Colors.redAccent,
                                                      style: BorderStyle.solid,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Text(
                                                  _flights[index]
                                                      .originDestinationOptions[
                                                          0]
                                                      .flightSegments[index2]
                                                      .arrivalAirportLocationCode
                                                      .toString(),
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              )
                                            ],
                                          ),
                                          // Row(
                                          //   // mainAxisAlignment: MainAxisAlignment.end,
                                          //   children: [
                                          //     Flexible(
                                          //       child: Text(
                                          //         localAssistant.getFlightSegmentByLocale(context, 'a', _flights[0].originDestinationOptions[0].flightSegments[index]).toString(),
                                          //         style: TextStyle(
                                          //           fontSize: 14,
                                          //           color: Colors.black38,
                                          //         ),
                                          //         textAlign: TextAlign.start,
                                          //       ),
                                          //     ),
                                          //   ],
                                          // ),
                                          Text(
                                            _flights[index]
                                                .originDestinationOptions[0]
                                                .flightSegments[index2]
                                                .arrivalDateTime
                                                .toString()
                                                .substring(11),
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black38,
                                            ),
                                            textAlign: TextAlign.end,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              Container(
                                height: screenHeight * 0.06,
                                width: screenWidth * 0.9,
                                padding: const EdgeInsets.all(4.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Expanded(
                                      flex: 28,
                                      child: Text(''),
                                    ),
                                    Expanded(
                                      flex: 44,
                                      child: Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: GFButton(
                                          onPressed: () {
                                            setState(() {
                                              shiftFlightSegments = List.of(
                                                  _flights[index]
                                                      .originDestinationOptions[
                                                          0]
                                                      .flightSegments);
                                              _flights[index]
                                                      .originDestinationOptions[0]
                                                      .flightSegments =
                                                  List.of(_flights[0]
                                                      .originDestinationOptions[
                                                          0]
                                                      .flightSegments);
                                              _flights[0]
                                                      .originDestinationOptions[0]
                                                      .flightSegments =
                                                  List.of(shiftFlightSegments);
                                              calculateOfferPrice();
                                              dayIndex = -1;
                                            });
                                            Navigator.pop(context);
                                          },
                                          color: Colors.teal,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.add,
                                                size: 14,
                                                color: Colors.white,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: FittedBox(
                                                  fit: BoxFit.scaleDown,
                                                  child: Text(
                                                    (_flights[index]
                                                                    .airItineraryPricingInfo
                                                                    .flightTotalFare
                                                                    .totalFare -
                                                                _flights[0]
                                                                    .airItineraryPricingInfo
                                                                    .flightTotalFare
                                                                    .totalFare)
                                                            .toStringAsFixed(
                                                                2) +
                                                        ' \$',
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 28,
                                      child: Text(''),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    // ListView.builder(
                    //     itemCount: _flights.length,
                    //     shrinkWrap: true,
                    //     itemBuilder: (context , index){
                    //       return Container(
                    //         width: screenWidth * 0.8,
                    //         child: Card(
                    //           elevation: 2.0,
                    //           child: Column(
                    //             children: <Widget>[
                    //               for(int index2 = 0 ; index2 < _flights[index].originDestinationOptions[0].flightSegments.length ; index2++)
                    //                 Row(
                    //                   children: [
                    //                     Expanded(
                    //                       flex: 33,
                    //                       child: Column(
                    //                         children: <Widget>[
                    //                           Row(
                    //                             // mainAxisAlignment: MainAxisAlignment.end,
                    //                             children: <Widget>[
                    //                               Align(
                    //                                 alignment: AlignmentDirectional.centerStart,
                    //                                 child: Padding(
                    //                                   padding: EdgeInsetsDirectional.only(start: screenWidth * 0.07),
                    //                                   child: Padding(
                    //                                     padding: const EdgeInsets.all(4.0),
                    //                                     child: Container(
                    //                                       padding: EdgeInsets.all(2.0),
                    //                                       width: 25,
                    //                                       height: 25,
                    //                                       decoration: BoxDecoration(
                    //                                         color: Color(0xffFFCECF),
                    //                                         borderRadius: BorderRadius.circular(50),
                    //                                         border: Border.all(
                    //                                           width: 3,
                    //                                           color: Colors.redAccent,
                    //                                           style: BorderStyle.solid,
                    //                                         ),
                    //                                       ),
                    //                                     ),
                    //                                   ),
                    //                                 ),
                    //                               ),
                    //                               Padding(
                    //                                 padding: const EdgeInsets.all(4.0),
                    //                                 child: Text(
                    //                                   _flights[index].originDestinationOptions[0].flightSegments[index2].departureAirportLocationCode.toString(),
                    //                                   style: TextStyle(
                    //                                     fontSize: 20,
                    //                                     fontWeight: FontWeight.bold,
                    //                                   ),
                    //                                   textAlign: TextAlign.center,
                    //                                 ),
                    //                               )
                    //                             ],
                    //                           ),
                    //                           // Row(
                    //                           //   mainAxisAlignment: MainAxisAlignment.end,
                    //                           //   children: [
                    //                           //     Flexible(
                    //                           //       child: Text(
                    //                           //         localAssistant.getFlightSegmentByLocale(context, 'd', _flights[0].originDestinationOptions[0].flightSegments[index]).toString(),
                    //                           //         style: TextStyle(
                    //                           //           fontSize: 14,
                    //                           //           color: Colors.black38,
                    //                           //         ),
                    //                           //         textAlign: TextAlign.end,
                    //                           //       ),
                    //                           //     ),
                    //                           //   ],
                    //                           // ),
                    //                           Row(
                    //                             mainAxisAlignment: MainAxisAlignment.end,
                    //                             children: [
                    //                               Text(
                    //                                 _flights[index].originDestinationOptions[0].flightSegments[index2].departureDateTime.toString().substring(11),
                    //                                 style: TextStyle(
                    //                                   fontSize: 14,
                    //                                   color: Colors.black38,
                    //                                 ),
                    //                                 textAlign: TextAlign.end,
                    //                               ),
                    //                             ],
                    //                           ),
                    //                         ],
                    //                       ),
                    //                     ),
                    //                     Expanded(
                    //                       flex: 33,
                    //                       child: Column(
                    //                         children: <Widget>[
                    //                           Icon(Icons.flight, color: Color(0xff07898B),),
                    //                           Text(
                    //                             _flights[index].originDestinationOptions[0].flightSegments[index2].journeyDuration.toString(),
                    //                             style: TextStyle(
                    //                               fontSize: 14,
                    //                               color: Colors.black38,
                    //                             ),
                    //                           ),
                    //                         ],
                    //                       ),
                    //                     ),
                    //                     Expanded(
                    //                       flex: 33,
                    //                       child: Column(
                    //                         children: <Widget>[
                    //                           Row(
                    //                             children: <Widget>[
                    //                               Padding(
                    //                                 padding: const EdgeInsets.all(4.0),
                    //                                 child: Container(
                    //                                   padding: EdgeInsets.all(2.0),
                    //                                   width: 25,
                    //                                   height: 25,
                    //                                   decoration: BoxDecoration(
                    //                                     color: Color(0xffFFCECF),
                    //                                     borderRadius: BorderRadius.circular(50),
                    //                                     border: Border.all(
                    //                                       width: 3,
                    //                                       color: Colors.redAccent,
                    //                                       style: BorderStyle.solid,
                    //                                     ),
                    //                                   ),
                    //                                 ),
                    //                               ),
                    //                               Padding(
                    //                                 padding: const EdgeInsets.all(4.0),
                    //                                 child: Text(
                    //                                   _flights[index].originDestinationOptions[0].flightSegments[index2].arrivalAirportLocationCode.toString(),
                    //                                   style: TextStyle(
                    //                                     fontSize: 20,
                    //                                     fontWeight: FontWeight.bold,
                    //                                   ),
                    //                                   textAlign: TextAlign.center,
                    //                                 ),
                    //                               )
                    //                             ],
                    //                           ),
                    //                           // Row(
                    //                           //   // mainAxisAlignment: MainAxisAlignment.end,
                    //                           //   children: [
                    //                           //     Flexible(
                    //                           //       child: Text(
                    //                           //         localAssistant.getFlightSegmentByLocale(context, 'a', _flights[0].originDestinationOptions[0].flightSegments[index]).toString(),
                    //                           //         style: TextStyle(
                    //                           //           fontSize: 14,
                    //                           //           color: Colors.black38,
                    //                           //         ),
                    //                           //         textAlign: TextAlign.start,
                    //                           //       ),
                    //                           //     ),
                    //                           //   ],
                    //                           // ),
                    //                           Text(
                    //                             _flights[index].originDestinationOptions[0].flightSegments[index2].arrivalDateTime.toString().substring(11),
                    //                             style: TextStyle(
                    //                               fontSize: 14,
                    //                               color: Colors.black38,
                    //                             ),
                    //                             textAlign: TextAlign.end,
                    //                           ),
                    //                         ],
                    //                       ),
                    //                     ),
                    //                   ],
                    //                 ),
                    //               Container(
                    //                 height: screenHeight * 0.06,
                    //                 width: screenWidth * 0.9,
                    //                 padding: const EdgeInsets.all(4.0),
                    //                 child: Row(
                    //                   mainAxisAlignment: MainAxisAlignment.end,
                    //                   children: [
                    //                     Expanded(
                    //                       flex: 28,
                    //                       child: Text(''),
                    //                     ),
                    //                     Expanded(
                    //                       flex: 44,
                    //                       child: Padding(
                    //                         padding: const EdgeInsets.all(2.0),
                    //                         child: GFButton(
                    //                           onPressed: () {
                    //                             setState(() {
                    //                               shiftFlightSegments = List.of(_flights[index].originDestinationOptions[0].flightSegments);
                    //                               _flights[index].originDestinationOptions[0].flightSegments = List.of(_flights[0].originDestinationOptions[0].flightSegments);
                    //                               _flights[0].originDestinationOptions[0].flightSegments = List.of(shiftFlightSegments);
                    //                               dayIndex = -1;
                    //                             });
                    //                             Navigator.pop(context);
                    //                           },
                    //                           color: Colors.teal,
                    //                           child: Row(
                    //                             children: [
                    //                               Icon(
                    //                                 Icons.add,
                    //                                 size: 14,
                    //                                 color: Colors.white,
                    //                               ),
                    //
                    //                               Padding(
                    //                                 padding: const EdgeInsets.all(4.0),
                    //                                 child: FittedBox(
                    //                                   fit: BoxFit.scaleDown,
                    //                                   child: Text(
                    //                                     (_flights[0].airItineraryPricingInfo.flightTotalFare.totalFare - _flights[index].airItineraryPricingInfo.flightTotalFare.totalFare).toString() + ' \$',
                    //                                     style: TextStyle(
                    //                                       fontSize: 14,
                    //                                       color: Colors.white,
                    //                                     ),
                    //                                   ),
                    //                                 ),
                    //                               )
                    //                             ],
                    //                           ),
                    //                         ),
                    //                       ),
                    //                     ),
                    //                     Expanded(
                    //                       flex: 28,
                    //                       child: Text(''),
                    //                     ),
                    //                   ],
                    //                 ),
                    //               ),
                    //             ],
                    //           ),
                    //         ),
                    //       );
                    //     }),
                  ],
                ),
              ),
            ),
          );
        });
  }

  void changeArriveFlight(context, screenWidth, screenHeight) {
    showDialog(
        context: context,
        builder: (BuildContext bc) {
          return Dialog(
            child: Container(
              width: screenWidth * 0.9,
              // height: screenHeight * 0.7,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: screenWidth * 0.85,
                      color: Color(0xff07898B),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          getTranslated(context, 'change_flight'),
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                    for (int index = 0; index < _flightsBack.length; index++)
                      Container(
                        width: screenWidth * 0.8,
                        child: Card(
                          elevation: 2.0,
                          child: Column(
                            children: <Widget>[
                              for (int index2 = 0;
                                  index2 <
                                      _flightsBack[index]
                                          .originDestinationOptions[0]
                                          .flightSegments
                                          .length;
                                  index2++)
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 33,
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            // mainAxisAlignment: MainAxisAlignment.end,
                                            children: <Widget>[
                                              Align(
                                                alignment: AlignmentDirectional
                                                    .centerStart,
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .only(
                                                          start: screenWidth *
                                                              0.02),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            4.0),
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.all(2.0),
                                                      width: 25,
                                                      height: 25,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Color(0xffFFCECF),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50),
                                                        border: Border.all(
                                                          width: 3,
                                                          color:
                                                              Colors.redAccent,
                                                          style:
                                                              BorderStyle.solid,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Text(
                                                  _flightsBack[index]
                                                      .originDestinationOptions[
                                                          0]
                                                      .flightSegments[index2]
                                                      .departureAirportLocationCode
                                                      .toString(),
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              )
                                            ],
                                          ),
                                          // Row(
                                          //   mainAxisAlignment: MainAxisAlignment.end,
                                          //   children: [
                                          //     Flexible(
                                          //       child: Text(
                                          //         localAssistant.getFlightSegmentByLocale(context, 'd', _flights[0].originDestinationOptions[0].flightSegments[index]).toString(),
                                          //         style: TextStyle(
                                          //           fontSize: 14,
                                          //           color: Colors.black38,
                                          //         ),
                                          //         textAlign: TextAlign.end,
                                          //       ),
                                          //     ),
                                          //   ],
                                          // ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                _flightsBack[index]
                                                    .originDestinationOptions[0]
                                                    .flightSegments[index2]
                                                    .departureDateTime
                                                    .toString()
                                                    .substring(11),
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.black38,
                                                ),
                                                textAlign: TextAlign.end,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 33,
                                      child: Column(
                                        children: <Widget>[
                                          Icon(
                                            Icons.flight,
                                            color: Color(0xff07898B),
                                          ),
                                          Text(
                                            _flightsBack[index]
                                                .originDestinationOptions[0]
                                                .flightSegments[index2]
                                                .journeyDuration
                                                .toString(),
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black38,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 33,
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Container(
                                                  padding: EdgeInsets.all(2.0),
                                                  width: 25,
                                                  height: 25,
                                                  decoration: BoxDecoration(
                                                    color: Color(0xffFFCECF),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                    border: Border.all(
                                                      width: 3,
                                                      color: Colors.redAccent,
                                                      style: BorderStyle.solid,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Text(
                                                  _flightsBack[index]
                                                      .originDestinationOptions[
                                                          0]
                                                      .flightSegments[index2]
                                                      .arrivalAirportLocationCode
                                                      .toString(),
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              )
                                            ],
                                          ),
                                          // Row(
                                          //   // mainAxisAlignment: MainAxisAlignment.end,
                                          //   children: [
                                          //     Flexible(
                                          //       child: Text(
                                          //         localAssistant.getFlightSegmentByLocale(context, 'a', _flights[0].originDestinationOptions[0].flightSegments[index]).toString(),
                                          //         style: TextStyle(
                                          //           fontSize: 14,
                                          //           color: Colors.black38,
                                          //         ),
                                          //         textAlign: TextAlign.start,
                                          //       ),
                                          //     ),
                                          //   ],
                                          // ),
                                          Text(
                                            _flightsBack[index]
                                                .originDestinationOptions[0]
                                                .flightSegments[index2]
                                                .arrivalDateTime
                                                .toString()
                                                .substring(11),
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black38,
                                            ),
                                            textAlign: TextAlign.end,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              Container(
                                height: screenHeight * 0.06,
                                width: screenWidth * 0.8,
                                padding: const EdgeInsets.all(4.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Expanded(
                                      flex: 28,
                                      child: Text(''),
                                    ),
                                    Expanded(
                                      flex: 44,
                                      child: Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: GFButton(
                                          onPressed: () {
                                            setState(() {
                                              shiftFlightSegments = List.of(
                                                  _flightsBack[index]
                                                      .originDestinationOptions[
                                                          0]
                                                      .flightSegments);
                                              _flightsBack[index]
                                                      .originDestinationOptions[0]
                                                      .flightSegments =
                                                  List.of(_flightsBack[0]
                                                      .originDestinationOptions[
                                                          0]
                                                      .flightSegments);
                                              _flightsBack[0]
                                                      .originDestinationOptions[0]
                                                      .flightSegments =
                                                  List.of(shiftFlightSegments);
                                              calculateOfferPrice();
                                              dayIndex = -1;
                                            });
                                            Navigator.pop(context);
                                          },
                                          color: Colors.teal,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.add,
                                                size: 14,
                                                color: Colors.white,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: FittedBox(
                                                  fit: BoxFit.scaleDown,
                                                  child: Text(
                                                    (_flightsBack[index]
                                                                    .airItineraryPricingInfo
                                                                    .flightTotalFare
                                                                    .totalFare -
                                                                _flightsBack[0]
                                                                    .airItineraryPricingInfo
                                                                    .flightTotalFare
                                                                    .totalFare)
                                                            .toStringAsFixed(
                                                                2) +
                                                        ' \$',
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 28,
                                      child: Text(''),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    // ListView.builder(
                    //     itemCount: _flights.length,
                    //     shrinkWrap: true,
                    //     itemBuilder: (context , index){
                    //       return Container(
                    //         width: screenWidth * 0.8,
                    //         child: Card(
                    //           elevation: 2.0,
                    //           child: Column(
                    //             children: <Widget>[
                    //               for(int index2 = 0 ; index2 < _flights[index].originDestinationOptions[0].flightSegments.length ; index2++)
                    //                 Row(
                    //                   children: [
                    //                     Expanded(
                    //                       flex: 33,
                    //                       child: Column(
                    //                         children: <Widget>[
                    //                           Row(
                    //                             // mainAxisAlignment: MainAxisAlignment.end,
                    //                             children: <Widget>[
                    //                               Align(
                    //                                 alignment: AlignmentDirectional.centerStart,
                    //                                 child: Padding(
                    //                                   padding: EdgeInsetsDirectional.only(start: screenWidth * 0.07),
                    //                                   child: Padding(
                    //                                     padding: const EdgeInsets.all(4.0),
                    //                                     child: Container(
                    //                                       padding: EdgeInsets.all(2.0),
                    //                                       width: 25,
                    //                                       height: 25,
                    //                                       decoration: BoxDecoration(
                    //                                         color: Color(0xffFFCECF),
                    //                                         borderRadius: BorderRadius.circular(50),
                    //                                         border: Border.all(
                    //                                           width: 3,
                    //                                           color: Colors.redAccent,
                    //                                           style: BorderStyle.solid,
                    //                                         ),
                    //                                       ),
                    //                                     ),
                    //                                   ),
                    //                                 ),
                    //                               ),
                    //                               Padding(
                    //                                 padding: const EdgeInsets.all(4.0),
                    //                                 child: Text(
                    //                                   _flights[index].originDestinationOptions[0].flightSegments[index2].departureAirportLocationCode.toString(),
                    //                                   style: TextStyle(
                    //                                     fontSize: 20,
                    //                                     fontWeight: FontWeight.bold,
                    //                                   ),
                    //                                   textAlign: TextAlign.center,
                    //                                 ),
                    //                               )
                    //                             ],
                    //                           ),
                    //                           // Row(
                    //                           //   mainAxisAlignment: MainAxisAlignment.end,
                    //                           //   children: [
                    //                           //     Flexible(
                    //                           //       child: Text(
                    //                           //         localAssistant.getFlightSegmentByLocale(context, 'd', _flights[0].originDestinationOptions[0].flightSegments[index]).toString(),
                    //                           //         style: TextStyle(
                    //                           //           fontSize: 14,
                    //                           //           color: Colors.black38,
                    //                           //         ),
                    //                           //         textAlign: TextAlign.end,
                    //                           //       ),
                    //                           //     ),
                    //                           //   ],
                    //                           // ),
                    //                           Row(
                    //                             mainAxisAlignment: MainAxisAlignment.end,
                    //                             children: [
                    //                               Text(
                    //                                 _flights[index].originDestinationOptions[0].flightSegments[index2].departureDateTime.toString().substring(11),
                    //                                 style: TextStyle(
                    //                                   fontSize: 14,
                    //                                   color: Colors.black38,
                    //                                 ),
                    //                                 textAlign: TextAlign.end,
                    //                               ),
                    //                             ],
                    //                           ),
                    //                         ],
                    //                       ),
                    //                     ),
                    //                     Expanded(
                    //                       flex: 33,
                    //                       child: Column(
                    //                         children: <Widget>[
                    //                           Icon(Icons.flight, color: Color(0xff07898B),),
                    //                           Text(
                    //                             _flights[index].originDestinationOptions[0].flightSegments[index2].journeyDuration.toString(),
                    //                             style: TextStyle(
                    //                               fontSize: 14,
                    //                               color: Colors.black38,
                    //                             ),
                    //                           ),
                    //                         ],
                    //                       ),
                    //                     ),
                    //                     Expanded(
                    //                       flex: 33,
                    //                       child: Column(
                    //                         children: <Widget>[
                    //                           Row(
                    //                             children: <Widget>[
                    //                               Padding(
                    //                                 padding: const EdgeInsets.all(4.0),
                    //                                 child: Container(
                    //                                   padding: EdgeInsets.all(2.0),
                    //                                   width: 25,
                    //                                   height: 25,
                    //                                   decoration: BoxDecoration(
                    //                                     color: Color(0xffFFCECF),
                    //                                     borderRadius: BorderRadius.circular(50),
                    //                                     border: Border.all(
                    //                                       width: 3,
                    //                                       color: Colors.redAccent,
                    //                                       style: BorderStyle.solid,
                    //                                     ),
                    //                                   ),
                    //                                 ),
                    //                               ),
                    //                               Padding(
                    //                                 padding: const EdgeInsets.all(4.0),
                    //                                 child: Text(
                    //                                   _flights[index].originDestinationOptions[0].flightSegments[index2].arrivalAirportLocationCode.toString(),
                    //                                   style: TextStyle(
                    //                                     fontSize: 20,
                    //                                     fontWeight: FontWeight.bold,
                    //                                   ),
                    //                                   textAlign: TextAlign.center,
                    //                                 ),
                    //                               )
                    //                             ],
                    //                           ),
                    //                           // Row(
                    //                           //   // mainAxisAlignment: MainAxisAlignment.end,
                    //                           //   children: [
                    //                           //     Flexible(
                    //                           //       child: Text(
                    //                           //         localAssistant.getFlightSegmentByLocale(context, 'a', _flights[0].originDestinationOptions[0].flightSegments[index]).toString(),
                    //                           //         style: TextStyle(
                    //                           //           fontSize: 14,
                    //                           //           color: Colors.black38,
                    //                           //         ),
                    //                           //         textAlign: TextAlign.start,
                    //                           //       ),
                    //                           //     ),
                    //                           //   ],
                    //                           // ),
                    //                           Text(
                    //                             _flights[index].originDestinationOptions[0].flightSegments[index2].arrivalDateTime.toString().substring(11),
                    //                             style: TextStyle(
                    //                               fontSize: 14,
                    //                               color: Colors.black38,
                    //                             ),
                    //                             textAlign: TextAlign.end,
                    //                           ),
                    //                         ],
                    //                       ),
                    //                     ),
                    //                   ],
                    //                 ),
                    //               Container(
                    //                 height: screenHeight * 0.06,
                    //                 width: screenWidth * 0.9,
                    //                 padding: const EdgeInsets.all(4.0),
                    //                 child: Row(
                    //                   mainAxisAlignment: MainAxisAlignment.end,
                    //                   children: [
                    //                     Expanded(
                    //                       flex: 28,
                    //                       child: Text(''),
                    //                     ),
                    //                     Expanded(
                    //                       flex: 44,
                    //                       child: Padding(
                    //                         padding: const EdgeInsets.all(2.0),
                    //                         child: GFButton(
                    //                           onPressed: () {
                    //                             setState(() {
                    //                               shiftFlightSegments = List.of(_flights[index].originDestinationOptions[0].flightSegments);
                    //                               _flights[index].originDestinationOptions[0].flightSegments = List.of(_flights[0].originDestinationOptions[0].flightSegments);
                    //                               _flights[0].originDestinationOptions[0].flightSegments = List.of(shiftFlightSegments);
                    //                               dayIndex = -1;
                    //                             });
                    //                             Navigator.pop(context);
                    //                           },
                    //                           color: Colors.teal,
                    //                           child: Row(
                    //                             children: [
                    //                               Icon(
                    //                                 Icons.add,
                    //                                 size: 14,
                    //                                 color: Colors.white,
                    //                               ),
                    //
                    //                               Padding(
                    //                                 padding: const EdgeInsets.all(4.0),
                    //                                 child: FittedBox(
                    //                                   fit: BoxFit.scaleDown,
                    //                                   child: Text(
                    //                                     (_flights[0].airItineraryPricingInfo.flightTotalFare.totalFare - _flights[index].airItineraryPricingInfo.flightTotalFare.totalFare).toString() + ' \$',
                    //                                     style: TextStyle(
                    //                                       fontSize: 14,
                    //                                       color: Colors.white,
                    //                                     ),
                    //                                   ),
                    //                                 ),
                    //                               )
                    //                             ],
                    //                           ),
                    //                         ),
                    //                       ),
                    //                     ),
                    //                     Expanded(
                    //                       flex: 28,
                    //                       child: Text(''),
                    //                     ),
                    //                   ],
                    //                 ),
                    //               ),
                    //             ],
                    //           ),
                    //         ),
                    //       );
                    //     }),
                  ],
                ),
              ),
            ),
          );
        });
  }

  void changeTrip(context, screenWidth, screenHeight, cityId, tripId, adults,
      children, babies, dayPointer, tripPointer) {
    showDialog(
        context: context,
        builder: (BuildContext bc) {
          // betaApiAssistant.getExtraTrips(cityId, tripId, adults, children, babies).then((value) {
          //   setState(() {
          //     _availableCityTrips = List.of(value);
          //     _isExtraTripsLoading = false;
          //   });
          // });
          return Dialog(
            child: StatefulBuilder(builder: (context, setState) {
              return Container(
                width: screenWidth * 0.9,
                // height: screenHeight * 0.7,
                child: FutureBuilder(
                  future: betaApiAssistant.getExtraTrips(
                      cityId, tripId, adults, children, babies),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.data == null) {
                      return Center(
                        child: GFLoader(
                          type: GFLoaderType.circle,
                          loaderColorOne: Color(0xff07898B),
                          loaderColorTwo: Color(0xff07898B),
                          loaderColorThree: Color(0xff07898B),
                        ),
                      );
                    } else
                      return Container(
                        height: screenHeight * 0.8,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(
                                width: screenWidth * 0.9,
                                color: Color(0xff07898B),
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    getTranslated(
                                        context, 'fo_change_trip_title'),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.white),
                                  ),
                                ),
                              ),
                              for (int i = 0; i < snapshot.data.length; i++)
                                Card(
                                  elevation: 2,
                                  child: ListTile(
                                    contentPadding: const EdgeInsets.all(2),
                                    onTap: () {},
                                    subtitle: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: ClipPath(
                                            clipper: ShapeBorderClipper(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          4.0)),
                                            ),
                                            child: Padding(
                                                padding:
                                                    const EdgeInsets.all(0),
                                                child: Image.network(
                                                  'https://ipackagetours.com/storage/app/' +
                                                      snapshot.data[i].image
                                                          .toString(),
                                                  fit: BoxFit.fill,
                                                  height: screenHeight * 0.2,
                                                  width: screenWidth * 0.85,
                                                )),
                                          ),
                                        ),
                                        Container(
                                          width: screenWidth * 0.85,
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
                                                            snapshot.data[i],
                                                            'name')
                                                        .toString(),
                                                    textAlign: TextAlign.center,
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
                                        Row(
                                          children: <Widget>[
                                            Flexible(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .only(start: 0.0),
                                                child: Text(
                                                  localAssistant
                                                      .getTripByLocale(
                                                          context,
                                                          snapshot.data[i],
                                                          'trip')
                                                      .toString(),
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                      // fontWeight:
                                                      // FontWeight.bold,
                                                      fontSize: 14,
                                                      color: Colors.black),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          height: screenHeight * 0.07,
                                          width: screenWidth * 0.85,
                                          padding: const EdgeInsets.all(4.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Expanded(
                                                flex: 20,
                                                child: Text(''),
                                              ),
                                              Expanded(
                                                flex: 60,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(2.0),
                                                  child: GFButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        shiftTrip = offer
                                                            .days[dayPointer]
                                                            .trips[tripPointer];
                                                        offer.days[dayPointer]
                                                                    .trips[
                                                                tripPointer] =
                                                            snapshot.data[i];
                                                        calculateOfferPrice();
                                                        dayIndex = -1;
                                                      });
                                                      Navigator.pop(context);
                                                    },
                                                    color: Colors.teal,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(
                                                          Icons.add,
                                                          size: 14,
                                                          color: Colors.white,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(4.0),
                                                          child: FittedBox(
                                                            fit: BoxFit
                                                                .scaleDown,
                                                            child: Text(
                                                              snapshot.data[i]
                                                                  .pricePlus
                                                                  .toString(),
                                                              style: TextStyle(
                                                                fontSize: 14,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 20,
                                                child: Text(''),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              // Container(
                              //   width: screenWidth * 0.85,
                              //   child: InkWell(
                              //     borderRadius: BorderRadius.circular(4.0),
                              //     child: Card(
                              //       child: Row(
                              //         children: <Widget>[
                              //           Column(
                              //             children: [
                              //               ClipPath(
                              //                 clipper: ShapeBorderClipper(
                              //                   shape: RoundedRectangleBorder(
                              //                       borderRadius:
                              //                       BorderRadius.circular(4.0)),
                              //                 ),
                              //                 child: Padding(
                              //                     padding: const EdgeInsets.all(0),
                              //                     child: Image.network(
                              //                       'https://ipackagetours.com/storage/app/' +
                              //                           snapshot.data[i]
                              //                               .image
                              //                               .toString(),
                              //                       fit: BoxFit.fill,
                              //                       height: screenHeight * 0.16,
                              //                       width: screenWidth * 0.25,
                              //                     )),
                              //               ),
                              //             ],
                              //           ),
                              //           Column(
                              //             mainAxisAlignment:
                              //             MainAxisAlignment.center,
                              //             children: <Widget>[
                              //               Container(
                              //                 width: screenWidth * 0.5,
                              //                 padding: const EdgeInsets.all(0),
                              //                 child: Row(
                              //                   children: <Widget>[
                              //                     Flexible(
                              //                       child: Padding(
                              //                         padding:
                              //                         const EdgeInsetsDirectional
                              //                             .only(start: 4.0),
                              //                         child: Text(
                              //                           localAssistant
                              //                               .getTripByLocale(
                              //                               context,
                              //                               snapshot.data[i],
                              //                               'name')
                              //                               .toString(),
                              //                           textAlign:
                              //                           TextAlign.start,
                              //                           style: TextStyle(
                              //                               fontWeight:
                              //                               FontWeight.bold,
                              //                               fontSize: 15,
                              //                               color: Colors.black),
                              //                         ),
                              //                       ),
                              //                     ),
                              //                   ],
                              //                 ),
                              //               ),
                              //               Container(
                              //                 width: screenWidth * 0.5,
                              //                 padding: const EdgeInsets.all(0),
                              //                 child: Row(
                              //                   children: <Widget>[
                              //                     Flexible(
                              //                       child: Padding(
                              //                         padding:
                              //                         const EdgeInsetsDirectional
                              //                             .only(start: 4.0),
                              //                         child: Text(
                              //                           localAssistant
                              //                               .getTripByLocale(
                              //                               context,
                              //                               snapshot.data[i],
                              //                               'trip')
                              //                               .toString(),
                              //                           textAlign:
                              //                           TextAlign.start,
                              //                           style: TextStyle(
                              //                               // fontWeight:
                              //                               // FontWeight.bold,
                              //                               fontSize: 14,
                              //                               color: Colors.black),
                              //                         ),
                              //                       ),
                              //                     ),
                              //                   ],
                              //                 ),
                              //               ),
                              //
                              //               Container(
                              //                 height: screenHeight * 0.06,
                              //                 width: screenWidth * 0.5,
                              //                 padding: const EdgeInsets.all(4.0),
                              //                 child: Row(
                              //                   mainAxisAlignment: MainAxisAlignment.end,
                              //                   children: [
                              //                     Expanded(
                              //                       flex: 20,
                              //                       child: Text(''),
                              //                     ),
                              //                     Expanded(
                              //                       flex: 60,
                              //                       child: Padding(
                              //                         padding: const EdgeInsets.all(2.0),
                              //                         child: GFButton(
                              //                           onPressed: () {
                              //                             setState(() {
                              //
                              //                             });
                              //                             Navigator.pop(context);
                              //                           },
                              //                           color: Colors.teal,
                              //                           child: Row(
                              //                             mainAxisAlignment: MainAxisAlignment.center,
                              //                             children: [
                              //                               Icon(
                              //                                 Icons.add,
                              //                                 size: 14,
                              //                                 color: Colors.white,
                              //                               ),
                              //
                              //                               Padding(
                              //                                 padding: const EdgeInsets.all(4.0),
                              //                                 child: FittedBox(
                              //                                   fit: BoxFit.scaleDown,
                              //                                   child: Text(
                              //                                     snapshot.data[i].pricePlus.toString(),
                              //                                     style: TextStyle(
                              //                                       fontSize: 14,
                              //                                       color: Colors.white,
                              //                                     ),
                              //                                   ),
                              //                                 ),
                              //                               )
                              //                             ],
                              //                           ),
                              //                         ),
                              //                       ),
                              //                     ),
                              //                     Expanded(
                              //                       flex: 20,
                              //                       child: Text(''),
                              //                     ),
                              //                   ],
                              //                 ),
                              //               ),
                              //             ],
                              //           ),
                              //         ],
                              //       ),
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      );
                  },
                ),
              );
            }),
          );
        });
  }


  void changeHotel(context, screenWidth, screenHeight, cityId, checkIn,
      checkout, adults, children, dayPointer) {

    print('city id: ' + cityId.toString());

    showDialog(
        context: context,
        builder: (BuildContext bc) {
          return Dialog(
            child: StatefulBuilder(builder: (context, setState) {
              return Container(
                width: screenWidth * 0.9,
                // height: screenHeight * 0.7,
                child: FutureBuilder(
                  future: betaApiAssistant.getCityHotels(
                      checkIn, checkout, cityId, adults, children),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.data == null) {
                      return Center(
                        child: GFLoader(
                          type: GFLoaderType.circle,
                          loaderColorOne: Color(0xff07898B),
                          loaderColorTwo: Color(0xff07898B),
                          loaderColorThree: Color(0xff07898B),
                        ),
                      );
                    } else
                      return Container(
                        height: screenHeight * 0.8,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(
                                width: screenWidth * 0.9,
                                color: Color(0xff07898B),
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    getTranslated(
                                        context, 'fo_change_hotel_title'),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.white),
                                  ),
                                ),
                              ),
                              for (int i = 0; i < snapshot.data.length; i++)
                                Card(
                                  elevation: 2,
                                  child: ListTile(
                                    contentPadding: const EdgeInsets.all(2),
                                    onTap: () {},
                                    subtitle: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: ClipPath(
                                            clipper: ShapeBorderClipper(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          4.0)),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(0),
                                              child: snapshot.data[i].images
                                                          .toString() !=
                                                      null
                                                  ? Image.network(
                                                      snapshot
                                                              .data[i].images
                                                              .toString(),
                                                      fit: BoxFit.fill,
                                                      height:
                                                          screenHeight * 0.2,
                                                      width: screenWidth * 0.85,
                                                    )
                                                  : Image.asset(
                                                      'assets/images/hotel.jpg',
                                                      fit: BoxFit.fill,
                                                      height:
                                                          screenHeight * 0.2,
                                                      width: screenWidth * 0.85,
                                                    ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: screenWidth * 0.85,
                                          child: Row(
                                            children: <Widget>[
                                              Flexible(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                          .only(start: 4.0),
                                                  child: Text(
                                                    localAssistant
                                                        .getHotelByLocale(
                                                            context,
                                                            snapshot.data[i],
                                                            'name')
                                                        .toString(),
                                                    textAlign: TextAlign.center,
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
                                        // Row(
                                        //   children: <Widget>[
                                        //     Flexible(
                                        //       child: Padding(
                                        //         padding:
                                        //         const EdgeInsetsDirectional
                                        //             .only(start: 0.0),
                                        //         child: Text(
                                        //           localAssistant
                                        //               .getTripByLocale(
                                        //               context,
                                        //               snapshot.data[i],
                                        //               'trip')
                                        //               .toString(),
                                        //           textAlign:
                                        //           TextAlign.start,
                                        //           style: TextStyle(
                                        //             // fontWeight:
                                        //             // FontWeight.bold,
                                        //               fontSize: 14,
                                        //               color: Colors.black),
                                        //         ),
                                        //       ),
                                        //     ),
                                        //   ],
                                        // ),
                                        Container(
                                          height: screenHeight * 0.07,
                                          width: screenWidth * 0.85,
                                          padding: const EdgeInsets.all(4.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Expanded(
                                                flex: 20,
                                                child: Text(''),
                                              ),
                                              Expanded(
                                                flex: 60,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(2.0),
                                                  child: GFButton(
                                                    onPressed: () {
                                                      setState(() {

                                                        print('Rating: ' + offer
                                                            .days[dayPointer]
                                                            .hotels[0]
                                                            .rating
                                                            .toString());

                                                        shiftHotel = offer
                                                            .days[dayPointer]
                                                            .hotels[0];
                                                        offer.days[dayPointer]
                                                                .hotels[0] =
                                                            snapshot.data[i];
                                                        calculateOfferPrice();
                                                        dayIndex = -1;
                                                      });
                                                      Navigator.pop(context);
                                                    },
                                                    color: Colors.teal,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(
                                                          Icons.add,
                                                          size: 14,
                                                          color: Colors.white,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(4.0),
                                                          child: FittedBox(
                                                            fit: BoxFit
                                                                .scaleDown,
                                                            child: Text(
                                                              snapshot.data[i].netRate.toString(),
                                                              style: TextStyle(
                                                                fontSize: 14,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 20,
                                                child: Text(''),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              // Container(
                              //   width: screenWidth * 0.85,
                              //   child: InkWell(
                              //     borderRadius: BorderRadius.circular(4.0),
                              //     child: Card(
                              //       child: Row(
                              //         children: <Widget>[
                              //           Column(
                              //             children: [
                              //               ClipPath(
                              //                 clipper: ShapeBorderClipper(
                              //                   shape: RoundedRectangleBorder(
                              //                       borderRadius:
                              //                       BorderRadius.circular(4.0)),
                              //                 ),
                              //                 child: Padding(
                              //                     padding: const EdgeInsets.all(0),
                              //                     child: Image.network(
                              //                       'https://ipackagetours.com/storage/app/' +
                              //                           snapshot.data[i]
                              //                               .image
                              //                               .toString(),
                              //                       fit: BoxFit.fill,
                              //                       height: screenHeight * 0.16,
                              //                       width: screenWidth * 0.25,
                              //                     )),
                              //               ),
                              //             ],
                              //           ),
                              //           Column(
                              //             mainAxisAlignment:
                              //             MainAxisAlignment.center,
                              //             children: <Widget>[
                              //               Container(
                              //                 width: screenWidth * 0.5,
                              //                 padding: const EdgeInsets.all(0),
                              //                 child: Row(
                              //                   children: <Widget>[
                              //                     Flexible(
                              //                       child: Padding(
                              //                         padding:
                              //                         const EdgeInsetsDirectional
                              //                             .only(start: 4.0),
                              //                         child: Text(
                              //                           localAssistant
                              //                               .getTripByLocale(
                              //                               context,
                              //                               snapshot.data[i],
                              //                               'name')
                              //                               .toString(),
                              //                           textAlign:
                              //                           TextAlign.start,
                              //                           style: TextStyle(
                              //                               fontWeight:
                              //                               FontWeight.bold,
                              //                               fontSize: 15,
                              //                               color: Colors.black),
                              //                         ),
                              //                       ),
                              //                     ),
                              //                   ],
                              //                 ),
                              //               ),
                              //               Container(
                              //                 width: screenWidth * 0.5,
                              //                 padding: const EdgeInsets.all(0),
                              //                 child: Row(
                              //                   children: <Widget>[
                              //                     Flexible(
                              //                       child: Padding(
                              //                         padding:
                              //                         const EdgeInsetsDirectional
                              //                             .only(start: 4.0),
                              //                         child: Text(
                              //                           localAssistant
                              //                               .getTripByLocale(
                              //                               context,
                              //                               snapshot.data[i],
                              //                               'trip')
                              //                               .toString(),
                              //                           textAlign:
                              //                           TextAlign.start,
                              //                           style: TextStyle(
                              //                               // fontWeight:
                              //                               // FontWeight.bold,
                              //                               fontSize: 14,
                              //                               color: Colors.black),
                              //                         ),
                              //                       ),
                              //                     ),
                              //                   ],
                              //                 ),
                              //               ),
                              //
                              //               Container(
                              //                 height: screenHeight * 0.06,
                              //                 width: screenWidth * 0.5,
                              //                 padding: const EdgeInsets.all(4.0),
                              //                 child: Row(
                              //                   mainAxisAlignment: MainAxisAlignment.end,
                              //                   children: [
                              //                     Expanded(
                              //                       flex: 20,
                              //                       child: Text(''),
                              //                     ),
                              //                     Expanded(
                              //                       flex: 60,
                              //                       child: Padding(
                              //                         padding: const EdgeInsets.all(2.0),
                              //                         child: GFButton(
                              //                           onPressed: () {
                              //                             setState(() {
                              //
                              //                             });
                              //                             Navigator.pop(context);
                              //                           },
                              //                           color: Colors.teal,
                              //                           child: Row(
                              //                             mainAxisAlignment: MainAxisAlignment.center,
                              //                             children: [
                              //                               Icon(
                              //                                 Icons.add,
                              //                                 size: 14,
                              //                                 color: Colors.white,
                              //                               ),
                              //
                              //                               Padding(
                              //                                 padding: const EdgeInsets.all(4.0),
                              //                                 child: FittedBox(
                              //                                   fit: BoxFit.scaleDown,
                              //                                   child: Text(
                              //                                     snapshot.data[i].pricePlus.toString(),
                              //                                     style: TextStyle(
                              //                                       fontSize: 14,
                              //                                       color: Colors.white,
                              //                                     ),
                              //                                   ),
                              //                                 ),
                              //                               )
                              //                             ],
                              //                           ),
                              //                         ),
                              //                       ),
                              //                     ),
                              //                     Expanded(
                              //                       flex: 20,
                              //                       child: Text(''),
                              //                     ),
                              //                   ],
                              //                 ),
                              //               ),
                              //             ],
                              //           ),
                              //         ],
                              //       ),
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      );
                  },
                ),
              );
            }),
          );
        });
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

                    // Flight label
                    if (index == 0)
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
                                          Icons.airplanemode_active,
                                          color: Color(0xff07898B),
                                          size: 15,
                                        ),
                                      ),
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
                                              context, 'do_flights_tab'),
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

                    if (index == 0)
                      Container(
                          width: screenWidth * 0.9,
                          child: _isFlightsLoading
                              ? Center(
                                  child: GFLoader(
                                    type: GFLoaderType.circle,
                                    loaderColorOne: Color(0xff07898B),
                                    loaderColorTwo: Color(0xff07898B),
                                    loaderColorThree: Color(0xff07898B),
                                  ),
                                )
                              : Container(
                                  child: _flights.length == 0
                                      ? Container(
                                          width: screenWidth * 0.9,
                                          child: Card(
                                            color: Color(0xffCCE5FF),
                                            child: Row(
                                              children: [
                                                Flexible(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      _originCode == ' ' ?
                                                       getTranslated(context,
                                                          'fo_no_flight')
                                                          :
                                                          _isFlight == false ?
                                                          getTranslated(context,
                                                              'fo_no_flight')
                                                              :
                                                      getTranslated(context,
                                                          'fo_no_flight_2'),
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        color:
                                                            Color(0xff0040A2),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      : Visibility(
                                          visible: _flights[0].visibility,
                                          child: Container(
                                            width: screenWidth * 0.9,
                                            child: Card(
                                              elevation: 2.0,
                                              child: Column(
                                                children: <Widget>[
                                                  for (int index = 0;
                                                      index <
                                                          _flights[0]
                                                              .originDestinationOptions[
                                                                  0]
                                                              .flightSegments
                                                              .length;
                                                      index++)
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          flex: 33,
                                                          child: Column(
                                                            children: <Widget>[
                                                              Row(
                                                                // mainAxisAlignment: MainAxisAlignment.end,
                                                                children: <
                                                                    Widget>[
                                                                  Align(
                                                                    alignment:
                                                                        AlignmentDirectional
                                                                            .centerStart,
                                                                    child:
                                                                        Padding(
                                                                      padding: EdgeInsetsDirectional.only(
                                                                          start:
                                                                              screenWidth * 0.07),
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(4.0),
                                                                        child:
                                                                            Container(
                                                                          padding:
                                                                              EdgeInsets.all(2.0),
                                                                          width:
                                                                              25,
                                                                          height:
                                                                              25,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                Color(0xffFFCECF),
                                                                            borderRadius:
                                                                                BorderRadius.circular(50),
                                                                            border:
                                                                                Border.all(
                                                                              width: 3,
                                                                              color: Colors.redAccent,
                                                                              style: BorderStyle.solid,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            4.0),
                                                                    child: Text(
                                                                      _flights[
                                                                              0]
                                                                          .originDestinationOptions[
                                                                              0]
                                                                          .flightSegments[
                                                                              index]
                                                                          .departureAirportLocationCode
                                                                          .toString(),
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            20,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                      ),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                              // Row(
                                                              //   mainAxisAlignment: MainAxisAlignment.end,
                                                              //   children: [
                                                              //     Flexible(
                                                              //       child: Text(
                                                              //         localAssistant.getFlightSegmentByLocale(context, 'd', _flights[0].originDestinationOptions[0].flightSegments[index]).toString(),
                                                              //         style: TextStyle(
                                                              //           fontSize: 14,
                                                              //           color: Colors.black38,
                                                              //         ),
                                                              //         textAlign: TextAlign.end,
                                                              //       ),
                                                              //     ),
                                                              //   ],
                                                              // ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .end,
                                                                children: [
                                                                  Text(
                                                                    _flights[0]
                                                                        .originDestinationOptions[
                                                                            0]
                                                                        .flightSegments[
                                                                            index]
                                                                        .departureDateTime
                                                                        .toString()
                                                                        .substring(
                                                                            11),
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          14,
                                                                      color: Colors
                                                                          .black38,
                                                                    ),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .end,
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 33,
                                                          child: Column(
                                                            children: <Widget>[
                                                              Icon(
                                                                Icons.flight,
                                                                color: Color(
                                                                    0xff07898B),
                                                              ),
                                                              Text(
                                                                _flights[0]
                                                                    .originDestinationOptions[
                                                                        0]
                                                                    .flightSegments[
                                                                        index]
                                                                    .journeyDuration
                                                                    .toString(),
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .black38,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 33,
                                                          child: Column(
                                                            children: <Widget>[
                                                              Row(
                                                                children: <
                                                                    Widget>[
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            4.0),
                                                                    child:
                                                                        Container(
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              2.0),
                                                                      width: 25,
                                                                      height:
                                                                          25,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: Color(
                                                                            0xffFFCECF),
                                                                        borderRadius:
                                                                            BorderRadius.circular(50),
                                                                        border:
                                                                            Border.all(
                                                                          width:
                                                                              3,
                                                                          color:
                                                                              Colors.redAccent,
                                                                          style:
                                                                              BorderStyle.solid,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            4.0),
                                                                    child: Text(
                                                                      _flights[
                                                                              0]
                                                                          .originDestinationOptions[
                                                                              0]
                                                                          .flightSegments[
                                                                              index]
                                                                          .arrivalAirportLocationCode
                                                                          .toString(),
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            20,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                      ),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                              // Row(
                                                              //   // mainAxisAlignment: MainAxisAlignment.end,
                                                              //   children: [
                                                              //     Flexible(
                                                              //       child: Text(
                                                              //         localAssistant.getFlightSegmentByLocale(context, 'a', _flights[0].originDestinationOptions[0].flightSegments[index]).toString(),
                                                              //         style: TextStyle(
                                                              //           fontSize: 14,
                                                              //           color: Colors.black38,
                                                              //         ),
                                                              //         textAlign: TextAlign.start,
                                                              //       ),
                                                              //     ),
                                                              //   ],
                                                              // ),
                                                              Text(
                                                                _flights[0]
                                                                    .originDestinationOptions[
                                                                        0]
                                                                    .flightSegments[
                                                                        index]
                                                                    .arrivalDateTime
                                                                    .toString()
                                                                    .substring(
                                                                        11),
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .black38,
                                                                ),
                                                                textAlign:
                                                                    TextAlign
                                                                        .end,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  Container(
                                                    height: screenHeight * 0.06,
                                                    width: screenWidth * 0.9,
                                                    padding:
                                                        const EdgeInsets.all(
                                                            4.0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        Expanded(
                                                          flex: 28,
                                                          child: Text(''),
                                                        ),
                                                        Expanded(
                                                          flex: 22,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(2.0),
                                                            child: GFButton(
                                                              onPressed: () {
                                                                changeDepartureFlight(
                                                                    context,
                                                                    screenWidth,
                                                                    screenHeight);
                                                              },
                                                              color:
                                                                  Colors.teal,
                                                              child: Icon(
                                                                Icons.edit,
                                                                size: 14,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 22,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(2.0),
                                                            child: GFButton(
                                                              color: Colors
                                                                  .redAccent,
                                                              onPressed: () {
                                                                print(index);

                                                                showDialog(
                                                                    context:
                                                                        context,
                                                                    builder: (_) =>
                                                                        AssetGiffyDialog(
                                                                          onlyOkButton:
                                                                              true,
                                                                          buttonCancelText: Text(
                                                                              getTranslated(context, 'login_alert_d_cancel'),
                                                                              style: TextStyle(fontSize: 16)),
                                                                          buttonOkText: Text(
                                                                              getTranslated(context, 'edit_book_delete'),
                                                                              style: TextStyle(fontSize: 16, color: Colors.white)),
                                                                          buttonOkColor:
                                                                              Colors.redAccent,
                                                                          image: Image.asset(
                                                                              'assets/images/alert.png',
                                                                              fit: BoxFit.cover),
                                                                          title:
                                                                              Text(
                                                                            getTranslated(context,
                                                                                'home_alert_login_title'),
                                                                            style:
                                                                                TextStyle(fontSize: 18.0, color: Colors.teal),
                                                                          ),
                                                                          description:
                                                                              Text(
                                                                            getTranslated(context,
                                                                                'fo_flight_remove_note'),
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style:
                                                                                TextStyle(fontSize: 16),
                                                                          ),
                                                                          onOkButtonPressed:
                                                                              () {
                                                                            setState(() {
                                                                              _flights[0].visibility = !_flights[0].visibility;
                                                                              calculateOfferPrice();
                                                                              getFlightsNumber();
                                                                              dayIndex = -1;
                                                                            });
                                                                            Navigator.pop(context);
                                                                          },
                                                                        ));
                                                              },
                                                              child: Icon(
                                                                Icons.delete,
                                                                size: 14,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 28,
                                                          child: Text(''),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                )),

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

                    index == 0
                        ? Visibility(
                            visible: offer
                                .airportTransferGo[0].transportation.visibility,
                            child: Container(
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
                                                offer.airportTransferGo[0]
                                                    .transportation.image
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
                                                      localAssistant
                                                          .getTransportationByLocale(
                                                              context,
                                                              offer
                                                                  .airportTransferGo[
                                                                      0]
                                                                  .transportation)
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
                                                              'do_plan_car_from') +
                                                          localAssistant
                                                              .getAirportByLocale(
                                                                  context,
                                                                  offer
                                                                      .airportGo)
                                                              .toString() +
                                                          getTranslated(context,
                                                              'do_plan_car_to'),
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color:
                                                              Colors.black54),
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
                                                      onPressed: () {
                                                        changeTransportation(
                                                            context,
                                                            screenWidth,
                                                            screenHeight,
                                                            0,
                                                            index,
                                                            offer
                                                                .airportTransferGo);
                                                      },
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
                                                      onPressed: () {
                                                        print(index);
                                                        changeTransportationVisibility(
                                                            offer
                                                                .airportTransferGo[
                                                                    0]
                                                                .transportation);
                                                      },
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
                          )
                        : Visibility(
                            visible: offer.days[index].transportationMethods
                                .defaultTrans[0].transportation.visibility,
                            child: Container(
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
                                                      localAssistant
                                                          .getTransportationByLocale(
                                                              context,
                                                              offer
                                                                  .days[index]
                                                                  .transportationMethods
                                                                  .defaultTrans[
                                                                      0]
                                                                  .transportation)
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
                                                              'do_plan_car_from') +
                                                          localAssistant
                                                              .getDayCityByLocale(
                                                                  context,
                                                                  offer.days[
                                                                      index -
                                                                          1])
                                                              .toString() +
                                                          getTranslated(context,
                                                              'do_plan_car_to_2') +
                                                          localAssistant
                                                              .getDayCityByLocale(
                                                                  context,
                                                                  offer.days[
                                                                      index])
                                                              .toString(),
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color:
                                                              Colors.black54),
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
                                                      onPressed: () {
                                                        changeTransportation(
                                                            context,
                                                            screenWidth,
                                                            screenHeight,
                                                            1,
                                                            index,
                                                            offer
                                                                .days[index]
                                                                .transportationMethods
                                                                .additionalTrans);
                                                      },
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
                                                      onPressed: () {
                                                        print(index);
                                                        changeTransportationVisibility(offer
                                                            .days[index]
                                                            .transportationMethods
                                                            .defaultTrans[0]
                                                            .transportation);
                                                      },
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
                                              value: double.tryParse(offer
                                                      .days[index]
                                                      .hotels[0]
                                                      .rating
                                                      .toString()) ??
                                                  3.0,
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
                                              onPressed: () {

                                                print('check in date:' + _hotelsCheckInDates[index]);
                                                print('checkout date:' + fullFormatter
                                                    .format(DateTime.parse(
                                                    _hotelsCheckInDates[
                                                    index])
                                                    .add(Duration(
                                                    days: offer
                                                        .days[index]
                                                        .trips
                                                        .length)))
                                                    .toString());

                                                changeHotel(
                                                    context,
                                                    screenWidth,
                                                    screenHeight,
                                                    offer.days[index].cityId,
                                                    _hotelsCheckInDates[index],
                                                    fullFormatter
                                                        .format(DateTime.parse(
                                                                _hotelsCheckInDates[
                                                                    index])
                                                            .add(Duration(
                                                                days: offer
                                                                    .days[index]
                                                                    .trips
                                                                    .length)))
                                                        .toString(),
                                                    _adultsNumber,
                                                    _childrenNumber +
                                                        _babiesNumber,
                                                    offer.days.indexOf(
                                                        offer.days[index]));
                                              },
                                              color: Colors.teal,
                                              child: Icon(
                                                Icons.edit,
                                                size: 14,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                        // Expanded(
                                        //   flex: 22,
                                        //   child: Padding(
                                        //     padding: const EdgeInsets.all(2.0),
                                        //     child: GFButton(
                                        //       color: Colors.redAccent,
                                        //       onPressed: () {},
                                        //       child: Icon(
                                        //         Icons.delete,
                                        //         size: 14,
                                        //         color: Colors.white,
                                        //       ),
                                        //     ),
                                        //   ),
                                        // ),

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
                            Visibility(
                              visible: offer.days[index].trips[i].visibility,
                              child: Container(
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
                                                                offer
                                                                    .days[index]
                                                                    .trips[i],
                                                                'name')
                                                            .toString(),
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 15,
                                                            color:
                                                                Colors.black),
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
                                              padding:
                                                  const EdgeInsets.all(4.0),
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
                                                        onPressed: () {
                                                          changeTrip(
                                                              context,
                                                              screenWidth,
                                                              screenHeight,
                                                              offer
                                                                  .days[index]
                                                                  .trips[i]
                                                                  .cityId,
                                                              offer.days[index]
                                                                  .trips[i].id,
                                                              _adultsNumber,
                                                              _childrenNumber,
                                                              _babiesNumber,
                                                              offer.days
                                                                  .indexOf(offer
                                                                          .days[
                                                                      index]),
                                                              offer.days[index]
                                                                  .trips
                                                                  .indexOf(offer
                                                                      .days[
                                                                          index]
                                                                      .trips[i]));
                                                        },
                                                        color: Colors.teal,
                                                        child: Icon(
                                                          Icons.edit,
                                                          size: 14,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  // Expanded(
                                                  //   flex: 22,
                                                  //   child: Padding(
                                                  //     padding:
                                                  //         const EdgeInsets.all(
                                                  //             2.0),
                                                  //     child: GFButton(
                                                  //       color: Colors.redAccent,
                                                  //       onPressed: () {
                                                  //
                                                  //         showDialog(
                                                  //             context: context,
                                                  //             builder: (_) => AssetGiffyDialog(
                                                  //               onlyOkButton: true,
                                                  //               buttonCancelText: Text(getTranslated(context, 'login_alert_d_cancel'),
                                                  //                   style: TextStyle(fontSize: 16)),
                                                  //               buttonOkText: Text(getTranslated(context, 'edit_book_delete'),
                                                  //                   style: TextStyle(
                                                  //                       fontSize: 16,
                                                  //                       color: Colors.white)),
                                                  //               buttonOkColor: Colors.redAccent,
                                                  //               image: Image.asset('assets/images/alert.png', fit: BoxFit.cover),
                                                  //               title: Text(
                                                  //                 getTranslated(context, 'home_alert_login_title'),
                                                  //                 style: TextStyle(
                                                  //                     fontSize: 18.0,
                                                  //                     color: Colors.teal),
                                                  //               ),
                                                  //               description: Text(
                                                  //                 getTranslated(context, 'fo_trip_remove_note'),
                                                  //                 textAlign: TextAlign.center,
                                                  //                 style: TextStyle(fontSize: 16),
                                                  //               ),
                                                  //               onOkButtonPressed: () {
                                                  //                 setState(() {
                                                  //                   offer.days[index].trips[i].visibility = ! offer.days[index].trips[i].visibility;
                                                  //                   calculateOfferPrice();
                                                  //                   calculateTripsNumber();
                                                  //                   dayIndex = -1;
                                                  //                 });
                                                  //                 Navigator.pop(context);
                                                  //               },
                                                  //             ));
                                                  //
                                                  //       },
                                                  //       child: Icon(
                                                  //         Icons.delete,
                                                  //         size: 14,
                                                  //         color: Colors.white,
                                                  //       ),
                                                  //     ),
                                                  //   ),
                                                  // ),

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
                            ),
                          ],
                        );
                      }),

                    index == offer.days.length - 1
                        ? Visibility(
                            visible: offer.airportTransferBack[0].transportation
                                .visibility,
                            child: Container(
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
                                                  offer.airportTransferBack[0]
                                                      .transportation.image
                                                      .toString(),
                                              fit: BoxFit.cover,
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
                                                          .getTransportationByLocale(
                                                              context,
                                                              offer
                                                                  .airportTransferBack[
                                                                      0]
                                                                  .transportation)
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
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color:
                                                              Colors.black54),
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
                                                      onPressed: () {
                                                        changeTransportation(
                                                            context,
                                                            screenWidth,
                                                            screenHeight,
                                                            2,
                                                            index,
                                                            offer
                                                                .airportTransferBack);
                                                      },
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
                                                      onPressed: () {
                                                        changeTransportationVisibility(offer
                                                            .airportTransferBack[
                                                                0]
                                                            .transportation);
                                                      },
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
                          )
                        : Container(
                            width: 1,
                            height: 1,
                          ),

                    // Flight label
                    if (index == offer.days.length - 1)
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
                                          Icons.airplanemode_active,
                                          color: Color(0xff07898B),
                                          size: 15,
                                        ),
                                      ),
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
                                              context, 'do_flights_tab'),
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

                    if (index == offer.days.length - 1)
                      _flightsBack.length == 0
                          ? Container(
                              width: screenWidth * 0.9,
                              child: Card(
                                color: Color(0xffCCE5FF),
                                child: Row(
                                  children: [
                                    Flexible(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          _originCode == ' ' ?
                                          getTranslated(context,
                                              'fo_no_flight')
                                              :
                                          _isFlight == false ?
                                          getTranslated(context,
                                              'fo_no_flight')
                                              :
                                          getTranslated(context,
                                              'fo_no_flight_2'),
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Color(0xff0040A2),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : Visibility(
                              visible: _flightsBack[0].visibility,
                              child: Container(
                                width: screenWidth * 0.9,
                                child: Card(
                                  elevation: 2.0,
                                  child: Column(
                                    children: <Widget>[
                                      for (int index = 0;
                                          index <
                                              _flightsBack[0]
                                                  .originDestinationOptions[0]
                                                  .flightSegments
                                                  .length;
                                          index++)
                                        Row(
                                          children: [
                                            Expanded(
                                              flex: 33,
                                              child: Column(
                                                children: <Widget>[
                                                  Row(
                                                    // mainAxisAlignment: MainAxisAlignment.end,
                                                    children: <Widget>[
                                                      Align(
                                                        alignment:
                                                            AlignmentDirectional
                                                                .centerStart,
                                                        child: Padding(
                                                          padding: EdgeInsetsDirectional
                                                              .only(
                                                                  start:
                                                                      screenWidth *
                                                                          0.07),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(4.0),
                                                            child: Container(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(2.0),
                                                              width: 25,
                                                              height: 25,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Color(
                                                                    0xffFFCECF),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            50),
                                                                border:
                                                                    Border.all(
                                                                  width: 3,
                                                                  color: Colors
                                                                      .redAccent,
                                                                  style:
                                                                      BorderStyle
                                                                          .solid,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(4.0),
                                                        child: Text(
                                                          _flightsBack[0]
                                                              .originDestinationOptions[
                                                                  0]
                                                              .flightSegments[
                                                                  index]
                                                              .departureAirportLocationCode
                                                              .toString(),
                                                          style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      Text(
                                                        _flightsBack[0]
                                                            .originDestinationOptions[
                                                                0]
                                                            .flightSegments[
                                                                index]
                                                            .departureDateTime
                                                            .toString()
                                                            .substring(11),
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.black38,
                                                        ),
                                                        textAlign:
                                                            TextAlign.end,
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              flex: 33,
                                              child: Column(
                                                children: <Widget>[
                                                  Icon(
                                                    Icons.flight,
                                                    color: Color(0xff07898B),
                                                  ),
                                                  Text(
                                                    _flightsBack[0]
                                                        .originDestinationOptions[
                                                            0]
                                                        .flightSegments[index]
                                                        .journeyDuration
                                                        .toString(),
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.black38,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              flex: 33,
                                              child: Column(
                                                children: <Widget>[
                                                  Row(
                                                    children: <Widget>[
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(4.0),
                                                        child: Container(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  2.0),
                                                          width: 25,
                                                          height: 25,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Color(
                                                                0xffFFCECF),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50),
                                                            border: Border.all(
                                                              width: 3,
                                                              color: Colors
                                                                  .redAccent,
                                                              style: BorderStyle
                                                                  .solid,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(4.0),
                                                        child: Text(
                                                          _flightsBack[0]
                                                              .originDestinationOptions[
                                                                  0]
                                                              .flightSegments[
                                                                  index]
                                                              .arrivalAirportLocationCode
                                                              .toString(),
                                                          style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  Text(
                                                    _flightsBack[0]
                                                        .originDestinationOptions[
                                                            0]
                                                        .flightSegments[index]
                                                        .arrivalDateTime
                                                        .toString()
                                                        .substring(11),
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.black38,
                                                    ),
                                                    textAlign: TextAlign.end,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      Container(
                                        height: screenHeight * 0.06,
                                        width: screenWidth * 0.9,
                                        padding: const EdgeInsets.all(4.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Expanded(
                                              flex: 28,
                                              child: Text(''),
                                            ),
                                            Expanded(
                                              flex: 22,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(2.0),
                                                child: GFButton(
                                                  onPressed: () {
                                                    changeDepartureFlight(
                                                        context,
                                                        screenWidth,
                                                        screenHeight);
                                                  },
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
                                                  onPressed: () {
                                                    print(index);

                                                    showDialog(
                                                        context: context,
                                                        builder: (_) =>
                                                            AssetGiffyDialog(
                                                              onlyOkButton:
                                                                  true,
                                                              buttonCancelText: Text(
                                                                  getTranslated(
                                                                      context,
                                                                      'login_alert_d_cancel'),
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          16)),
                                                              buttonOkText: Text(
                                                                  getTranslated(
                                                                      context,
                                                                      'edit_book_delete'),
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          16,
                                                                      color: Colors
                                                                          .white)),
                                                              buttonOkColor:
                                                                  Colors
                                                                      .redAccent,
                                                              image: Image.asset(
                                                                  'assets/images/alert.png',
                                                                  fit: BoxFit
                                                                      .cover),
                                                              title: Text(
                                                                getTranslated(
                                                                    context,
                                                                    'home_alert_login_title'),
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        18.0,
                                                                    color: Colors
                                                                        .teal),
                                                              ),
                                                              description: Text(
                                                                getTranslated(
                                                                    context,
                                                                    'fo_flight_remove_note'),
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        16),
                                                              ),
                                                              onOkButtonPressed:
                                                                  () {
                                                                setState(() {
                                                                  _flightsBack[
                                                                              0]
                                                                          .visibility =
                                                                      !_flightsBack[
                                                                              0]
                                                                          .visibility;
                                                                  calculateOfferPrice();
                                                                  getFlightsNumber();
                                                                  dayIndex = -1;
                                                                });
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                            ));
                                                  },
                                                  child: Icon(
                                                    Icons.delete,
                                                    size: 14,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 28,
                                              child: Text(''),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
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
              index == 0
                  ? Visibility(
                      visible:
                          offer.airportTransferGo[0].transportation.visibility,
                      child: Container(
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
                                          offer.airportTransferGo[0]
                                              .transportation.image
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
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .only(start: 4.0),
                                              child: Text(
                                                localAssistant
                                                    .getTransportationByLocale(
                                                        context,
                                                        offer
                                                            .airportTransferGo[
                                                                0]
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
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .only(start: 4.0),
                                              child: Text(
                                                getTranslated(context,
                                                        'do_plan_car_from') +
                                                    localAssistant
                                                        .getAirportByLocale(
                                                            context,
                                                            offer.airportGo)
                                                        .toString() +
                                                    getTranslated(context,
                                                        'do_plan_car_to'),
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
                                                onPressed: () {
                                                  changeTransportation(
                                                      context,
                                                      screenWidth,
                                                      screenHeight,
                                                      0,
                                                      index,
                                                      offer.airportTransferGo);
                                                },
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
                                                onPressed: () {
                                                  print(index);
                                                  changeTransportationVisibility(
                                                      offer.airportTransferGo[0]
                                                          .transportation);
                                                },
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
                    )
                  : Visibility(
                      visible: offer.days[index].transportationMethods
                          .defaultTrans[0].transportation.visibility,
                      child: Container(
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
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .only(start: 4.0),
                                              child: Text(
                                                localAssistant
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
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .only(start: 4.0),
                                              child: Text(
                                                getTranslated(context,
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
                                                onPressed: () {
                                                  changeTransportation(
                                                      context,
                                                      screenWidth,
                                                      screenHeight,
                                                      1,
                                                      index,
                                                      offer
                                                          .days[index]
                                                          .transportationMethods
                                                          .additionalTrans);
                                                },
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
                                                onPressed: () {
                                                  print(index);
                                                  changeTransportationVisibility(
                                                      offer
                                                          .days[index]
                                                          .transportationMethods
                                                          .defaultTrans[0]
                                                          .transportation);
                                                },
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
                    ),
              index == offer.days.length - 1
                  ? Visibility(
                      visible: offer
                          .airportTransferBack[0].transportation.visibility,
                      child: Container(
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
                                            offer.airportTransferBack[0]
                                                .transportation.image
                                                .toString(),
                                        fit: BoxFit.cover,
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
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .only(start: 4.0),
                                              child: Text(
                                                localAssistant
                                                    .getTransportationByLocale(
                                                        context,
                                                        offer
                                                            .airportTransferBack[
                                                                0]
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
                                              padding:
                                                  const EdgeInsetsDirectional
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
                                                onPressed: () {
                                                  changeTransportation(
                                                      context,
                                                      screenWidth,
                                                      screenHeight,
                                                      2,
                                                      index,
                                                      offer
                                                          .airportTransferBack);
                                                },
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
                                                onPressed: () {
                                                  changeTransportationVisibility(
                                                      offer
                                                          .airportTransferBack[
                                                              0]
                                                          .transportation);
                                                },
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
          for (int i = 0; i < offer.days[index].trips.length; i++)
            // Trip
            Visibility(
              visible: offer.days[index].trips[i].visibility,
              child: Container(
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
                                    offer.days[index].trips[i].image.toString(),
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
                                                offer.days[index].trips[i],
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
                                        onPressed: () {
                                          changeTrip(
                                              context,
                                              screenWidth,
                                              screenHeight,
                                              offer.days[index].trips[i].cityId,
                                              offer.days[index].trips[i].id,
                                              _adultsNumber,
                                              _childrenNumber,
                                              _babiesNumber,
                                              offer.days
                                                  .indexOf(offer.days[index]),
                                              offer.days[index].trips.indexOf(
                                                  offer.days[index].trips[i]));
                                        },
                                        color: Colors.teal,
                                        child: Icon(
                                          Icons.edit,
                                          size: 14,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  // Expanded(
                                  //   flex: 22,
                                  //   child: Padding(
                                  //     padding:
                                  //     const EdgeInsets.all(
                                  //         2.0),
                                  //     child: GFButton(
                                  //       color: Colors.redAccent,
                                  //       onPressed: () {
                                  //
                                  //         showDialog(
                                  //             context: context,
                                  //             builder: (_) => AssetGiffyDialog(
                                  //               onlyOkButton: true,
                                  //               buttonCancelText: Text(getTranslated(context, 'login_alert_d_cancel'),
                                  //                   style: TextStyle(fontSize: 16)),
                                  //               buttonOkText: Text(getTranslated(context, 'edit_book_delete'),
                                  //                   style: TextStyle(
                                  //                       fontSize: 16,
                                  //                       color: Colors.white)),
                                  //               buttonOkColor: Colors.redAccent,
                                  //               image: Image.asset('assets/images/alert.png', fit: BoxFit.cover),
                                  //               title: Text(
                                  //                 getTranslated(context, 'home_alert_login_title'),
                                  //                 style: TextStyle(
                                  //                     fontSize: 18.0,
                                  //                     color: Colors.teal),
                                  //               ),
                                  //               description: Text(
                                  //                 getTranslated(context, 'fo_trip_remove_note'),
                                  //                 textAlign: TextAlign.center,
                                  //                 style: TextStyle(fontSize: 16),
                                  //               ),
                                  //               onOkButtonPressed: () {
                                  //                 setState(() {
                                  //                   offer.days[index].trips[i].visibility = ! offer.days[index].trips[i].visibility;
                                  //                   calculateOfferPrice();
                                  //                   calculateTripsNumber();
                                  //                   dayIndex = -1;
                                  //                 });
                                  //                 Navigator.pop(context);
                                  //               },
                                  //             ));
                                  //
                                  //         setState(() {
                                  //         });
                                  //
                                  //       },
                                  //       child: Icon(
                                  //         Icons.delete,
                                  //         size: 14,
                                  //         color: Colors.white,
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),

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
            ),
      ],
    );
  }

  void calculateTripsNumber() {
    setState(() {
      activitiesNumber = 0;
    });
    for (int index = 0; index < offer.days.length; index++)
      for (int i = 0; i < offer.days[index].trips.length; i++)
        if (offer.days[index].trips[i].visibility == true)
          setState(() {
            activitiesNumber++;
          });
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
        for (int index = 0; index < offer.days.length; index++)
          Builder(builder: (context) {
            return Column(
              children: <Widget>[
                if (index == 0)
                  Container(
                      width: screenWidth * 0.9,
                      child: _isFlightsLoading
                          ? Center(
                              child: GFLoader(
                                type: GFLoaderType.circle,
                                loaderColorOne: Color(0xff07898B),
                                loaderColorTwo: Color(0xff07898B),
                                loaderColorThree: Color(0xff07898B),
                              ),
                            )
                          : Container(
                              child: _flights.length == 0
                                  ? Container(
                                      width: screenWidth * 0.9,
                                      child: Card(
                                        color: Color(0xffCCE5FF),
                                        child: Row(
                                          children: [
                                            Flexible(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  _originCode == ' ' ?
                                                  getTranslated(context,
                                                      'fo_no_flight')
                                                      :
                                                  _isFlight == false ?
                                                  getTranslated(context,
                                                      'fo_no_flight')
                                                      :
                                                  getTranslated(context,
                                                      'fo_no_flight_2'),
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    color: Color(0xff0040A2),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  : Visibility(
                                      visible: _flights[0].visibility,
                                      child: Container(
                                        width: screenWidth * 0.9,
                                        child: Card(
                                          elevation: 2.0,
                                          child: Column(
                                            children: <Widget>[
                                              for (int index = 0;
                                                  index <
                                                      _flights[0]
                                                          .originDestinationOptions[
                                                              0]
                                                          .flightSegments
                                                          .length;
                                                  index++)
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      flex: 33,
                                                      child: Column(
                                                        children: <Widget>[
                                                          Row(
                                                            // mainAxisAlignment: MainAxisAlignment.end,
                                                            children: <Widget>[
                                                              Align(
                                                                alignment:
                                                                    AlignmentDirectional
                                                                        .centerStart,
                                                                child: Padding(
                                                                  padding: EdgeInsetsDirectional.only(
                                                                      start: screenWidth *
                                                                          0.07),
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            4.0),
                                                                    child:
                                                                        Container(
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              2.0),
                                                                      width: 25,
                                                                      height:
                                                                          25,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: Color(
                                                                            0xffFFCECF),
                                                                        borderRadius:
                                                                            BorderRadius.circular(50),
                                                                        border:
                                                                            Border.all(
                                                                          width:
                                                                              3,
                                                                          color:
                                                                              Colors.redAccent,
                                                                          style:
                                                                              BorderStyle.solid,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        4.0),
                                                                child: Text(
                                                                  _flights[0]
                                                                      .originDestinationOptions[
                                                                          0]
                                                                      .flightSegments[
                                                                          index]
                                                                      .departureAirportLocationCode
                                                                      .toString(),
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        20,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                          // Row(
                                                          //   mainAxisAlignment: MainAxisAlignment.end,
                                                          //   children: [
                                                          //     Flexible(
                                                          //       child: Text(
                                                          //         localAssistant.getFlightSegmentByLocale(context, 'd', _flights[0].originDestinationOptions[0].flightSegments[index]).toString(),
                                                          //         style: TextStyle(
                                                          //           fontSize: 14,
                                                          //           color: Colors.black38,
                                                          //         ),
                                                          //         textAlign: TextAlign.end,
                                                          //       ),
                                                          //     ),
                                                          //   ],
                                                          // ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .end,
                                                            children: [
                                                              Text(
                                                                _flights[0]
                                                                    .originDestinationOptions[
                                                                        0]
                                                                    .flightSegments[
                                                                        index]
                                                                    .departureDateTime
                                                                    .toString()
                                                                    .substring(
                                                                        11),
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .black38,
                                                                ),
                                                                textAlign:
                                                                    TextAlign
                                                                        .end,
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 33,
                                                      child: Column(
                                                        children: <Widget>[
                                                          Icon(
                                                            Icons.flight,
                                                            color: Color(
                                                                0xff07898B),
                                                          ),
                                                          Text(
                                                            _flights[0]
                                                                .originDestinationOptions[
                                                                    0]
                                                                .flightSegments[
                                                                    index]
                                                                .journeyDuration
                                                                .toString(),
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                              color: Colors
                                                                  .black38,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 33,
                                                      child: Column(
                                                        children: <Widget>[
                                                          Row(
                                                            children: <Widget>[
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        4.0),
                                                                child:
                                                                    Container(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              2.0),
                                                                  width: 25,
                                                                  height: 25,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Color(
                                                                        0xffFFCECF),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            50),
                                                                    border:
                                                                        Border
                                                                            .all(
                                                                      width: 3,
                                                                      color: Colors
                                                                          .redAccent,
                                                                      style: BorderStyle
                                                                          .solid,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        4.0),
                                                                child: Text(
                                                                  _flights[0]
                                                                      .originDestinationOptions[
                                                                          0]
                                                                      .flightSegments[
                                                                          index]
                                                                      .arrivalAirportLocationCode
                                                                      .toString(),
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        20,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                          // Row(
                                                          //   // mainAxisAlignment: MainAxisAlignment.end,
                                                          //   children: [
                                                          //     Flexible(
                                                          //       child: Text(
                                                          //         localAssistant.getFlightSegmentByLocale(context, 'a', _flights[0].originDestinationOptions[0].flightSegments[index]).toString(),
                                                          //         style: TextStyle(
                                                          //           fontSize: 14,
                                                          //           color: Colors.black38,
                                                          //         ),
                                                          //         textAlign: TextAlign.start,
                                                          //       ),
                                                          //     ),
                                                          //   ],
                                                          // ),
                                                          Text(
                                                            _flights[0]
                                                                .originDestinationOptions[
                                                                    0]
                                                                .flightSegments[
                                                                    index]
                                                                .arrivalDateTime
                                                                .toString()
                                                                .substring(11),
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                              color: Colors
                                                                  .black38,
                                                            ),
                                                            textAlign:
                                                                TextAlign.end,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              Container(
                                                height: screenHeight * 0.06,
                                                width: screenWidth * 0.9,
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Expanded(
                                                      flex: 28,
                                                      child: Text(''),
                                                    ),
                                                    Expanded(
                                                      flex: 22,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(2.0),
                                                        child: GFButton(
                                                          onPressed: () {
                                                            changeDepartureFlight(
                                                                context,
                                                                screenWidth,
                                                                screenHeight);
                                                          },
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
                                                            const EdgeInsets
                                                                .all(2.0),
                                                        child: GFButton(
                                                          color:
                                                              Colors.redAccent,
                                                          onPressed: () {
                                                            print(index);

                                                            showDialog(
                                                                context:
                                                                    context,
                                                                builder: (_) =>
                                                                    AssetGiffyDialog(
                                                                      onlyOkButton:
                                                                          true,
                                                                      buttonCancelText: Text(
                                                                          getTranslated(
                                                                              context,
                                                                              'login_alert_d_cancel'),
                                                                          style:
                                                                              TextStyle(fontSize: 16)),
                                                                      buttonOkText: Text(
                                                                          getTranslated(
                                                                              context,
                                                                              'edit_book_delete'),
                                                                          style: TextStyle(
                                                                              fontSize: 16,
                                                                              color: Colors.white)),
                                                                      buttonOkColor:
                                                                          Colors
                                                                              .redAccent,
                                                                      image: Image.asset(
                                                                          'assets/images/alert.png',
                                                                          fit: BoxFit
                                                                              .cover),
                                                                      title:
                                                                          Text(
                                                                        getTranslated(
                                                                            context,
                                                                            'home_alert_login_title'),
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                18.0,
                                                                            color:
                                                                                Colors.teal),
                                                                      ),
                                                                      description:
                                                                          Text(
                                                                        getTranslated(
                                                                            context,
                                                                            'fo_flight_remove_note'),
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                16),
                                                                      ),
                                                                      onOkButtonPressed:
                                                                          () {
                                                                        setState(
                                                                            () {
                                                                          _flights[0].visibility =
                                                                              !_flights[0].visibility;
                                                                          calculateOfferPrice();
                                                                          getFlightsNumber();
                                                                          dayIndex =
                                                                              -1;
                                                                        });
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                    ));
                                                          },
                                                          child: Icon(
                                                            Icons.delete,
                                                            size: 14,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 28,
                                                      child: Text(''),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                            )),
                if (index == offer.days.length - 1)
                  Container(
                    child: _isFlightsLoading
                        ? Center(
                            child: GFLoader(
                              type: GFLoaderType.circle,
                              loaderColorOne: Color(0xff07898B),
                              loaderColorTwo: Color(0xff07898B),
                              loaderColorThree: Color(0xff07898B),
                            ),
                          )
                        : Container(
                            child: _flightsBack.length == 0
                                ? Container(
                                    width: screenWidth * 0.9,
                                    child: Card(
                                      color: Color(0xffCCE5FF),
                                      child: Row(
                                        children: [
                                          Flexible(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                _originCode == ' ' ?
                                                getTranslated(context,
                                                    'fo_no_flight')
                                                    :
                                                _isFlight == false ?
                                                getTranslated(context,
                                                    'fo_no_flight')
                                                    :
                                                getTranslated(context,
                                                    'fo_no_flight_2'),
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  color: Color(0xff0040A2),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                : Visibility(
                                    visible: _flightsBack[0].visibility,
                                    child: Container(
                                      width: screenWidth * 0.9,
                                      child: Card(
                                        elevation: 2.0,
                                        child: Column(
                                          children: <Widget>[
                                            for (int index = 0;
                                                index <
                                                    _flightsBack[0]
                                                        .originDestinationOptions[
                                                            0]
                                                        .flightSegments
                                                        .length;
                                                index++)
                                              Row(
                                                children: [
                                                  Expanded(
                                                    flex: 33,
                                                    child: Column(
                                                      children: <Widget>[
                                                        Row(
                                                          // mainAxisAlignment: MainAxisAlignment.end,
                                                          children: <Widget>[
                                                            Align(
                                                              alignment:
                                                                  AlignmentDirectional
                                                                      .centerStart,
                                                              child: Padding(
                                                                padding: EdgeInsetsDirectional.only(
                                                                    start:
                                                                        screenWidth *
                                                                            0.07),
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          4.0),
                                                                  child:
                                                                      Container(
                                                                    padding:
                                                                        EdgeInsets.all(
                                                                            2.0),
                                                                    width: 25,
                                                                    height: 25,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Color(
                                                                          0xffFFCECF),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              50),
                                                                      border:
                                                                          Border
                                                                              .all(
                                                                        width:
                                                                            3,
                                                                        color: Colors
                                                                            .redAccent,
                                                                        style: BorderStyle
                                                                            .solid,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(4.0),
                                                              child: Text(
                                                                _flightsBack[0]
                                                                    .originDestinationOptions[
                                                                        0]
                                                                    .flightSegments[
                                                                        index]
                                                                    .departureAirportLocationCode
                                                                    .toString(),
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Text(
                                                              _flightsBack[0]
                                                                  .originDestinationOptions[
                                                                      0]
                                                                  .flightSegments[
                                                                      index]
                                                                  .departureDateTime
                                                                  .toString()
                                                                  .substring(
                                                                      11),
                                                              style: TextStyle(
                                                                fontSize: 14,
                                                                color: Colors
                                                                    .black38,
                                                              ),
                                                              textAlign:
                                                                  TextAlign.end,
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 33,
                                                    child: Column(
                                                      children: <Widget>[
                                                        Icon(
                                                          Icons.flight,
                                                          color:
                                                              Color(0xff07898B),
                                                        ),
                                                        Text(
                                                          _flightsBack[0]
                                                              .originDestinationOptions[
                                                                  0]
                                                              .flightSegments[
                                                                  index]
                                                              .journeyDuration
                                                              .toString(),
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            color:
                                                                Colors.black38,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 33,
                                                    child: Column(
                                                      children: <Widget>[
                                                        Row(
                                                          children: <Widget>[
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(4.0),
                                                              child: Container(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            2.0),
                                                                width: 25,
                                                                height: 25,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Color(
                                                                      0xffFFCECF),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              50),
                                                                  border: Border
                                                                      .all(
                                                                    width: 3,
                                                                    color: Colors
                                                                        .redAccent,
                                                                    style: BorderStyle
                                                                        .solid,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(4.0),
                                                              child: Text(
                                                                _flightsBack[0]
                                                                    .originDestinationOptions[
                                                                        0]
                                                                    .flightSegments[
                                                                        index]
                                                                    .arrivalAirportLocationCode
                                                                    .toString(),
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                        Text(
                                                          _flightsBack[0]
                                                              .originDestinationOptions[
                                                                  0]
                                                              .flightSegments[
                                                                  index]
                                                              .arrivalDateTime
                                                              .toString()
                                                              .substring(11),
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            color:
                                                                Colors.black38,
                                                          ),
                                                          textAlign:
                                                              TextAlign.end,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            Container(
                                              height: screenHeight * 0.06,
                                              width: screenWidth * 0.9,
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Expanded(
                                                    flex: 28,
                                                    child: Text(''),
                                                  ),
                                                  Expanded(
                                                    flex: 22,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              2.0),
                                                      child: GFButton(
                                                        onPressed: () {
                                                          changeDepartureFlight(
                                                              context,
                                                              screenWidth,
                                                              screenHeight);
                                                        },
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
                                                        onPressed: () {
                                                          print(index);

                                                          showDialog(
                                                              context: context,
                                                              builder: (_) =>
                                                                  AssetGiffyDialog(
                                                                    onlyOkButton:
                                                                        true,
                                                                    buttonCancelText: Text(
                                                                        getTranslated(
                                                                            context,
                                                                            'login_alert_d_cancel'),
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                16)),
                                                                    buttonOkText: Text(
                                                                        getTranslated(
                                                                            context,
                                                                            'edit_book_delete'),
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                16,
                                                                            color:
                                                                                Colors.white)),
                                                                    buttonOkColor:
                                                                        Colors
                                                                            .redAccent,
                                                                    image: Image.asset(
                                                                        'assets/images/alert.png',
                                                                        fit: BoxFit
                                                                            .cover),
                                                                    title: Text(
                                                                      getTranslated(
                                                                          context,
                                                                          'home_alert_login_title'),
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              18.0,
                                                                          color:
                                                                              Colors.teal),
                                                                    ),
                                                                    description:
                                                                        Text(
                                                                      getTranslated(
                                                                          context,
                                                                          'fo_flight_remove_note'),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              16),
                                                                    ),
                                                                    onOkButtonPressed:
                                                                        () {
                                                                      setState(
                                                                          () {
                                                                        _flightsBack[0]
                                                                            .visibility = !_flightsBack[
                                                                                0]
                                                                            .visibility;
                                                                        calculateOfferPrice();
                                                                        getFlightsNumber();
                                                                        dayIndex =
                                                                            -1;
                                                                      });
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                  ));
                                                        },
                                                        child: Icon(
                                                          Icons.delete,
                                                          size: 14,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 28,
                                                    child: Text(''),
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
              ],
            );
          }),
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
        lastDate: DateTime.now().add(Duration(days: 730)),
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
        firstFlightDate = fullFormatter.format(selectedDate).toString();
        prefs.setString(
            'departure_date', fullFormatter.format(selectedDate).toString());
        dayIndex = -1;
      });
    });
  }

  void calculatePassengersNumber() {
    setState(() {
      _totalPassengersNumber = _adultsNumber + _childrenNumber + _babiesNumber;
      dayIndex = -1;
    });
  }

  _openEditPackageWidget(context, screenWidth, screenHeight) {
    setState(() {
      dayIndex = -1;
    });

    showDialog(
        context: context,
        builder: (BuildContext bc) {
          return Dialog(
            child: StatefulBuilder(builder: (context, setState) {
              return Container(
                padding: EdgeInsets.all(0.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        width: screenWidth * 0.9,
                        color: Color(0xff07898B),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            getTranslated(context, 'fo_edit'),
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
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
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 8.0),
                        child: Container(
                          width: screenWidth * 0.84,
                          padding: EdgeInsets.only(
                              top: 0.0, right: 0.0, left: 0.0, bottom: 0.0),
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
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 8.0),
                        child: TextField(
                          controller: _nameController,
                          keyboardType: TextInputType.text,
                          // controller: _emailController,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.start,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 1.0, horizontal: 6.0),
                              hintText:
                                  getTranslated(context, 'pyt_in_t_source_btn'),
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

                          onChanged: (key) {
                            setState(() {
                              dayIndex = -1;
                            });

                            if (_nameController.text == '')
                              setState(() {
                                _isAirportResults = false;
                              });
                            else {
                              setState(() {
                                _isAirportResults = true;

                                betaApiAssistant.getAirport(key).then((value) {
                                  _airports = List.of(value);
                                  setState(() {
                                    _isAirportLoading = false;
                                    dayIndex = -1;
                                  });
                                });
                              });
                            }
                          },
                        ),
                      ),
                      Visibility(
                        visible: _isAirportResults,
                        child: Container(
                          width: screenWidth * 0.9,
                          child: _isAirportLoading
                              ? Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: GFLoader(
                                      type: GFLoaderType.circle,
                                      loaderColorOne: Color(0xff07898B),
                                      loaderColorTwo: Color(0xff07898B),
                                      loaderColorThree: Color(0xff07898B),
                                    ),
                                  ),
                                )
                              : Container(
                                  child: _airports.length == 0
                                      ? Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              getTranslated(
                                                  context, 'fo_no_airports'),
                                            ),
                                          ),
                                        )
                                      : Column(
                                          children: <Widget>[
                                            for (int index = 0;
                                                index < _airports.length;
                                                index++)
                                              ListTile(
                                                onTap: () {
                                                  setState(() {
                                                    _isNotLocked = false;
                                                    _isFlightsLoading = true;
                                                    _originCode =
                                                        _airports[index].iata;
                                                    _nameController
                                                        .text = localAssistant
                                                            .getAirportByLocale(
                                                                context,
                                                                _airports[
                                                                    index])
                                                            .toString() +
                                                        '-' +
                                                        _airports[index].iata;

                                                    prefs.setString(
                                                        'source_airport_code',
                                                        _airports[index].iata);

                                                    prefs.setString(
                                                        'source_airport',
                                                        localAssistant
                                                            .getAirportByLocale(
                                                                context,
                                                                _airports[
                                                                    index])
                                                            .toString());

                                                    _isAirportResults = false;

                                                    betaApiAssistant
                                                        .getFlightPath(
                                                            _originCode,
                                                            _destinationCode,
                                                            firstFlightDate)
                                                        .then((value) {
                                                      setState(() {
                                                        _flights =
                                                            List.of(value);

                                                        betaApiAssistant
                                                            .getFlightPath(
                                                                _destinationCode,
                                                                _originCode,
                                                                lastFlightDate)
                                                            .then((value2) {
                                                          setState(() {
                                                            _flightsBack =
                                                                List.of(value2);

                                                            getFlightsNumber();
                                                            calculateOfferPrice();

                                                            _isFlightsLoading =
                                                                false;
                                                            _isNotLocked = true;
                                                            dayIndex = -1;
                                                          });
                                                        });
                                                      });
                                                    });
                                                  });
                                                },
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 2.0,
                                                        horizontal: 16.0),
                                                leading: Icon(
                                                  MyIcons.plane_arrival,
                                                  color: Color(0xff07898B),
                                                ),
                                                title: Text(
                                                  localAssistant
                                                      .getAirportByLocale(
                                                          context,
                                                          _airports[index])
                                                      .toString(),
                                                  style: TextStyle(
                                                    fontSize: 15.0,
                                                    fontFamily: 'cairo',
                                                  ),
                                                ),
                                                trailing: Text(
                                                  _airports[index]
                                                      .iata
                                                      .toString(),
                                                  style: TextStyle(
                                                    fontSize: 16.0,
                                                    fontFamily: 'cairo',
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              )
                                          ],
                                        ),
                                ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 10.0),
                        child: GFButton(
                          color: Color(0xff07898b),
                          textColor: Colors.white,
                          fullWidthButton: true,
                          // text: getTranslated(context, 'fo_edit_save'),
                          size: 50.0,
                          // textStyle: TextStyle(
                          //   fontSize: 18.0,
                          //   fontFamily: 'cairo',
                          //   fontWeight: FontWeight.bold,
                          // ),
                          child: !_isNotLocked
                              ? GFLoader(
                                  type: GFLoaderType.circle,
                                  loaderColorOne: Colors.white,
                                  loaderColorTwo: Colors.white,
                                  loaderColorThree: Colors.white,
                                )
                              : Text(
                                  getTranslated(context, 'fo_edit_save'),
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontFamily: 'cairo',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                          onPressed: () {
                            if (_isNotLocked) {
                              Navigator.of(context).pop();
                              calculatePassengersNumber();
                              calculateOfferPrice();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          );
        });
  }

  void calculateOfferPrice() {
    setState(() {
      _totalOfferPrice = 0;
    });

    // Add departure flight price
    if (_flights.length > 0)
      setState(() {
        _totalOfferPrice +=
            _flights[0].airItineraryPricingInfo.flightTotalFare.totalFare;
      });

    // Add arrival flight price
    if (_flightsBack.length > 0)
      setState(() {
        _totalOfferPrice +=
            _flightsBack[0].airItineraryPricingInfo.flightTotalFare.totalFare;
      });



    for (int index = 0; index < offer.days.length; index++)
    {
      // Changed hotel price
      setState(() {
        _totalOfferPrice += offer.days[index].hotels[0].netRate;
      });

      // Trips
      for (int dIndex = 0; dIndex < offer.days[index].trips.length; dIndex++)
      {
        if (offer.days[index].trips[dIndex].visibility == true)
        {
          if (offer.days[index].trips[dIndex].pricePlus == 0) {
            //Adults price
            if (_adultsNumber == 1)
              setState(() {
                _totalOfferPrice +=
                    offer.days[index].trips[dIndex].pricePerson ?? 0;
              });
            else if (_adultsNumber == 2)
              setState(() {
                _totalOfferPrice +=
                    offer.days[index].trips[dIndex].pricePerson2 ?? 0;
              });
            else if (_adultsNumber == 3)
              setState(() {
                _totalOfferPrice +=
                    offer.days[index].trips[dIndex].pricePerson3 ?? 0;
              });
            else
              setState(() {
                _totalOfferPrice +=
                    offer.days[index].trips[dIndex].pricePerson *
                            _adultsNumber ??
                        0;
              });

            //Children price
            setState(() {
              _totalOfferPrice += offer.days[index].trips[dIndex].priceChild ??
                  0 * _childrenNumber;
            });

            //Babies price
            setState(() {
              _totalOfferPrice += offer.days[index].trips[dIndex].priceChild ??
                  0 * _babiesNumber;
            });
          }
          else
            {
            setState(() {
              _totalOfferPrice += offer.days[index].trips[dIndex].pricePlus;
            });
          }
        }
      }

      //Car Price
      if (index == 0) {
        if (offer.airportTransferGo[0].transportation.visibility ==
            true) if (offer.airportTransferGo[0].priceChild ==
                null &&
            offer.airportTransferGo[0].priceIndividuals == null)
          setState(() {
            carNumber = (_totalPassengersNumber /
                    offer.airportTransferGo[0].transportation.peopleNumber)
                .round();
            _totalOfferPrice += carNumber * offer.airportTransferGo[0].carPrice;
          });
        else
          setState(() {
            _totalOfferPrice += offer.airportTransferGo[0].priceChild != null
                ? offer.airportTransferGo[0].priceChild * _childrenNumber
                : 0 + offer.airportTransferGo[0].priceIndividuals != null
                    ? offer.airportTransferGo[0].priceIndividuals *
                        _adultsNumber
                    : 0;
          });
      }

      if (index != 0 &&
          offer.days[index].transportationMethods.defaultTrans[0].transportation
                  .visibility ==
              true) if (offer.days[index].transportationMethods.defaultTrans[0]
                  .priceChild ==
              null &&
          offer.days[index].transportationMethods.defaultTrans[0]
                  .priceIndividuals ==
              null)
        setState(() {
          carNumber = (_totalPassengersNumber /
                  offer.days[index].transportationMethods.defaultTrans[0]
                      .transportation.peopleNumber)
              .round();
          _totalOfferPrice += carNumber *
              offer.days[index].transportationMethods.defaultTrans[0].carPrice;
        });
      else
        setState(() {
          _totalOfferPrice += offer.days[index].transportationMethods
                      .defaultTrans[0].priceChild !=
                  null
              ? offer.days[index].transportationMethods.defaultTrans[0]
                      .priceChild *
                  _childrenNumber
              : 0 +
                          offer.days[index].transportationMethods
                              .defaultTrans[0].priceIndividuals !=
                      null
                  ? offer.days[index].transportationMethods.defaultTrans[0]
                          .priceIndividuals *
                      _adultsNumber
                  : 0;
        });

      if (index == offer.days.length - 1) {
        if (offer.airportTransferBack[0].transportation.visibility ==
            true) if (offer.airportTransferBack[0].priceChild ==
                null &&
            offer.airportTransferBack[0].priceIndividuals == null)
          setState(() {
            carNumber = (_totalPassengersNumber /
                    offer.airportTransferBack[0].transportation.peopleNumber)
                .round();
            _totalOfferPrice +=
                carNumber * offer.airportTransferBack[0].carPrice;
          });
        else
          setState(() {
            _totalOfferPrice += offer.airportTransferBack[0].priceChild != null
                ? offer.airportTransferBack[0].priceChild * _childrenNumber
                : 0 + offer.airportTransferBack[0].priceIndividuals != null
                    ? offer.airportTransferBack[0].priceIndividuals *
                        _adultsNumber
                    : 0;
          });
      }
    }
  }

  void getFlightsNumber() {
    setState(() {
      totalFlightsNumber = 0;
    });

    if (_flights.length > 0) if (_flights[0].visibility == true)
      setState(() {
        totalFlightsNumber +=
            _flights[0].originDestinationOptions[0].flightSegments.length;
      });

    if (_flightsBack.length > 0) if (_flightsBack[0].visibility == true)
      setState(() {
        totalFlightsNumber +=
            _flightsBack[0].originDestinationOptions[0].flightSegments.length;
      });
  }

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((value) {
      prefs = value;

      _loadUserPreferences().then((value) {
        if (firstFlightDate == ' ')
          setState(() {
            firstFlightDate = fullFormatter
                .format(DateTime.now().add(Duration(days: 15)))
                .toString();
          });
        print(firstFlightDate);

        betaApiAssistant.getOffer(widget.id, firstFlightDate).then((value) {
          setState(() {
            offer = value;
            _destinationCode = offer.airportGo.iata.toString();
            calculateFlightsDates();
            _hotelsCheckInDates.add(firstFlightDate);
            calculateHotelsCheckInDates();
            getOfferHotelsImages();

            if (_isFlight) {
              if (_originCode != ' ') {
                betaApiAssistant
                    .getFlightPath(
                        _originCode, _destinationCode, firstFlightDate)
                    .then((value) {
                  setState(() {
                    if(value.length > 0)
                    _flights = List.of(value);

                    betaApiAssistant
                        .getFlightPath(
                            _destinationCode, _originCode, lastFlightDate)
                        .then((value2) {
                      setState(() {
                        if(value.length > 0)
                        _flightsBack = List.of(value2);

                        getFlightsNumber();
                        calculateOfferPrice();
                        // getOfferImages();
                        buildHotelsList(offer);
                        calculateOfferNumber(offer);
                        calculatePassengersNumber();
                        // _pickedDate = DateFormat('MM/dd').parse(offer.days[0].trips[0].date.toString());
                        // _firstDate = DateFormat('MM-dd').parse(offer.days[0].trips[0].date.toString());
                        _isLoading = false;
                        _isPriceLoading = false;

                        dayIndex = -1;
                      });
                    });
                  });
                });
              }
            } else {
              getFlightsNumber();
              calculateOfferPrice();
              buildHotelsList(offer);
              calculateOfferNumber(offer);
              calculatePassengersNumber();
              _isLoading = false;
              _isPriceLoading = false;
              dayIndex = -1;
            }
          });
        });
      });
    });
  }

  // _commentsWidget(width, height) {
  //   return Column(
  //     children: <Widget>[
  //       for (int i = 0; i < _comments.length; i++)
  //         Row(
  //           children: [
  //             Container(
  //                 width: width * 0.94,
  //                 padding: EdgeInsetsDirectional.only(
  //                     start: width * 0.08, top: 10.0, bottom: 10.0),
  //                 child: Card(
  //                   elevation: 2.0,
  //                   child: ListTile(
  //                     leading: CircleAvatar(
  //                       radius: 30,
  //                       backgroundImage:
  //                           AssetImage('assets/images/profile.jpg'),
  //                     ),
  //                     title: Row(
  //                       mainAxisAlignment: MainAxisAlignment.start,
  //                       children: [
  //                         Expanded(
  //                           flex: 70,
  //                           child: Row(
  //                             children: [
  //                               Column(
  //                                 mainAxisAlignment: MainAxisAlignment.start,
  //                                 children: [
  //                                   Container(
  //                                     width: width * 0.35,
  //                                     child: FittedBox(
  //                                       fit: BoxFit.scaleDown,
  //                                       alignment: AlignmentDirectional.centerStart,
  //                                       child: Text(
  //                                         getTranslated(
  //                                             context, 'do_comments_username'),
  //                                         textAlign: TextAlign.start,
  //                                         style: TextStyle(
  //                                           fontSize: 17,
  //                                           fontWeight: FontWeight.bold,
  //                                           color: Colors.black,
  //                                         ),
  //                                       ),
  //                                     ),
  //                                   ),
  //                                   Container(
  //                                     width: 75,
  //                                     child: FittedBox(
  //                                       child: GFRating(
  //                                         color: Colors.amber,
  //                                         borderColor: Colors.amber,
  //                                         allowHalfRating: true,
  //                                         value: 3.5,
  //                                       ),
  //                                     ),
  //                                   ),
  //                                 ],
  //                               ),
  //                             ],
  //                           ),
  //                         ),
  //                         Expanded(
  //                           flex: 30,
  //                           child: Text(
  //                             '12-1-2021',
  //                             textAlign: TextAlign.end,
  //                             style: TextStyle(
  //                               fontSize: 12,
  //                               color: Colors.black54,
  //                             ),
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                     subtitle: Text(_comments[i].toString()),
  //                   ),
  //                 )),
  //           ],
  //         ),
  //     ],
  //   );
  // }

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
      // appBar: AppBar(
      //   backgroundColor: Color(0xffE9F7F8),
      //   backgroundColor: Colors.white,
      //   elevation: 0.0,
      //   shadowColor: Colors.white,
      //   title: Text(
      //     widget.package,
      //   ),
      //   centerTitle: true,
      // ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: GFButton(
        onPressed: () {
          Navigator.of(context).push(new MaterialPageRoute(
            builder: (BuildContext context) => new ConfirmBook()));
        },
        size: 50,
        shape: GFButtonShape.square,
        color: Color(0xff07898B),
        child: Container(
          width: screenWidth,
          height: screenHeight * 0.1,
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 60,
                child: _isPriceLoading ? Center(
                  child: GFLoader(
                    type: GFLoaderType.circle,
                    loaderColorOne: Colors.white,
                    loaderColorTwo: Colors.white,
                    loaderColorThree: Colors.white,
                  ),
                ) :
                Text(
                  _totalOfferPrice.toStringAsFixed(2) + ' \$',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
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
                    fontWeight: FontWeight.bold,
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
                    width: screenWidth,
                    // height: 250,
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: GestureDetector(
                      onTap: () {},
                      child: InkWell(
                        // borderRadius: BorderRadius.circular(4.0),
                        onTap: () {},
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
                                            BorderRadius.circular(0.0)),
                                  ),
                                  child: Image.network(
                                    'https://ipackagetours.com/storage/app/' +
                                        offer.image.toString(),
                                    fit: BoxFit.fill,
                                    height: screenHeight * 0.32,
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
                                              top: screenHeight * 0.25),
                                          constraints: BoxConstraints(),
                                          child: Container(
                                            width: 120,
                                            padding: const EdgeInsets.all(3.0),
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
                  // Container(
                  //   width: screenWidth * 0.84,
                  //   child: Column(
                  //     children: <Widget>[
                  //       ResponsiveGridRow(
                  //         children: [
                  //           for (var i = 0; i < _imageList.length; i++)
                  //             ResponsiveGridCol(
                  //               xs: 3,
                  //               md: 3,
                  //               child: Container(
                  //                   margin: const EdgeInsets.all(5.0),
                  //                   padding: const EdgeInsets.all(0.0),
                  //                   decoration: BoxDecoration(
                  //                     borderRadius: BorderRadius.circular(10),
                  //                   ),
                  //                   alignment: Alignment(0, 0),
                  //                   //color: Colors.grey,
                  //                   child: InkWell(
                  //                     onTap: () {},
                  //                     child: Card(
                  //                       margin: const EdgeInsets.all(0),
                  //                       shape: RoundedRectangleBorder(
                  //                         borderRadius:
                  //                             BorderRadius.circular(7),
                  //                       ),
                  //                       clipBehavior: Clip.antiAlias,
                  //                       child: Image.network(
                  //                         'https://ipackagetours.com/storage/app/' +
                  //                             _imageList[i].toString(),
                  //                         fit: BoxFit.fill,
                  //                         height: screenHeight * 0.07,
                  //                         width: screenWidth * 0.2,
                  //                       ),
                  //                     ),
                  //                   )),
                  //             ),
                  //         ],
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  Row(
                    children: [
                      Container(
                        width: screenWidth * 0.9,
                        padding: EdgeInsetsDirectional.only(
                            start: screenWidth * 0.08, top: 5.0, bottom: 5.0),
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
                                _totalPassengersNumber.toString() +
                                    ' ' +
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
                                firstFlightDate,
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
                                _openEditPackageWidget(
                                    context, screenWidth, screenHeight);
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
                                  totalFlightsNumber.toString(),
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

                  // Padding(
                  //   padding: const EdgeInsets.all(18.0),
                  //   child: GFButton(
                  //     onPressed: () {
                  //       Navigator.of(context).push(new MaterialPageRoute(
                  //           builder: (BuildContext context) =>
                  //               new ConfirmBook()));
                  //     },
                  //     size: 40,
                  //     shape: GFButtonShape.pills,
                  //     color: Color(0xff07898B),
                  //     child: Container(
                  //       width: screenWidth * 0.9,
                  //       height: screenHeight * 0.09,
                  //       child: Row(
                  //         children: <Widget>[
                  //           Expanded(
                  //             flex: 60,
                  //             child: _isPriceLoading
                  //                 ? Center(
                  //                     child: GFLoader(
                  //                       type: GFLoaderType.circle,
                  //                       loaderColorOne: Colors.white,
                  //                       loaderColorTwo: Colors.white,
                  //                       loaderColorThree: Colors.white,
                  //                     ),
                  //                   )
                  //                 : Text(
                  //                     _totalOfferPrice.toStringAsFixed(2) +
                  //                         ' \$',
                  //                     textAlign: TextAlign.center,
                  //                     style: TextStyle(
                  //                       fontSize: 18,
                  //                       fontWeight: FontWeight.bold,
                  //                       color: Colors.white,
                  //                     ),
                  //                   ),
                  //           ),
                  //           Expanded(
                  //             flex: 40,
                  //             child: Text(
                  //               getTranslated(
                  //                   context, 'domestic_offer_book_btn'),
                  //               textAlign: TextAlign.start,
                  //               style: TextStyle(
                  //                 fontSize: 16,
                  //                 fontWeight: FontWeight.bold,
                  //                 color: Colors.black,
                  //               ),
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //     textStyle: TextStyle(
                  //       fontFamily: 'cairo',
                  //     ),
                  //   ),
                  // ),

                  SizedBox(
                    height: screenHeight * 0.15,
                  ),
                  // Row(
                  //   children: [
                  //     Container(
                  //       padding: EdgeInsetsDirectional.only(
                  //           start: screenWidth * 0.08, top: 20.0, bottom: 10.0),
                  //       child: Text(
                  //         getTranslated(context, 'do_comments'),
                  //         textAlign: TextAlign.start,
                  //         style: TextStyle(
                  //           fontSize: 20,
                  //           fontWeight: FontWeight.bold,
                  //           color: Colors.black,
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),

                  // _commentsWidget(screenWidth, screenHeight),

                  // Row(
                  //   children: [
                  //     Container(
                  //       padding: EdgeInsetsDirectional.only(
                  //           start: screenWidth * 0.08, top: 20.0, bottom: 8.0),
                  //       child: Text(
                  //         getTranslated(context, 'do_similar_packages'),
                  //         textAlign: TextAlign.start,
                  //         style: TextStyle(
                  //           fontSize: 20,
                  //           fontWeight: FontWeight.bold,
                  //           color: Colors.black,
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
//                   Padding(
//                     padding: EdgeInsetsDirectional.only(
//                         start: screenWidth * 0.06, top: 8.0, bottom: 20.0),
//                     child: Container(
//                       height: screenHeight * 0.66,
//                       child: ListView(
//                         scrollDirection: Axis.horizontal,
//                         children: <Widget>[
//                           Container(
//                             width: screenWidth * 0.6,
//                             padding: const EdgeInsets.all(8.0),
//                             child: GestureDetector(
//                               onTap: () {},
//                               child: InkWell(
//                                 borderRadius: BorderRadius.circular(4.0),
//                                 onTap: () {
//                                   Navigator.of(context).push(
//                                       new MaterialPageRoute(
//                                           builder: (BuildContext context) =>
//                                               new DomesticOfferMain()));
//                                 },
//                                 child: Card(
//                                   shadowColor: Colors.white,
//                                   elevation: 0.0,
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(15),
//                                   ),
//                                   clipBehavior: Clip.antiAlias,
//                                   margin: const EdgeInsets.all(0.0),
//                                   color: Color(0xffFAFAFA),
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.stretch,
//                                     mainAxisAlignment: MainAxisAlignment.end,
//                                     children: [
//                                       Padding(
//                                         padding: const EdgeInsets.all(0),
//                                         child: Stack(
//                                           fit: StackFit.passthrough,
//                                           children: <Widget>[
//                                             Padding(
//                                               padding: const EdgeInsets.all(0),
//                                               child: ClipPath(
//                                                 clipper: ShapeBorderClipper(
//                                                   shape: RoundedRectangleBorder(
//                                                       borderRadius:
//                                                           BorderRadius.circular(
//                                                               15)),
//                                                 ),
//                                                 child: Image.asset(
//                                                   'assets/images/c4.jpg',
//                                                   fit: BoxFit.fill,
//                                                   height: screenHeight * 0.28,
//                                                 ),
//                                               ),
//                                             ),
//                                             Padding(
//                                               padding: const EdgeInsets.all(6),
//                                               child: Flex(
//                                                 direction: Axis.horizontal,
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment.end,
//                                                 children: <Widget>[
//                                                   Container(
//                                                     padding:
//                                                         const EdgeInsets.all(
//                                                             3.0),
//                                                     margin:
//                                                         const EdgeInsets.only(
//                                                             top: 20.0),
//                                                     constraints:
//                                                         BoxConstraints(),
//                                                     decoration: BoxDecoration(
//                                                       color: Colors.white,
//                                                       border: Border.all(
//                                                         color: Colors.white,
//                                                       ),
//                                                       borderRadius:
//                                                           BorderRadius.all(
//                                                         Radius.circular(10.0),
//                                                       ),
//                                                     ),
//                                                     child: Text(
//                                                       getTranslated(context,
//                                                           'home_offer_card_tag'),
//                                                       style: TextStyle(
//                                                         fontSize: 15,
//                                                         color: Colors.black,
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
// //
//                                       Padding(
//                                         padding: const EdgeInsets.all(8.0),
//                                         child: Text(
//                                           getTranslated(
//                                               context, 'home_offer_card_city'),
//                                           textAlign: TextAlign.start,
//                                           style: TextStyle(
//                                             fontSize: 18,
//                                             fontWeight: FontWeight.bold,
//                                             color: Color(0xff07898B),
//                                           ),
//                                           softWrap: true,
//                                         ),
//                                       ),
//
//                                       Container(
//                                         padding: const EdgeInsets.symmetric(
//                                             horizontal: 8.0),
//                                         child: Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.center,
//                                           children: [
//                                             Expanded(
//                                               flex: 50,
//                                               child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.only(
//                                                           top: 0.0,
//                                                           right: 0.0,
//                                                           left: 0.0,
//                                                           bottom: 0.0),
//                                                   child: Text(
//                                                     getTranslated(context,
//                                                         'home_offer_card_days'),
//                                                     textAlign: TextAlign.start,
//                                                     style: TextStyle(
//                                                         fontWeight:
//                                                             FontWeight.bold,
//                                                         fontSize: 15,
//                                                         color: Colors.black),
//                                                   )),
//                                             ),
//                                             Expanded(
//                                               flex: 50,
//                                               child: FittedBox(
//                                                 child: GFRating(
//                                                   color: Colors.amber,
//                                                   borderColor: Colors.amber,
//                                                   allowHalfRating: true,
//                                                   value: 3.5,
//                                                 ),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//
//                                       Padding(
//                                         padding: const EdgeInsets.all(8.0),
//                                         child: Text(
//                                           getTranslated(context,
//                                                   'home_offer_card_price') +
//                                               ' 220\$',
//                                           textAlign: TextAlign.start,
//                                           style: TextStyle(
//                                               fontWeight: FontWeight.bold,
//                                               fontSize: 15,
//                                               color: Colors.black),
//                                           softWrap: true,
//                                         ),
//                                       ),
//
//                                       Padding(
//                                         padding: const EdgeInsets.symmetric(
//                                             horizontal: 8.0),
//                                         child: Text(
//                                           getTranslated(context,
//                                               'home_offer_card_details'),
//                                           textAlign: TextAlign.start,
//                                           style: TextStyle(
//                                             fontSize: 11,
//                                             color: Colors.brown,
//                                           ),
//                                           softWrap: true,
//                                         ),
//                                       ),
//
//                                       Padding(
//                                         padding: const EdgeInsets.all(0.0),
//                                         child: Container(
//                                           padding: const EdgeInsets.all(5.0),
//                                           color: Color(0xff07898B),
//                                           height: screenHeight * 0.11,
//                                           child: Row(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.stretch,
//                                             children: <Widget>[
//                                               Expanded(
//                                                 flex: 25,
//                                                 child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.all(2.0),
//                                                   child: Column(
//                                                     children: <Widget>[
//                                                       Icon(
//                                                         MyIcons.bed,
//                                                         color: Colors.white,
//                                                       ),
//                                                       Container(
//                                                         margin: const EdgeInsets
//                                                             .only(top: 6.0),
//                                                         child: FittedBox(
//                                                           child: Text(
//                                                             getTranslated(
//                                                                 context,
//                                                                 'home_offer_card_rate'),
//                                                             textAlign: TextAlign
//                                                                 .center,
//                                                             style: TextStyle(
//                                                               fontSize: 12,
//                                                               color:
//                                                                   Colors.white,
//                                                             ),
//                                                           ),
//                                                         ),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ),
//                                               ),
//                                               Expanded(
//                                                 flex: 25,
//                                                 child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.all(2.0),
//                                                   child: Column(
//                                                     children: <Widget>[
//                                                       Icon(
//                                                         Icons
//                                                             .airplanemode_inactive,
//                                                         color: Colors.white,
//                                                       ),
//                                                       Container(
//                                                         margin: const EdgeInsets
//                                                             .only(top: 4.0),
//                                                         child: FittedBox(
//                                                           child: Text(
//                                                             getTranslated(
//                                                                 context,
//                                                                 'home_offer_card_flight'),
//                                                             textAlign: TextAlign
//                                                                 .center,
//                                                             style: TextStyle(
//                                                               fontSize: 12,
//                                                               color:
//                                                                   Colors.white,
//                                                             ),
//                                                           ),
//                                                         ),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ),
//                                               ),
//                                               Expanded(
//                                                 flex: 25,
//                                                 child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.all(2.0),
//                                                   child: Column(
//                                                     children: <Widget>[
//                                                       Image.asset(
//                                                           'assets/icons/dish.png'),
//                                                       Container(
//                                                         margin: const EdgeInsets
//                                                             .only(top: 4.0),
//                                                         child: FittedBox(
//                                                           child: Text(
//                                                             getTranslated(
//                                                                 context,
//                                                                 'home_offer_card_breakfast'),
//                                                             textAlign: TextAlign
//                                                                 .center,
//                                                             style: TextStyle(
//                                                               fontSize: 12,
//                                                               color:
//                                                                   Colors.white,
//                                                             ),
//                                                           ),
//                                                         ),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ),
//                                               ),
//                                               Expanded(
//                                                 flex: 25,
//                                                 child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.all(2.0),
//                                                   child: Column(
//                                                     children: <Widget>[
//                                                       Icon(
//                                                         Icons
//                                                             .directions_car_outlined,
//                                                         color: Colors.white,
//                                                       ),
//                                                       Container(
//                                                         margin: const EdgeInsets
//                                                             .only(top: 4.0),
//                                                         child: FittedBox(
//                                                           child: Text(
//                                                             getTranslated(
//                                                                 context,
//                                                                 'home_offer_card_transportation'),
//                                                             textAlign: TextAlign
//                                                                 .center,
//                                                             style: TextStyle(
//                                                               fontSize: 12,
//                                                               color:
//                                                                   Colors.white,
//                                                             ),
//                                                           ),
//                                                         ),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Container(
//                             width: screenWidth * 0.6,
//                             padding: const EdgeInsets.all(8.0),
//                             child: GestureDetector(
//                               onTap: () {},
//                               child: InkWell(
//                                 borderRadius: BorderRadius.circular(4.0),
//                                 onTap: () {},
//                                 child: Card(
//                                   shadowColor: Colors.white,
//                                   elevation: 0.0,
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(15),
//                                   ),
//                                   clipBehavior: Clip.antiAlias,
//                                   margin: const EdgeInsets.all(0.0),
//                                   color: Color(0xffFAFAFA),
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.stretch,
//                                     mainAxisAlignment: MainAxisAlignment.end,
//                                     children: [
//                                       Padding(
//                                         padding: const EdgeInsets.all(0),
//                                         child: Stack(
//                                           fit: StackFit.passthrough,
//                                           children: <Widget>[
//                                             Padding(
//                                               padding: const EdgeInsets.all(0),
//                                               child: ClipPath(
//                                                 clipper: ShapeBorderClipper(
//                                                   shape: RoundedRectangleBorder(
//                                                       borderRadius:
//                                                           BorderRadius.circular(
//                                                               15)),
//                                                 ),
//                                                 child: Image.asset(
//                                                   'assets/images/c4.jpg',
//                                                   fit: BoxFit.fill,
//                                                   height: screenHeight * 0.28,
//                                                 ),
//                                               ),
//                                             ),
//                                             Padding(
//                                               padding: const EdgeInsets.all(6),
//                                               child: Flex(
//                                                 direction: Axis.horizontal,
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment.end,
//                                                 children: <Widget>[
//                                                   Container(
//                                                     padding:
//                                                         const EdgeInsets.all(
//                                                             3.0),
//                                                     margin:
//                                                         const EdgeInsets.only(
//                                                             top: 20.0),
//                                                     constraints:
//                                                         BoxConstraints(),
//                                                     decoration: BoxDecoration(
//                                                       color: Colors.white,
//                                                       border: Border.all(
//                                                         color: Colors.white,
//                                                       ),
//                                                       borderRadius:
//                                                           BorderRadius.all(
//                                                         Radius.circular(10.0),
//                                                       ),
//                                                     ),
//                                                     child: Text(
//                                                       getTranslated(context,
//                                                           'home_offer_card_tag'),
//                                                       style: TextStyle(
//                                                         fontSize: 15,
//                                                         color: Colors.black,
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
// //
//                                       Padding(
//                                         padding: const EdgeInsets.all(8.0),
//                                         child: Text(
//                                           getTranslated(
//                                               context, 'home_offer_card_city'),
//                                           textAlign: TextAlign.start,
//                                           style: TextStyle(
//                                             fontSize: 18,
//                                             fontWeight: FontWeight.bold,
//                                             color: Color(0xff07898B),
//                                           ),
//                                           softWrap: true,
//                                         ),
//                                       ),
//
//                                       Container(
//                                         padding: const EdgeInsets.symmetric(
//                                             horizontal: 8.0),
//                                         child: Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.center,
//                                           children: [
//                                             Expanded(
//                                               flex: 50,
//                                               child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.only(
//                                                           top: 0.0,
//                                                           right: 0.0,
//                                                           left: 0.0,
//                                                           bottom: 0.0),
//                                                   child: Text(
//                                                     getTranslated(context,
//                                                         'home_offer_card_days'),
//                                                     textAlign: TextAlign.start,
//                                                     style: TextStyle(
//                                                         fontWeight:
//                                                             FontWeight.bold,
//                                                         fontSize: 15,
//                                                         color: Colors.black),
//                                                   )),
//                                             ),
//                                             Expanded(
//                                               flex: 50,
//                                               child: FittedBox(
//                                                 child: GFRating(
//                                                   color: Colors.amber,
//                                                   borderColor: Colors.amber,
//                                                   allowHalfRating: true,
//                                                   value: 3.5,
//                                                 ),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//
//                                       Padding(
//                                         padding: const EdgeInsets.all(8.0),
//                                         child: Text(
//                                           getTranslated(context,
//                                                   'home_offer_card_price') +
//                                               ' 220\$',
//                                           textAlign: TextAlign.start,
//                                           style: TextStyle(
//                                               fontWeight: FontWeight.bold,
//                                               fontSize: 15,
//                                               color: Colors.black),
//                                           softWrap: true,
//                                         ),
//                                       ),
//
//                                       Padding(
//                                         padding: const EdgeInsets.symmetric(
//                                             horizontal: 8.0),
//                                         child: Text(
//                                           getTranslated(context,
//                                               'home_offer_card_details'),
//                                           textAlign: TextAlign.start,
//                                           style: TextStyle(
//                                             fontSize: 11,
//                                             color: Colors.brown,
//                                           ),
//                                           softWrap: true,
//                                         ),
//                                       ),
//
//                                       Padding(
//                                         padding: const EdgeInsets.all(0.0),
//                                         child: Container(
//                                           padding: const EdgeInsets.all(5.0),
//                                           color: Color(0xff07898B),
//                                           height: screenHeight * 0.11,
//                                           child: Row(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.stretch,
//                                             children: <Widget>[
//                                               Expanded(
//                                                 flex: 25,
//                                                 child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.all(2.0),
//                                                   child: Column(
//                                                     children: <Widget>[
//                                                       Icon(
//                                                         MyIcons.bed,
//                                                         color: Colors.white,
//                                                       ),
//                                                       Container(
//                                                         margin: const EdgeInsets
//                                                             .only(top: 4.0),
//                                                         child: FittedBox(
//                                                           child: Text(
//                                                             getTranslated(
//                                                                 context,
//                                                                 'home_offer_card_rate'),
//                                                             textAlign: TextAlign
//                                                                 .center,
//                                                             style: TextStyle(
//                                                               fontSize: 12,
//                                                               color:
//                                                                   Colors.white,
//                                                             ),
//                                                           ),
//                                                         ),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ),
//                                               ),
//                                               Expanded(
//                                                 flex: 25,
//                                                 child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.all(2.0),
//                                                   child: Column(
//                                                     children: <Widget>[
//                                                       Icon(
//                                                         Icons
//                                                             .airplanemode_inactive,
//                                                         color: Colors.white,
//                                                       ),
//                                                       Container(
//                                                         margin: const EdgeInsets
//                                                             .only(top: 4.0),
//                                                         child: FittedBox(
//                                                           child: Text(
//                                                             getTranslated(
//                                                                 context,
//                                                                 'home_offer_card_flight'),
//                                                             textAlign: TextAlign
//                                                                 .center,
//                                                             style: TextStyle(
//                                                               fontSize: 12,
//                                                               color:
//                                                                   Colors.white,
//                                                             ),
//                                                           ),
//                                                         ),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ),
//                                               ),
//                                               Expanded(
//                                                 flex: 25,
//                                                 child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.all(2.0),
//                                                   child: Column(
//                                                     children: <Widget>[
//                                                       Image.asset(
//                                                           'assets/icons/dish.png'),
//                                                       Container(
//                                                         margin: const EdgeInsets
//                                                             .only(top: 4.0),
//                                                         child: FittedBox(
//                                                           child: Text(
//                                                             getTranslated(
//                                                                 context,
//                                                                 'home_offer_card_breakfast'),
//                                                             textAlign: TextAlign
//                                                                 .center,
//                                                             style: TextStyle(
//                                                               fontSize: 12,
//                                                               color:
//                                                                   Colors.white,
//                                                             ),
//                                                           ),
//                                                         ),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ),
//                                               ),
//                                               Expanded(
//                                                 flex: 25,
//                                                 child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.all(2.0),
//                                                   child: Column(
//                                                     children: <Widget>[
//                                                       Icon(
//                                                         Icons
//                                                             .directions_car_outlined,
//                                                         color: Colors.white,
//                                                       ),
//                                                       Container(
//                                                         margin: const EdgeInsets
//                                                             .only(top: 4.0),
//                                                         child: FittedBox(
//                                                           child: Text(
//                                                             getTranslated(
//                                                                 context,
//                                                                 'home_offer_card_transportation'),
//                                                             textAlign: TextAlign
//                                                                 .center,
//                                                             style: TextStyle(
//                                                               fontSize: 12,
//                                                               color:
//                                                                   Colors.white,
//                                                             ),
//                                                           ),
//                                                         ),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Container(
//                             width: screenWidth * 0.6,
//                             padding: const EdgeInsets.all(8.0),
//                             child: GestureDetector(
//                               onTap: () {},
//                               child: InkWell(
//                                 borderRadius: BorderRadius.circular(4.0),
//                                 onTap: () {},
//                                 child: Card(
//                                   shadowColor: Colors.white,
//                                   elevation: 0.0,
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(15),
//                                   ),
//                                   clipBehavior: Clip.antiAlias,
//                                   margin: const EdgeInsets.all(0.0),
//                                   color: Color(0xffFAFAFA),
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.stretch,
//                                     mainAxisAlignment: MainAxisAlignment.end,
//                                     children: [
//                                       Padding(
//                                         padding: const EdgeInsets.all(0),
//                                         child: Stack(
//                                           fit: StackFit.passthrough,
//                                           children: <Widget>[
//                                             Padding(
//                                               padding: const EdgeInsets.all(0),
//                                               child: ClipPath(
//                                                 clipper: ShapeBorderClipper(
//                                                   shape: RoundedRectangleBorder(
//                                                       borderRadius:
//                                                           BorderRadius.circular(
//                                                               15)),
//                                                 ),
//                                                 child: Image.asset(
//                                                   'assets/images/c4.jpg',
//                                                   fit: BoxFit.fill,
//                                                   height: screenHeight * 0.28,
//                                                 ),
//                                               ),
//                                             ),
//                                             Padding(
//                                               padding: const EdgeInsets.all(6),
//                                               child: Flex(
//                                                 direction: Axis.horizontal,
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment.end,
//                                                 children: <Widget>[
//                                                   Container(
//                                                     padding:
//                                                         const EdgeInsets.all(
//                                                             3.0),
//                                                     margin:
//                                                         const EdgeInsets.only(
//                                                             top: 20.0),
//                                                     constraints:
//                                                         BoxConstraints(),
//                                                     decoration: BoxDecoration(
//                                                       color: Colors.white,
//                                                       border: Border.all(
//                                                         color: Colors.white,
//                                                       ),
//                                                       borderRadius:
//                                                           BorderRadius.all(
//                                                         Radius.circular(10.0),
//                                                       ),
//                                                     ),
//                                                     child: Text(
//                                                       getTranslated(context,
//                                                           'home_offer_card_tag'),
//                                                       style: TextStyle(
//                                                         fontSize: 15,
//                                                         color: Colors.black,
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
// //
//                                       Padding(
//                                         padding: const EdgeInsets.all(8.0),
//                                         child: Text(
//                                           getTranslated(
//                                               context, 'home_offer_card_city'),
//                                           textAlign: TextAlign.start,
//                                           style: TextStyle(
//                                             fontSize: 18,
//                                             fontWeight: FontWeight.bold,
//                                             color: Color(0xff07898B),
//                                           ),
//                                           softWrap: true,
//                                         ),
//                                       ),
//
//                                       Container(
//                                         padding: const EdgeInsets.symmetric(
//                                             horizontal: 8.0),
//                                         child: Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.center,
//                                           children: [
//                                             Expanded(
//                                               flex: 50,
//                                               child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.only(
//                                                           top: 0.0,
//                                                           right: 0.0,
//                                                           left: 0.0,
//                                                           bottom: 0.0),
//                                                   child: Text(
//                                                     getTranslated(context,
//                                                         'home_offer_card_days'),
//                                                     textAlign: TextAlign.start,
//                                                     style: TextStyle(
//                                                         fontWeight:
//                                                             FontWeight.bold,
//                                                         fontSize: 15,
//                                                         color: Colors.black),
//                                                   )),
//                                             ),
//                                             Expanded(
//                                               flex: 50,
//                                               child: FittedBox(
//                                                 child: GFRating(
//                                                   color: Colors.amber,
//                                                   borderColor: Colors.amber,
//                                                   allowHalfRating: true,
//                                                   value: 3.5,
//                                                 ),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//
//                                       Padding(
//                                         padding: const EdgeInsets.all(8.0),
//                                         child: Text(
//                                           getTranslated(context,
//                                                   'home_offer_card_price') +
//                                               ' 220\$',
//                                           textAlign: TextAlign.start,
//                                           style: TextStyle(
//                                               fontWeight: FontWeight.bold,
//                                               fontSize: 15,
//                                               color: Colors.black),
//                                           softWrap: true,
//                                         ),
//                                       ),
//
//                                       Padding(
//                                         padding: const EdgeInsets.symmetric(
//                                             horizontal: 8.0),
//                                         child: Text(
//                                           getTranslated(context,
//                                               'home_offer_card_details'),
//                                           textAlign: TextAlign.start,
//                                           style: TextStyle(
//                                             fontSize: 11,
//                                             color: Colors.brown,
//                                           ),
//                                           softWrap: true,
//                                         ),
//                                       ),
//
//                                       Padding(
//                                         padding: const EdgeInsets.all(0.0),
//                                         child: Container(
//                                           padding: const EdgeInsets.all(5.0),
//                                           color: Color(0xff07898B),
//                                           height: screenHeight * 0.11,
//                                           child: Row(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.stretch,
//                                             children: <Widget>[
//                                               Expanded(
//                                                 flex: 25,
//                                                 child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.all(2.0),
//                                                   child: Column(
//                                                     children: <Widget>[
//                                                       Icon(
//                                                         MyIcons.bed,
//                                                         color: Colors.white,
//                                                       ),
//                                                       Container(
//                                                         margin: const EdgeInsets
//                                                             .only(top: 4.0),
//                                                         child: FittedBox(
//                                                           child: Text(
//                                                             getTranslated(
//                                                                 context,
//                                                                 'home_offer_card_rate'),
//                                                             textAlign: TextAlign
//                                                                 .center,
//                                                             style: TextStyle(
//                                                               fontSize: 12,
//                                                               color:
//                                                                   Colors.white,
//                                                             ),
//                                                           ),
//                                                         ),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ),
//                                               ),
//                                               Expanded(
//                                                 flex: 25,
//                                                 child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.all(2.0),
//                                                   child: Column(
//                                                     children: <Widget>[
//                                                       Icon(
//                                                         Icons
//                                                             .airplanemode_inactive,
//                                                         color: Colors.white,
//                                                       ),
//                                                       Container(
//                                                         margin: const EdgeInsets
//                                                             .only(top: 4.0),
//                                                         child: FittedBox(
//                                                           child: Text(
//                                                             getTranslated(
//                                                                 context,
//                                                                 'home_offer_card_flight'),
//                                                             textAlign: TextAlign
//                                                                 .center,
//                                                             style: TextStyle(
//                                                               fontSize: 12,
//                                                               color:
//                                                                   Colors.white,
//                                                             ),
//                                                           ),
//                                                         ),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ),
//                                               ),
//                                               Expanded(
//                                                 flex: 25,
//                                                 child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.all(2.0),
//                                                   child: Column(
//                                                     children: <Widget>[
//                                                       Image.asset(
//                                                           'assets/icons/dish.png'),
//                                                       Container(
//                                                         margin: const EdgeInsets
//                                                             .only(top: 4.0),
//                                                         child: FittedBox(
//                                                           child: Text(
//                                                             getTranslated(
//                                                                 context,
//                                                                 'home_offer_card_breakfast'),
//                                                             textAlign: TextAlign
//                                                                 .center,
//                                                             style: TextStyle(
//                                                               fontSize: 12,
//                                                               color:
//                                                                   Colors.white,
//                                                             ),
//                                                           ),
//                                                         ),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ),
//                                               ),
//                                               Expanded(
//                                                 flex: 25,
//                                                 child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.all(2.0),
//                                                   child: Column(
//                                                     children: <Widget>[
//                                                       Icon(
//                                                         Icons
//                                                             .directions_car_outlined,
//                                                         color: Colors.white,
//                                                       ),
//                                                       Container(
//                                                         margin: const EdgeInsets
//                                                             .only(top: 4.0),
//                                                         child: FittedBox(
//                                                           child: Text(
//                                                             getTranslated(
//                                                                 context,
//                                                                 'home_offer_card_transportation'),
//                                                             textAlign: TextAlign
//                                                                 .center,
//                                                             style: TextStyle(
//                                                               fontSize: 12,
//                                                               color:
//                                                                   Colors.white,
//                                                             ),
//                                                           ),
//                                                         ),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   )
                ],
              ),
            ),
    );
  }
}
