import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:ipackage/localization/localizationValues.dart';

class EditBook extends StatefulWidget {

  @override
  _NewMembership createState() => _NewMembership();
}

class _NewMembership extends State<EditBook> {

  int _currentWidget = 0;

  _stage0(){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
      child: GFButton(
        color: Color(0xff07898b),
        textColor: Colors.white,
        fullWidthButton: true,
        text: getTranslated(context, 'settings_save_btn'),
        size: 50.0,
        textStyle: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
        onPressed: () {

        },
      ),
    );
  }
  _stage1(){
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: <Widget>[
          Expanded(flex: 50,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: GFButton(
                  color: Color(0xff07898b),
                  textColor: Colors.white,
                  fullWidthButton: true,
                  text: getTranslated(context, 'edit_book_delete'),
                  size: 50.0,
                  textStyle: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                  onPressed: () {

                  },
                ),
              ),),
          Expanded(flex: 50,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: GFButton(
                  color: Color(0xff07898b),
                  textColor: Colors.white,
                  fullWidthButton: true,
                  text: getTranslated(context, 'edit_book_cancel'),
                  size: 50.0,
                  textStyle: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                  onPressed: () {

                  },
                ),
              ),),
        ],
      ),
    );
  }

  _formRouter(){
    switch(_currentWidget)
    {
      case 0: return _stage0();break;
      case 1: return _stage1();break;
    }
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

        body: Container(
            child: SingleChildScrollView(
                child: Column(
                    children: <Widget>[

                      Container(
                        width: screenWidth * 0.9,
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Row(
                          children: [
                            Expanded(
                              flex:60,
                              child: Container(
                                padding: EdgeInsetsDirectional.only(
                                    start: 10.0, top: 0.0, bottom: 0.0),
                                child: Text(
                                  getTranslated(context, 'fo_details'),
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex:40,
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    flex:50,
                                    child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: TextButton(
                                        style: TextButton.styleFrom(
                                          backgroundColor: _currentWidget == 0 ? Color(0xff07898b) : Colors.white,
                                          side: BorderSide(color: Color(0xff07898b), width: 1),
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _currentWidget = 0;
                                          });
                                        },
                                        child: Text(
                                          getTranslated(context, 'fo_edit'),
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: _currentWidget == 0 ? Colors.white : Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex:50,
                                    child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: TextButton(
                                        style: TextButton.styleFrom(
                                          backgroundColor: _currentWidget == 1 ? Color(0xff07898b) : Colors.white,
                                          side: BorderSide(color: Color(0xff07898b), width: 1),
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _currentWidget = 1;
                                          });
                                        },
                                        child: Text(
                                          getTranslated(context, 'favorites_alert_del_btn'),
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: _currentWidget == 1 ? Colors.white : Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                                ],
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
                                getTranslated(context, 'confirm_book_package'),
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
                              hintText: getTranslated(context, 'confirm_book_package'),
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

                      _formRouter(),
                    ]
                )
            )
        )
    );
  }
}
