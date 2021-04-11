import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:ipackage/localization/localizationValues.dart';
import 'package:ipackage/widgets/chats/chats.dart';
import 'package:ipackage/widgets/notifications.dart';

class AmbassadorAddService extends StatefulWidget {
  @override
  _AmbassadorAddServiceState createState() => _AmbassadorAddServiceState();
}

class _AmbassadorAddServiceState extends State<AmbassadorAddService> {

  final TextEditingController _nameController = new TextEditingController();
  final TextEditingController _budgetController = new TextEditingController();
  final TextEditingController _detailsController = new TextEditingController();
  final TextEditingController _termController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final double screenHeight =
        MediaQuery.of(context).size.height - statusBarHeight - kToolbarHeight;
    final double screenWidth = MediaQuery.of(context).size.width;


    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xff77BEC0),
        elevation: 0.0,
        shadowColor: Colors.white,
        actions: [
          IconButton(icon: Icon(Icons.mail_outline , color: Colors.black,), onPressed: (){
            Navigator.of(context).push(new MaterialPageRoute(
                builder: (BuildContext context) => new Chats()));
          }),
          IconButton(icon: Icon(Icons.notifications_outlined , color: Colors.black,), onPressed: (){
            Navigator.of(context).push(new MaterialPageRoute(
                builder: (BuildContext context) => new Notifications()));
          }),
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: CircleAvatar(
              radius: 30,
              backgroundImage:
              AssetImage('assets/images/profile.jpg'),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            Container(
              width: screenWidth,
              color: Color(0xffE9F7F8),
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: InkWell(
                onTap: (){
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (BuildContext context) => new AmbassadorAddService()));
                },
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 10,
                      child: Icon(
                        Icons.add_circle_outline,
                        color: Colors.black,
                      ),
                    ),
                    Expanded(
                      flex: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          getTranslated(context, 'ambassador_profile_add_btn'),
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 50,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          ' ',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
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
                      getTranslated(context, 'ambassador_add_service_title'),
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
                controller: _nameController,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
                textAlign: TextAlign.start,
                decoration: InputDecoration(
                    hintText: getTranslated(context, 'ambassador_add_service_title'),
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
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsetsDirectional.only(
                        start: screenWidth * 0.1, top: 0.0, bottom: 0.0),
                    child: Text(
                      getTranslated(context, 'ambassador_add_service_title_2'),
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 13,
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
                      getTranslated(context, 'ambassador_add_service_details'),
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
                controller: _detailsController,
                maxLines: 5,
                minLines: 5,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
                textAlign: TextAlign.start,
                decoration: InputDecoration(
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
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsetsDirectional.only(
                        start: screenWidth * 0.1, top: 0.0, bottom: 0.0),
                    child: Text(
                      getTranslated(context, 'ambassador_add_service_details_2'),
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 13,
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
                      getTranslated(context, 'ambassador_add_service_images'),
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
              color: Color(0xffDFDFDF),
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.only(
                        top: 10.0, bottom: 10.0),
                    child: GFButton(
                      onPressed: (){},
                      color: Color(0xff3ABE59),
                      child: Container(
                        width: screenWidth * 0.5,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.image_outlined, color: Colors.white,),
                            Text(
                              getTranslated(context, 'ambassador_add_service_images_2'),
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                    child: Row(
                      children: [
                        Flexible(child: Text(
                          getTranslated(context, 'ambassador_add_service_images_3'),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.black38,
                          ),
                        ),)
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                    child: Row(
                      children: [
                        Flexible(child: Text(
                          getTranslated(context, 'ambassador_add_service_images_4'),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.black38,
                          ),
                        ),)
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
                      getTranslated(context, 'ambassador_add_service_budget'),
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
                controller: _budgetController,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
                textAlign: TextAlign.start,
                decoration: InputDecoration(
                    hintText: getTranslated(context, 'ambassador_add_service_budget'),
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
                      getTranslated(context, 'ambassador_add_service_period'),
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
              padding: EdgeInsets.only(bottom: 20.0),
              child: TextField(
                keyboardType: TextInputType.text,
                controller: _termController,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
                textAlign: TextAlign.start,
                decoration: InputDecoration(
                    hintText: getTranslated(context, 'ambassador_add_service_period'),
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

          ],
        ),
      ),
    );
  }
}
