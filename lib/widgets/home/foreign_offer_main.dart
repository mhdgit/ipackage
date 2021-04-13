import 'package:flutter/material.dart';
import 'package:getwidget/components/rating/gf_rating.dart';
import 'package:getwidget/getwidget.dart';
import 'package:ipackage/localization/localizationValues.dart';
import 'package:ipackage/modules/my_icons.dart';
import 'package:ipackage/widgets/change_activity.dart';
import 'package:ipackage/widgets/confirm_book.dart';
import 'package:ipackage/widgets/edit_book.dart';
import 'package:ipackage/widgets/home/domestic_offer_main.dart';
import 'package:responsive_grid/responsive_grid.dart';

class ForeignOfferMain extends StatefulWidget {
  @override
  _ForeignOfferMainState createState() => _ForeignOfferMainState();
}

class _ForeignOfferMainState extends State<ForeignOfferMain> {

  List<String> _imageList = [
    'assets/images/c4.jpg',
    'assets/images/c3.jpg',
    'assets/images/c1.jpg',
    'assets/images/c1.jpg',
    'assets/images/c3.jpg',
    'assets/images/c4.jpg',
  ];

  List<Map<String , dynamic>> _days = [
    {
      'day_ar': 'اليوم الأول',
      'day_en': 'First day',
      'activities' : [
        {
          'active_ar' : 'بعد الوصول إلى المدينة ستنقلك السيارة إلى الفندق',
          'active_en' : 'After reaching the city the car will take you to the hotel',
          'sub_active' : [],
        },
        {
          'active_ar' : 'تناول طعام الإفطار في الفندق',
          'active_en' : 'Eat breakfast at the hotel',
          'sub_active' : [
            {
              'sub_active_ar' : 'ستقلك السيارة إلى الجولة السياحية',
              'sub_active_en' : 'The car will take you to the tour',
            },
          ],
        },
        {
          'active_ar' : 'تناول طعام الإفطار في الفندق',
          'active_en' : 'Eat breakfast at the hotel',
          'sub_active' : [
            {
              'sub_active_ar' : 'ستقلك السيارة إلى الجولة السياحية',
              'sub_active_en' : 'The car will take you to the tour',
            },
          ],
        },
        {
          'active_ar' : 'تناول طعام الإفطار في الفندق',
          'active_en' : 'Eat breakfast at the hotel',
          'sub_active' : [
            {
              'sub_active_ar' : 'ستقلك السيارة إلى الجولة السياحية',
              'sub_active_en' : 'The car will take you to the tour',
            },
          ],
        },
      ],
      'images' : [
        'assets/images/c4.jpg',
        'assets/images/c3.jpg',
        'assets/images/c1.jpg',
        'assets/images/c1.jpg',
        'assets/images/c3.jpg',
        'assets/images/c4.jpg',
      ],
    },
    {
      'day_ar': 'اليوم الثاني',
      'day_en': 'Second day',
      'activities' : [
        {
          'active_ar' : 'بعد الوصول إلى المدينة ستنقلك السيارة إلى الفندق',
          'active_en' : 'After reaching the city the car will take you to the hotel',
          'sub_active' : [],
        },
        {
          'active_ar' : 'تناول طعام الإفطار في الفندق',
          'active_en' : 'Eat breakfast at the hotel',
          'sub_active' : [
            {
              'sub_active_ar' : 'ستقلك السيارة إلى الجولة السياحية',
              'sub_active_en' : 'The car will take you to the tour',
            },
          ],
        },
        {
          'active_ar' : 'تناول طعام الإفطار في الفندق',
          'active_en' : 'Eat breakfast at the hotel',
          'sub_active' : [
            {
              'sub_active_ar' : 'ستقلك السيارة إلى الجولة السياحية',
              'sub_active_en' : 'The car will take you to the tour',
            },
          ],
        },
        {
          'active_ar' : 'تناول طعام الإفطار في الفندق',
          'active_en' : 'Eat breakfast at the hotel',
          'sub_active' : [
            {
              'sub_active_ar' : 'ستقلك السيارة إلى الجولة السياحية',
              'sub_active_en' : 'The car will take you to the tour',
            },
          ],
        },
      ],
      'images' : [
        'assets/images/c4.jpg',
        'assets/images/c3.jpg',
        'assets/images/c1.jpg',
        'assets/images/c1.jpg',
        'assets/images/c3.jpg',
        'assets/images/c4.jpg',
      ],
    },
  ];

  List<String> _residence = [
    "قضاء ليلتان في اسطنبول",
    "إفطار يومي لشخصين",
  ];

  List<String> _hotelActivities = [
    "إفطار يومي في الغرفة",
    "كعكة استقبال للأطفال",
    "ديكورات جميلة داخل الغرفة",
    "عصير فواكه",
    "خدمة واي فاي مجانية",
  ];

  List<String> _comments = [
    "لقد كانت رحلة رائعة لقد كانت رحلة رائعة لقد كانت رحلة رائعة",
    "لقد كانت رحلة رائعة",
  ];

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

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final double screenHeight =
        MediaQuery.of(context).size.height - statusBarHeight - kToolbarHeight;
    final double screenWidth = MediaQuery.of(context).size.width;

    _activityBar(width, height, String head, List<String> subActivities) {
      return subActivities.length == 0
          ? Row(
        children: [
          Container(
              padding: EdgeInsetsDirectional.only(start: width * 0.08),
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
                      padding: EdgeInsetsDirectional.only(
                          start: width * 0.02, top: 0.0, bottom: 0.0),
                      child: Text(
                        head,
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
              )),
        ],
      )
          : Column(
        children: <Widget>[
          Row(
            children: [
              Container(
                // padding: EdgeInsetsDirectional.only(start: width * 0.08),
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
                      padding: EdgeInsetsDirectional.only(
                          start: width * 0.02, top: 0.0, bottom: 0.0),
                      child: Text(
                        head,
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
              ),
            ],
          ),
          for (int i = 0; i < subActivities.length; i++)
            Row(
              children: [
                Container(
                  padding: EdgeInsetsDirectional.only(start: width * 0.032),
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 2,
                        height: height * 0.06,
                        color: Color(0xff07898B),
                      ),
                      Container(
                        width: width * 0.8,
                        padding: EdgeInsetsDirectional.only(
                            start: width * 0.04, top: 0.0, bottom: 0.0),
                        child: Row(
                          children: [
                            Flexible(
                              child: Text(
                                subActivities[i].toString(),
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54,
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
        ],
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xffE9F7F8),
        elevation: 0.0,
        shadowColor: Colors.white,
        title: Text(
          getTranslated(context, 'domestic_offer_title'),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
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
                              child: Image.asset(
                                'assets/images/c3.jpg',
                                fit: BoxFit.fill,
                                height: screenHeight * 0.26,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(6),
                            child: Flex(
                              direction: Axis.horizontal,
                              mainAxisAlignment:
                              MainAxisAlignment.start,
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding:
                                      const EdgeInsets.all(0.0),
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
                                            value: 5,
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
                                onTap: () {
                                },
                                child: Card(
                                  margin: const EdgeInsets.all(0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7),
                                  ),
                                  clipBehavior: Clip.antiAlias,
                                  child: Image.asset(
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
                      start: screenWidth * 0.08, top: 20.0, bottom: 10.0),
                  child: Row(
                    children: [
                      Flexible(
                        child: Text(
                          getTranslated(context, 'fo_label'),
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

            Row(
              children: [
                Container(
                  width: screenWidth * 0.84,
                  padding: EdgeInsetsDirectional.only(
                      start: screenWidth * 0.08, top: 20.0, bottom: 10.0),
                  child: Row(
                    children: [
                      Flexible(
                        child: Text(
                          getTranslated(context, 'home_offer_card_days'),
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

            Container(
              width: screenWidth * 0.84,
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Divider(
                color: Colors.black54,
                thickness: 1,
              ),
            ),

            Container(
              width: screenWidth * 0.84,
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 30,
                    child: FittedBox(
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          getTranslated(context, 'home_offer_card_city'),
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
                    flex: 30,
                    child: FittedBox(
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
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
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          '12-1-2021',
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
                      onPressed: (){

                        Navigator.of(context).push(new MaterialPageRoute(
                            builder: (BuildContext context) => new EditBook()));
                      },
                      child: Text(
                        getTranslated(context, 'fo_edit'),
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 15,
                          color: Color(0xff07898B),
                        ),
                      ),
                    )
                  ),
                ],
              ),
            ),

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
                      padding: const EdgeInsetsDirectional.only(end: 10.0),
                      child: GFButtonBadge(
                        onPressed: (){},
                        color: Colors.white,
                        textColor: Colors.black,
                        elevation: 3.0,
                        text: getTranslated(context, 'do_flights_tab'),
                        icon: GFBadge(
                          color: Color(0xffBDBDBD),
                          textColor: Colors.black,
                          child: Text("2" , style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                          shape: GFBadgeShape.circle,
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsetsDirectional.only(end: 10.0),
                      child: GFButtonBadge(
                        onPressed: (){},
                        color: Colors.white,
                        textColor: Colors.black,
                        elevation: 3.0,
                        text: getTranslated(context, 'do_hotels_tab'),
                        icon: GFBadge(
                          color: Color(0xffBDBDBD),
                          textColor: Colors.black,
                          child: Text("2" , style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                          shape: GFBadgeShape.circle,
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsetsDirectional.only(end: 10.0),
                      child: GFButtonBadge(
                        onPressed: (){},
                        color: Colors.white,
                        textColor: Colors.black,
                        elevation: 3.0,
                        text: getTranslated(context, 'do_transfer_tab'),
                        icon: GFBadge(
                          color: Color(0xffBDBDBD),
                          textColor: Colors.black,
                          child: Text("2" , style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                          shape: GFBadgeShape.circle,
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsetsDirectional.only(end: 10.0),
                      child: GFButtonBadge(
                        onPressed: (){},
                        color: Colors.white,
                        textColor: Colors.black,
                        elevation: 3.0,
                        text: getTranslated(context, 'do_activities_tab'),
                        icon: GFBadge(
                          color: Color(0xffBDBDBD),
                          textColor: Colors.black,
                          child: Text("2" , style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                          shape: GFBadgeShape.circle,
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

            Container(
              width: screenWidth,
              height: screenHeight * 0.11,
              color: Color(0xff07898B),
              child: Row(
                children: <Widget>[

                  Padding(
                    padding: EdgeInsetsDirectional.only(
                        start: screenWidth * 0.1),
                    child: GFButton(
                      onPressed: (){
                        Navigator.of(context).push(new MaterialPageRoute(
                            builder: (BuildContext context) => new ConfirmBook()));
                      },
                      color: Colors.black,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                        child: Text(
                          getTranslated(context, 'domestic_offer_book_btn'),
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                      ),
                    ),
                  ),

                  Container(
                    padding: EdgeInsetsDirectional.only(
                        start: screenWidth * 0.06),
                    child: Text(
                      '220 \$',
                      style: TextStyle(fontSize: 18, color: Colors.white , fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),

            for(int index = 0 ; index < _days.length ; index++)
            Container(
              width: screenWidth,
              child: Card(
                elevation: 3.0,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsetsDirectional.only(start: screenWidth * 0.08 , top:10.0),
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: 2,
                                height: screenHeight * 0.06,
                                color: Color(0xff07898B),
                              ),
                              Container(
                                width: screenWidth * 0.8,
                                padding: EdgeInsetsDirectional.only(
                                    start: screenWidth * 0.04, top: 0.0, bottom: 0.0),
                                child: Row(
                                  children: [
                                    Flexible(
                                      child: Text(
                                        _days[index]['day_ar'],
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
                    Container(
                      margin: EdgeInsets.only(top: 5.0, left: 10.0 , bottom: 0.0),
                      height: screenHeight * 0.25,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          for(int i = 0 ; i < _imageList.length ; i++)
                          Container(
                            width: screenWidth * 0.65,
                            padding: const EdgeInsets.all(10.0),
                            child: GestureDetector(
                              onTap: () {},
                              child: InkWell(
                                onTap: () {},
                                child: Card(
                                  clipBehavior: Clip.antiAlias,
                                  elevation: 0.5,
                                  margin: const EdgeInsets.all(0.0),
                                  color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.all(0),
                                    child: Padding(
                                      padding: const EdgeInsets.all(0),
                                      child: ClipPath(
                                        clipper: ShapeBorderClipper(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(4.0)),
                                        ),
                                        child: Image.asset(
                                          _imageList[i].toString(),
                                          fit: BoxFit.fill,
                                          height: screenHeight * 0.24,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
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
                        collapsedIcon: Icon(Icons.keyboard_arrow_down, color: Color(0xff07898B),),
                        expandedIcon: Icon(Icons.keyboard_arrow_up, color: Color(0xff07898B),),
                        contentChild: Container(
                          width: screenWidth,
                          child: Column(
                            children: <Widget>[

                              for(int i = 0; i < _hotelActivities.length; i++)
                                _activityBar(screenWidth, screenHeight, _hotelActivities[i], _residence),

                              Row(
                                children: [
                                  Container(
                                      // padding: EdgeInsetsDirectional.only(start: screenWidth * 0.02),
                                      child: Container(
                                        child: Row(
                                          children: <Widget>[
                                            Column(
                                              children: <Widget>[
                                                Container(
                                                  width: 2,
                                                  height: screenHeight * 0.06,
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
                                                      color: Color(0xffDDDDDD),
                                                      style: BorderStyle.solid,
                                                    ),
                                                  ),
                                                  child: Container(
                                                      width: 15,
                                                      height: 15,
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(50),
                                                        color: Color(0xffDDDDDD),
                                                      )),
                                                ),

                                              ],
                                            ),
                                            Container(
                                              width: screenWidth * 0.75,
                                              height: screenHeight * 0.08,
                                              color: Color(0xffDDDDDD),
                                              margin: EdgeInsetsDirectional.only(
                                                  start: screenWidth * 0.02, top: 10.0, bottom: 0.0),
                                              padding: EdgeInsets.all(5.0),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    flex: 60,
                                                    child: Text(
                                                      getTranslated(context, 'fo_label_2'),
                                                      textAlign: TextAlign.start,
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),

                                                  Expanded(
                                                    flex:40,
                                                    child: TextButton(
                                                      onPressed: (){
                                                        Navigator.of(context).push(new MaterialPageRoute(
                                                            builder: (BuildContext context) =>
                                                            new ChangeActivity()));
                                                      },
                                                      child: Text(
                                                        getTranslated(context, 'fo_add_btn'),
                                                        textAlign: TextAlign.start,
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                          color: Color(0xff07898B),
                                                        ),
                                                      ),
                                                    )
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
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
                ),
              ),
            ),

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
                height: screenHeight * 0.65,
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
                            Navigator.of(context).push(new MaterialPageRoute(
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
                              crossAxisAlignment: CrossAxisAlignment.stretch,
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
                                                BorderRadius.circular(15)),
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
                                              const EdgeInsets.all(3.0),
                                              margin: const EdgeInsets.only(
                                                  top: 20.0),
                                              constraints: BoxConstraints(),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(
                                                  color: Colors.white,
                                                ),
                                                borderRadius: BorderRadius.all(
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        flex: 50,
                                        child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 0.0,
                                                right: 0.0,
                                                left: 0.0,
                                                bottom: 0.0),
                                            child: Text(
                                              getTranslated(context,
                                                  'home_offer_card_days'),
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
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
                                    getTranslated(
                                        context, 'home_offer_card_price') +
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
                                    getTranslated(
                                        context, 'home_offer_card_details'),
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: 14,
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
                                            padding: const EdgeInsets.all(2.0),
                                            child: Column(
                                              children: <Widget>[
                                                Icon(
                                                  MyIcons.bed,
                                                  color: Colors.white,
                                                ),
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      top: 6.0),
                                                  child: FittedBox(
                                                    child: Text(
                                                      getTranslated(context,
                                                          'home_offer_card_rate'),
                                                      textAlign:
                                                      TextAlign.center,
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.white,
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
                                            padding: const EdgeInsets.all(2.0),
                                            child: Column(
                                              children: <Widget>[
                                                Icon(
                                                  Icons.airplanemode_inactive,
                                                  color: Colors.white,
                                                ),
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      top: 6.0),
                                                  child: FittedBox(
                                                    child: Text(
                                                      getTranslated(context,
                                                          'home_offer_card_flight'),
                                                      textAlign:
                                                      TextAlign.center,
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.white,
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
                                            padding: const EdgeInsets.all(2.0),
                                            child: Column(
                                              children: <Widget>[
                                                Image.asset(
                                                    'assets/icons/dish.png'),
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      top: 6.0),
                                                  child: FittedBox(
                                                    child: Text(
                                                      getTranslated(context,
                                                          'home_offer_card_breakfast'),
                                                      textAlign:
                                                      TextAlign.center,
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.white,
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
                                            padding: const EdgeInsets.all(2.0),
                                            child: Column(
                                              children: <Widget>[
                                                Icon(
                                                  Icons.directions_car_outlined,
                                                  color: Colors.white,
                                                ),
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      top: 6.0),
                                                  child: FittedBox(
                                                    child: Text(
                                                      getTranslated(context,
                                                          'home_offer_card_transportation'),
                                                      textAlign:
                                                      TextAlign.center,
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.white,
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
                              crossAxisAlignment: CrossAxisAlignment.stretch,
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
                                                BorderRadius.circular(15)),
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
                                              const EdgeInsets.all(3.0),
                                              margin: const EdgeInsets.only(
                                                  top: 20.0),
                                              constraints: BoxConstraints(),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(
                                                  color: Colors.white,
                                                ),
                                                borderRadius: BorderRadius.all(
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        flex: 50,
                                        child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 0.0,
                                                right: 0.0,
                                                left: 0.0,
                                                bottom: 0.0),
                                            child: Text(
                                              getTranslated(context,
                                                  'home_offer_card_days'),
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
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
                                    getTranslated(
                                        context, 'home_offer_card_price') +
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
                                    getTranslated(
                                        context, 'home_offer_card_details'),
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: 14,
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
                                            padding: const EdgeInsets.all(2.0),
                                            child: Column(
                                              children: <Widget>[
                                                Icon(
                                                  MyIcons.bed,
                                                  color: Colors.white,
                                                ),
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      top: 6.0),
                                                  child: FittedBox(
                                                    child: Text(
                                                      getTranslated(context,
                                                          'home_offer_card_rate'),
                                                      textAlign:
                                                      TextAlign.center,
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.white,
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
                                            padding: const EdgeInsets.all(2.0),
                                            child: Column(
                                              children: <Widget>[
                                                Icon(
                                                  Icons.airplanemode_inactive,
                                                  color: Colors.white,
                                                ),
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      top: 6.0),
                                                  child: FittedBox(
                                                    child: Text(
                                                      getTranslated(context,
                                                          'home_offer_card_flight'),
                                                      textAlign:
                                                      TextAlign.center,
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.white,
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
                                            padding: const EdgeInsets.all(2.0),
                                            child: Column(
                                              children: <Widget>[
                                                Image.asset(
                                                    'assets/icons/dish.png'),
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      top: 6.0),
                                                  child: FittedBox(
                                                    child: Text(
                                                      getTranslated(context,
                                                          'home_offer_card_breakfast'),
                                                      textAlign:
                                                      TextAlign.center,
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.white,
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
                                            padding: const EdgeInsets.all(2.0),
                                            child: Column(
                                              children: <Widget>[
                                                Icon(
                                                  Icons.directions_car_outlined,
                                                  color: Colors.white,
                                                ),
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      top: 6.0),
                                                  child: FittedBox(
                                                    child: Text(
                                                      getTranslated(context,
                                                          'home_offer_card_transportation'),
                                                      textAlign:
                                                      TextAlign.center,
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.white,
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
                              crossAxisAlignment: CrossAxisAlignment.stretch,
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
                                                BorderRadius.circular(15)),
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
                                              const EdgeInsets.all(3.0),
                                              margin: const EdgeInsets.only(
                                                  top: 20.0),
                                              constraints: BoxConstraints(),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(
                                                  color: Colors.white,
                                                ),
                                                borderRadius: BorderRadius.all(
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        flex: 50,
                                        child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 0.0,
                                                right: 0.0,
                                                left: 0.0,
                                                bottom: 0.0),
                                            child: Text(
                                              getTranslated(context,
                                                  'home_offer_card_days'),
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
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
                                    getTranslated(
                                        context, 'home_offer_card_price') +
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
                                    getTranslated(
                                        context, 'home_offer_card_details'),
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: 14,
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
                                            padding: const EdgeInsets.all(2.0),
                                            child: Column(
                                              children: <Widget>[
                                                Icon(
                                                  MyIcons.bed,
                                                  color: Colors.white,
                                                ),
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      top: 6.0),
                                                  child: FittedBox(
                                                    child: Text(
                                                      getTranslated(context,
                                                          'home_offer_card_rate'),
                                                      textAlign:
                                                      TextAlign.center,
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.white,
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
                                            padding: const EdgeInsets.all(2.0),
                                            child: Column(
                                              children: <Widget>[
                                                Icon(
                                                  Icons.airplanemode_inactive,
                                                  color: Colors.white,
                                                ),
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      top: 6.0),
                                                  child: FittedBox(
                                                    child: Text(
                                                      getTranslated(context,
                                                          'home_offer_card_flight'),
                                                      textAlign:
                                                      TextAlign.center,
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.white,
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
                                            padding: const EdgeInsets.all(2.0),
                                            child: Column(
                                              children: <Widget>[
                                                Image.asset(
                                                    'assets/icons/dish.png'),
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      top: 6.0),
                                                  child: FittedBox(
                                                    child: Text(
                                                      getTranslated(context,
                                                          'home_offer_card_breakfast'),
                                                      textAlign:
                                                      TextAlign.center,
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.white,
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
                                            padding: const EdgeInsets.all(2.0),
                                            child: Column(
                                              children: <Widget>[
                                                Icon(
                                                  Icons.directions_car_outlined,
                                                  color: Colors.white,
                                                ),
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      top: 6.0),
                                                  child: FittedBox(
                                                    child: Text(
                                                      getTranslated(context,
                                                          'home_offer_card_transportation'),
                                                      textAlign:
                                                      TextAlign.center,
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.white,
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
