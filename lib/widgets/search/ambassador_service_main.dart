import 'package:flutter/material.dart';
import 'package:getwidget/components/rating/gf_rating.dart';
import 'package:getwidget/getwidget.dart';
import 'package:image_viewer/image_viewer.dart';
import 'package:ipackage/localization/localizationValues.dart';
import 'package:ipackage/widgets/search/ambassador_profile.dart';

class AmbassadorServiceMain extends StatefulWidget {
  @override
  _AmbassadorServiceMainState createState() => _AmbassadorServiceMainState();
}

class _AmbassadorServiceMainState extends State<AmbassadorServiceMain> {

  int carouselIndex;

  List<String> _imageList = [
    'assets/images/c4.jpg',
    'assets/images/c3.jpg',
    'assets/images/c1.jpg',
    'assets/images/c1.jpg',
    'assets/images/c3.jpg',
    'assets/images/c4.jpg',
  ];


  List<String> _comments = [
    "لقد كانت رحلة رائعة لقد كانت رحلة رائعة لقد كانت رحلة رائعة",
    "لقد كانت رحلة رائعة",
  ];

  _commentsWidget(width, height) {
    return Column(
      children: <Widget>[
        for (int i = 0; i < _comments.length; i++)
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
                  subtitle: Text(_comments[i].toString()),
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
          getTranslated(context, 'as_agent_name'),
        ),
        actions: [
          IconButton(icon: Icon(Icons.mail_outline , color: Colors.black,), onPressed: (){}),
          IconButton(icon: Icon(Icons.notifications_outlined , color: Colors.black,), onPressed: (){}),
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

            GFCarousel(
              enlargeMainPage: true,
              viewportFraction: 1.0,
              autoPlay: true,
              pagination: true,
              activeIndicator: Color(0xff07898B),
              items: _imageList.map(
                    (url) {
                  return Container(
                    margin: EdgeInsets.only(top: 20.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      child: InkWell(
                        onTap: () {
                          ImageViewer.showImageSlider(
                            images: _imageList,
                            startingPosition: carouselIndex,
                          );
                        },
                        child: Image.asset(url,
                            fit: BoxFit.cover, width: screenWidth * 0.9),
                      ),
                    ),
                  );
                },
              ).toList(),
              onPageChanged: (index) {
                setState(() {
                  carouselIndex = index;
                });
              },
            ),
            Container(
              width: screenWidth * 0.9,
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 40,
                    child: FittedBox(
                      alignment: AlignmentDirectional.centerStart,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: InkWell(
                          onTap: (){
                            Navigator.of(context).push(new MaterialPageRoute(
                                builder: (BuildContext context) => new AmbassadorProfile()));
                          },
                          child: Text(
                            getTranslated(context, 'as_agent_name'),
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 18,
                              color: Color(0xff07898B),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 10,
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

                  Expanded(
                      flex: 50,
                      child: GFButton(
                        color: Color(0xff07898B),
                        textColor: Colors.white,
                        text: getTranslated(context, 'ambassador_profile_btn'),
                        textStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                        onPressed: (){},
                      )
                  ),
                ],
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
                      Expanded(
                        flex: 10,
                        child: Icon(
                          Icons.location_on_outlined,
                          color: Colors.black,
                        ),
                      ),
                      Expanded(
                        flex: 80,
                        child: Text(
                          getTranslated(context, 'hotel_details_location'),
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
              ],
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
                          child: Row(
                            children: [
                              Flexible(
                                child: Text(
                                  getTranslated(context, 'ambassador_profile_service'),
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

                    Container(
                      width: screenWidth * 0.9,
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Divider(
                        color: Colors.black,
                        thickness: 2,
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
                                flex: 35,
                                child: Text(
                                  getTranslated(context, 'ambassador_profile_rating'),
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 35,
                                child: FittedBox(
                                  child: GFRating(
                                    color: Colors.amber,
                                    borderColor: Colors.amber,
                                    allowHalfRating: true,
                                    value: 5,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 30,
                                child: Text(
                                  ' ',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
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
                                flex: 40,
                                child: Text(
                                  getTranslated(context, 'ambassador_profile_response'),
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 40,
                                child: Text(
                                  '5' + getTranslated(context, 'ambassador_profile_hours'),
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
                        getTranslated(context, 'ambassador_profile_service_info'),
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
            for(int index = 0 ; index < 6 ; index++)
              Row(
                children: [
                  Container(
                    width: screenWidth * 0.9,
                    padding: EdgeInsetsDirectional.only(
                        start: screenWidth * 0.1, top: 5.0, bottom: 0.0),
                    child: Row(
                      children: [
                        Text(
                          getTranslated(context, 'ambassador_profile_service_info_2'),
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            Container(
              width: screenWidth * 0.9,
              margin: EdgeInsetsDirectional.only(top: 5.0, bottom: 5.0),
              child: Card(
                elevation: 2.0,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: screenWidth * 0.84,
                          padding: EdgeInsetsDirectional.only(
                              start: screenWidth * 0.08, top: 10.0, bottom: 10.0),
                          child: Text(
                            getTranslated(context, 'ambassador_profile_service_ext'),
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

                    for(int index = 0 ; index < 6 ; index++)
                    Container(
                      width: screenWidth * 0.9,
                      padding: EdgeInsetsDirectional.only(
                          start: screenWidth * 0.08, top: 0.0, bottom: 0.0),
                      child: CheckboxListTile(
                        value: false,
                        onChanged: (value){},
                        title: Row(
                          children: [
                            Expanded(
                              flex: 40,
                              child: FittedBox(
                                alignment: AlignmentDirectional.centerStart,
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  getTranslated(context, 'ambassador_profile_service_ext_2'),
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 30,
                              child: FittedBox(
                                alignment: AlignmentDirectional.centerStart,
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  getTranslated(context, 'ambassador_profile_service_ext_3'),
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 30,
                              child: FittedBox(
                                alignment: AlignmentDirectional.centerEnd,
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  '+15 \$',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
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

            Row(
              children: [
                Container(
                  width: screenWidth * 0.9,
                  padding: EdgeInsetsDirectional.only(
                      start: screenWidth * 0.08, top: 5.0, bottom: 5.0),
                  child: Row(
                    children: [
                      Text(
                        getTranslated(context, 'do_comments'),
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
            _commentsWidget(screenWidth, screenHeight),

          ],
        ),
      ),
    );
  }
}
