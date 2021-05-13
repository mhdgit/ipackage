import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:ipackage/localization/localizationValues.dart';
import 'package:ipackage/modules/LocalAssistant.dart';
import 'package:ipackage/modules/Offer/Offer.dart';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../modules/my_icons.dart';

class ConfirmBook extends StatefulWidget {

  final Offer offer;
  final int offerId;

  ConfirmBook({this.offer , this.offerId});

  @override
  _ConfirmBookState createState() => _ConfirmBookState();
}

class _ConfirmBookState extends State<ConfirmBook> {

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passengersController = TextEditingController();
  final dateController = TextEditingController();
  SharedPreferences prefs;

  LocalAssistant localAssistant = new LocalAssistant();
  bool _isBtnLoading = false;
  int _adultsNumber = 2;
  int _childrenNumber = 0;
  int _babiesNumber = 0;
  String _originCode = ' ';
  String _apiToken = ' ';
  bool _isFlight = false;

  Future _loadUserPreferences() async {
    final key = 'source_airport_code';
    final value = prefs.getString(key);
    if (value != null)
      setState(() {
        _originCode = value;
      });

    final key3 = 'departure_date';
    final value3 = prefs.getString(key3);
    if (value3 != null)
      setState(() {
        dateController.text = value3;
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

    final key8 = 'babies_number';
    final value8 = prefs.getInt(key8);
    if (value8 != null)
      setState(() {
        _babiesNumber = value5;
      });

    final key7 = 'is_flight';
    final value7 = prefs.getBool(key7);
    if (value7 != null)
      setState(() {
        _isFlight = value7;
      });

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SharedPreferences.getInstance().then((value) {
        prefs = value;

        _loadUserPreferences().then((value) {
          setState(() {
            passengersController.text = (_adultsNumber + _childrenNumber + _babiesNumber).toString();
          });
        });
    });
  }

  Future _launchStoreURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _handleConfirmation() async {
    setState(() {
      _isBtnLoading = true;
    });

    if (nameController.text == "" || nameController.text == null) {
      _showAlert(context, getTranslated(context, 'Wrong_data'),
          getTranslated(context, 'Please enter the name'));
      setState(() {
        _isBtnLoading = false;
      });
      return;
    } else if (emailController.text == "" || emailController.text == null) {
      _showAlert(context, getTranslated(context, 'Wrong_data'),
          getTranslated(context, 'Please enter an email'));
      setState(() {
        _isBtnLoading = false;
      });
      return;
    } else if (phoneController.text == "" || phoneController.text == null) {
      _showAlert(context, getTranslated(context, 'Wrong_data'),
          getTranslated(context, 'Please enter the phone number'));
      setState(() {
        _isBtnLoading = false;
      });
      return;
    } else if (passengersController.text == "" || passengersController.text == null) {
      _showAlert(context, getTranslated(context, 'Wrong_data'),
          getTranslated(context, 'confirm_book_passenger_note'));
      setState(() {
        _isBtnLoading = false;
      });
      return;
    } else if (dateController.text == "" || dateController.text == null) {
      _showAlert(context, getTranslated(context, 'Wrong_data'),
          getTranslated(context, 'confirm_book_date_note'));
      setState(() {
        _isBtnLoading = false;
      });
      return;
    } else {

      setState(() {
        _apiToken = prefs.getString('api_token');
      });

      Uri uri = Uri.parse('https://ipackagetours.com/api/booking');
      var body;
      if(_isFlight)
        body = {
          'offer_data': widget.offer.toJson(),
          'offer_id': widget.offerId,
          'date': dateController.text,
          'infant': _babiesNumber,
          'children': _childrenNumber,
          'adults': _adultsNumber,
          'flights': 1,
          'ariport': _originCode,
          'flights_back_code': widget.offer.airportBack.iata.toString(),
        };
      else
        body = {
          'offer_data': widget.offer.toJson(),
          'offer_id': widget.offerId,
          'date': dateController.text,
          'infant': _babiesNumber,
          'children': _childrenNumber,
          'adults': _adultsNumber,
        };

      final response = await http.post(uri,
          body: json.encode(body),
          headers: {"Accept": "application/json",
            "Content-Type": "application/json",
            "Authorization": "Bearer " + _apiToken.toString(),
          },
          encoding: Encoding.getByName("utf-8"),
      );

      print(response.body.toString());
      // var status = response.body.contains('error');
      var data = json.decode(response.body);

      if (data['status'] == false) {
        print('Booking operation failed!');

        _showAlert(
            context,
            getTranslated(context, 'Wrong_data'),
            getTranslated(
                context, 'The email is already used in another account'));
        setState(() {
          _isBtnLoading = false;
        });
      } else {
        setState(() {
          _isBtnLoading = false;
        });

        print('Booking operation has been confirmed');
        _launchStoreURL('https://ipackagetours.com/payment/form?booking_id='+data['booking_id'].toString());
        print('Launch booking url...');

        // Navigator.of(context).push(
        //   new MaterialPageRoute(
        //       builder: (BuildContext context) => new TouristServices()),
        // );
      }
    }
  }

  _showAlert(context, String text, String des) {
    Alert(
      context: context,
      type: AlertType.warning,
      title: text,
      desc: des,
      alertAnimation: fadeAlertAnimation,
      buttons: [
        DialogButton(
          child: Text(
            "OK",
            style: TextStyle(
                color: Colors.white, fontFamily: 'Cairo', fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          color: Color(0xff07898b),
          radius: BorderRadius.circular(3.0),
        ),
      ],
    ).show();
  }

  Widget fadeAlertAnimation(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
      ) {
    return Align(
      child: FadeTransition(
        opacity: animation,
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final double screenHeight =
        MediaQuery.of(context).size.height - statusBarHeight - kToolbarHeight;
    final double screenWidth = MediaQuery.of(context).size.width;


    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Color(0xffE9F7F8),
        elevation: 0.0,
        shadowColor: Colors.white,
        // title: Text(
        //   getTranslated(context, 'change_hotel'),
        // ),
        // centerTitle: true,
      ),

      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              Container(
                width: screenWidth * 0.9,
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsetsDirectional.only(
                          start: 10.0, top: 0.0, bottom: 0.0),
                      child: Text(
                        getTranslated(context, 'confirm_book_label'),
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
              Container(
                width: screenWidth * 0.9,
                padding: EdgeInsetsDirectional.only(
                    start: 10.0, top: 10.0, bottom: 10.0),
                child: Row(
                  children: [
                    Flexible(
                      child: Text(
                        getTranslated(context, 'confirm_book_label_2'),
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: screenWidth * 0.9,
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsetsDirectional.only(
                          start: 10.0, top: 0.0, bottom: 0.0),
                      child: Text(
                        getTranslated(context, 'confirm_book_label_3'),
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

              Container(
                width: screenWidth * 0.9,
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsetsDirectional.only(
                          start: 10.0, top: 0.0, bottom: 0.0),
                      child: Text(
                        getTranslated(context, 'create_membership_name'),
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
              Container(
                width: screenWidth * 0.9,
                child: TextField(
                  controller: nameController,
                  keyboardType: TextInputType.text,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.start,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(5.0),
                      hintText: getTranslated(context, 'create_membership_name'),
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

              Container(
                width: screenWidth * 0.9,
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsetsDirectional.only(
                          start: 10.0, top: 0.0, bottom: 0.0),
                      child: Text(
                        getTranslated(context, 'create_membership_email'),
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
              Container(
                width: screenWidth * 0.9,
                child: TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.start,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(5.0),
                      hintText: getTranslated(context, 'create_membership_email'),
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

              Container(
                width: screenWidth * 0.9,
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsetsDirectional.only(
                          start: 10.0, top: 0.0, bottom: 0.0),
                      child: Text(
                        getTranslated(context, 'confirm_book_phone'),
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
              Container(
                width: screenWidth * 0.9,
                child: TextField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.start,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(5.0),
                      hintText: getTranslated(context, 'confirm_book_phone'),
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

              Container(
                width: screenWidth * 0.9,
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsetsDirectional.only(
                          start: 10.0, top: 0.0, bottom: 0.0),
                      child: Text(
                        getTranslated(context, 'confirm_book_members'),
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
              Container(
                width: screenWidth * 0.9,
                child: TextField(
                  controller: passengersController,
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.start,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(5.0),
                      hintText: getTranslated(context, 'confirm_book_members'),
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

              Container(
                width: screenWidth * 0.9,
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsetsDirectional.only(
                          start: 10.0, top: 0.0, bottom: 0.0),
                      child: Text(
                        getTranslated(context, 'confirm_book_travel_date'),
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
              Container(
                width: screenWidth * 0.9,
                child: TextField(
                  controller: dateController,
                  keyboardType: TextInputType.text,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.start,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(5.0),
                      hintText: getTranslated(context, 'confirm_book_travel_date'),
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

              Container(
                width: screenWidth * 0.9,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: GFButton(
                    color: Color(0xff07898b),
                    textColor: Colors.white,
                    fullWidthButton: true,
                    child: _isBtnLoading
                        ? Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        )
                    )
                        : Text(
                      getTranslated(context, 'confirm_book_btn_1'),
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'cairo',
                      ),
                    ),
                    size: 50.0,
                    onPressed: _handleConfirmation,
                  ),
                ),
              ),

              // Text(
              //   getTranslated(context, 'confirm_book_label_4'),
              //   textAlign: TextAlign.start,
              //   style: TextStyle(
              //     fontSize: 20,
              //     fontWeight: FontWeight.bold,
              //     color: Colors.black,
              //   ),
              // ),
              //
              // Container(
              //   width: screenWidth * 0.9,
              //   padding:
              //   EdgeInsets.only(top: 10.0, right: 0.0, left: 0.0, bottom: 30.0),
              //   child: TextButton(
              //     style: TextButton.styleFrom(
              //       backgroundColor: Colors.white,
              //       side: BorderSide(color: Color(0xff07898b), width: 2),
              //     ),
              //     onPressed: () {
              //     },
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: <Widget>[
              //         Icon(
              //           MyIcons.whatsapp,
              //           color: Color(0xff1AEA4A),
              //         ),
              //
              //         Text(
              //           getTranslated(context, 'confirm_book_btn_2'),
              //           style: TextStyle(
              //               fontSize: 16,
              //               color: Colors.black
              //           ),
              //         ),
              //
              //       ],
              //     ),
              //   ),
              // ),

            ],
          ),
        ),
      ),
    );
  }
}
