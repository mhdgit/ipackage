import 'package:flutter/material.dart';
import 'package:getwidget/components/rating/gf_rating.dart';
import 'package:getwidget/getwidget.dart';
import 'package:ipackage/localization/localizationValues.dart';
import 'package:ipackage/widgets/chats/chats.dart';
import 'package:ipackage/widgets/notifications.dart';
import 'package:responsive_grid/responsive_grid.dart';

class TouristServiceMain extends StatefulWidget {
  @override
  _TouristServiceMainState createState() => _TouristServiceMainState();
}

class _TouristServiceMainState extends State<TouristServiceMain> {

  final TextEditingController _detailsController = new TextEditingController();

  List<String> _offers = [
    "لقد كانت رحلة رائعة لقد كانت رحلة رائعة لقد كانت رحلة رائعة",
    "لقد كانت رحلة رائعة",
  ];

  List<String> _requirements = [
    "معرفة الأماكن",
    "معرفة الأماكن",
    "معرفة الأماكن",
    "معرفة الأماكن",
  ];

  _offersWidget(width, height) {
    return Column(
      children: <Widget>[
        for (int i = 0; i < _offers.length; i++)
          Container(
              width: width * 0.9,
              padding: EdgeInsetsDirectional.only(
                  top: 10.0, bottom: 10.0),
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
                                    alignment: AlignmentDirectional.centerStart,
                                    fit: BoxFit.scaleDown,
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
                  subtitle: Text(_offers[i].toString()),
                ),
              )),
      ],
    );
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
        backgroundColor: Color(0xff77BEC0),
        elevation: 0.0,
        shadowColor: Colors.white,
        title: Text(
          getTranslated(context, 'tourist_services_username'),
        ),
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
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: InkWell(
                onTap: (){
                },
                child: Row(
                  children: <Widget>[
                    Flexible(
                      child: Padding(
                        padding: EdgeInsetsDirectional.only(start: screenWidth * 0.08),
                        child: Text(
                          getTranslated(context, 'tourist_service_main_title'),
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 20,
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
              height: screenHeight * 0.1,
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 50,
                    child: GFButton(
                      onPressed: (){},
                      color: Color(0xff07898B),
                      text: getTranslated(context, 'tourist_service_main_btn'),
                      textColor: Colors.white,
                      textStyle: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 50,
                    child: FittedBox(
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
                  ),
                ],
              ),
            ),
            Container(
              width: screenWidth * 0.9,
              margin: EdgeInsetsDirectional.only(
                  top: 5.0, bottom: 5.0),
              child: Card(
                elevation: 2.0,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: screenWidth * 0.84,
                          padding: EdgeInsetsDirectional.only(
                              start: screenWidth * 0.08, top: 10.0, bottom: 0.0),
                          child: Text(
                            getTranslated(context, 'tourist_service_main_card'),
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

                    Container(
                      width: screenWidth * 0.9,
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Divider(
                        color: Colors.black,
                        thickness: 1,
                      ),
                    ),

                    Row(
                      children: [
                        Container(
                          width: screenWidth * 0.84,
                          padding: EdgeInsetsDirectional.only(
                              start: screenWidth * 0.08, top: 5.0, bottom: 5.0),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 50,
                                child: Text(
                                  getTranslated(context, 'tourist_service_main_budget'),
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 50,
                                child: Text(
                                  '100\$ - 500\$',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black38,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: screenWidth * 0.84,
                          padding: EdgeInsetsDirectional.only(
                              start: screenWidth * 0.08, top: 5.0, bottom: 5.0),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 50,
                                child: Text(
                                  getTranslated(context, 'tourist_service_main_term'),
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 50,
                                child: Text(
                                  '5' + getTranslated(context, 'book_trip_days_2'),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black38,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: screenWidth * 0.84,
                          padding: EdgeInsetsDirectional.only(
                              start: screenWidth * 0.08, top: 5.0, bottom: 5.0),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 50,
                                child: Text(
                                  getTranslated(context, 'tourist_service_main_offers_average'),
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 50,
                                child: Text(
                                  '400\$',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black38,
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
            Row(
              children: [
                Container(
                  width: screenWidth * 0.9,
                  padding: EdgeInsetsDirectional.only(
                      start: screenWidth * 0.08, top: 5.0, bottom: 5.0),
                  child: Row(
                    children: [
                      Text(
                        getTranslated(context, 'tourist_service_main_details'),
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              width: screenWidth * 0.9,
              child: Card(
                elevation:2.0,
                child: Padding(
                  padding: EdgeInsetsDirectional.only( top: 15.0, bottom: 15.0, start: 15.0, end: 15.0),
                  child: Row(
                    children: [
                      Flexible(
                        child: Text(
                          getTranslated(context, 'tourist_service_main_details_2'),
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black38,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Container(
                  width: screenWidth * 0.9,
                  padding: EdgeInsetsDirectional.only(
                      start: screenWidth * 0.08, top: 20.0, bottom: 5.0),
                  child: Row(
                    children: [
                      Text(
                        getTranslated(context, 'tourist_service_main_requirements'),
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              width: screenWidth * 0.9,
              child: Column(
                children: <Widget>[
                  ResponsiveGridRow(
                    children: [
                      for (var i = 0; i < _requirements.length; i++)
                        ResponsiveGridCol(
                          xs: 6,
                          md: 6,
                          child: Container(
                              margin: const EdgeInsets.all(5.0),
                              padding: const EdgeInsets.all(0.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              alignment: Alignment(0, 0),
                              //color: Colors.grey,
                              child: InkWell(
                                onTap: () {
                                },
                                child: Card(
                                  margin: const EdgeInsets.all(0),
                                  // shape: RoundedRectangleBorder(
                                  //   borderRadius: BorderRadius.circular(7),
                                  // ),
                                  clipBehavior: Clip.antiAlias,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.07),
                                    child: Text(
                                      _requirements[i].toString(),
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black38,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
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

            Container(
              width: screenWidth * 0.9,
              margin: EdgeInsetsDirectional.only(top: 20.0, bottom: 5.0),
              child: Card(
                elevation: 2.0,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: screenWidth * 0.84,
                          padding: EdgeInsetsDirectional.only(
                              start: screenWidth * 0.06, top: 10.0, bottom: 5.0),
                          child: Text(
                            getTranslated(context, 'tourist_service_main_add_offer'),
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
                    Row(
                      children: [
                        Container(
                          width: screenWidth * 0.84,
                          padding: EdgeInsetsDirectional.only(
                              start: screenWidth * 0.06, top: 5.0, bottom: 10.0),
                          child: Text(
                            getTranslated(context, 'tourist_service_main_offer_details'),
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
                    Container(
                      width: screenWidth * 0.84,
                      child: TextField(
                        keyboardType: TextInputType.text,
                        minLines: 6,
                        maxLines: 6,
                        controller: _detailsController,
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
                      height: screenHeight * 0.1,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 60,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GFButton(
                                onPressed: (){},
                                color: Color(0xff07898B),
                                text: getTranslated(context, 'tourist_service_main_btn'),
                                textColor: Colors.white,
                                textStyle: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 40,
                            child: FittedBox(
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
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
              ),
            ),

            Row(
              children: [
                Container(
                  width: screenWidth * 0.9,
                  padding: EdgeInsetsDirectional.only(
                      start: screenWidth * 0.08, top: 20.0, bottom: 5.0),
                  child: Row(
                    children: [
                      Text(
                        getTranslated(context, 'tourist_service_main_offers'),
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            _offersWidget(screenWidth, screenHeight),

          ],
        ),
      ),
    );
  }
}
