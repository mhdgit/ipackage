import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:ipackage/localization/localizationValues.dart';


class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

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
                height: screenHeight * 0.25,
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  children: [
                    Expanded(
                      flex:30,
                      child: FittedBox(
                        child: CircleAvatar(
                          radius: 30,
                          backgroundImage:
                          AssetImage('assets/images/profile.jpg',),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 70,
                      child: FittedBox(
                        alignment: AlignmentDirectional.centerEnd,
                        fit: BoxFit.scaleDown,
                        child: IconButton(
                          icon: Icon(Icons.edit , color: Color(0xff07898B),),
                          onPressed: (){},
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
                        getTranslated(context, 'create_membership_ID'),
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
                      hintText: getTranslated(context, 'create_membership_ID'),
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
                        getTranslated(context, 'create_membership_country'),
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
                      hintText: getTranslated(context, 'create_membership_country'),
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
                        getTranslated(context, 'create_membership_age'),
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
                      hintText: getTranslated(context, 'create_membership_age'),
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
                        getTranslated(context, 'create_membership_pass'),
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
                      hintText: getTranslated(context, 'create_membership_pass'),
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
                        getTranslated(context, 'create_membership_pass_conf'),
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
                      hintText: getTranslated(context, 'create_membership_pass_conf'),
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
                        getTranslated(context, 'create_membership_services'),
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
                      hintText: getTranslated(context, 'create_membership_services'),
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
                        getTranslated(context, 'create_membership_biography'),
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
                  minLines: 6,
                  maxLines: 6,
                  keyboardType: TextInputType.text,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.start,
                  decoration: InputDecoration(
                      hintText: getTranslated(context, 'create_membership_biography'),
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
                    text: getTranslated(context, 'settings_save_btn'),
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

            ],
          ),
        ),
      ),
    );
  }
}
