import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:ipackage/localization/localizationValues.dart';

import '../modules/my_icons.dart';

class ConfirmBook extends StatefulWidget {
  @override
  _ConfirmBookState createState() => _ConfirmBookState();
}

class _ConfirmBookState extends State<ConfirmBook> {

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
                  keyboardType: TextInputType.text,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.start,
                  decoration: InputDecoration(
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
                  keyboardType: TextInputType.text,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.start,
                  decoration: InputDecoration(
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
                  keyboardType: TextInputType.text,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.start,
                  decoration: InputDecoration(
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
                  keyboardType: TextInputType.text,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.start,
                  decoration: InputDecoration(
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
                  keyboardType: TextInputType.text,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.start,
                  decoration: InputDecoration(
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
                    text: getTranslated(context, 'confirm_book_btn_1'),
                    size: 50.0,
                    textStyle: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                    onPressed: () {

                    },
                  ),
                ),
              ),

              Text(
                getTranslated(context, 'confirm_book_label_4'),
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),

              Container(
                width: screenWidth * 0.9,
                padding:
                EdgeInsets.only(top: 10.0, right: 0.0, left: 0.0, bottom: 30.0),
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                    side: BorderSide(color: Color(0xff07898b), width: 2),
                  ),
                  onPressed: () {
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        MyIcons.whatsapp,
                        color: Color(0xff1AEA4A),
                      ),

                      Text(
                        getTranslated(context, 'confirm_book_btn_2'),
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black
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
    );
  }
}
