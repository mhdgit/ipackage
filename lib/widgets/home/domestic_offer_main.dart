import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:ipackage/localization/localizationValues.dart';
import 'package:ipackage/modules/my_icons.dart';

class DomesticOfferMain extends StatefulWidget {
  @override
  _DomesticOfferMainState createState() => _DomesticOfferMainState();
}

class _DomesticOfferMainState extends State<DomesticOfferMain>
    with TickerProviderStateMixin {
  TabController _tabController;
  int _selectedTabBar;

  List<String> _transports = [
    "خدمة النقل الخاص من و إلى المطار",
  ];
  List<String> _residence = [
    "قضاء ليلتان في اسطنبول",
    "إفطار يومي لشخصين",
  ];
  List<String> _tours = [
    "رحلة إلى حافة العالم",
  ];
  List<String> _hotelActivities = [
    "إفطار يومي في الغرفة",
    "كعكة استقبال للأطفال",
    "ديكورات جميلة داخل الغرفة",
    "عصير فواكه",
    "خدمة واي فاي مجانية",
    "تسجيل الخروج المتأخر لغاية الساعة 2 مساء.(يعتمد على توفر الغرف)"
  ];

  List<String> _comments = [
    "لقد كانت رحلة رائعة لقد كانت رحلة رائعة لقد كانت رحلة رائعة",
    "لقد كانت رحلة رائعة",
  ];

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

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
                    padding: EdgeInsetsDirectional.only(start: width * 0.08),
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
                      padding: EdgeInsetsDirectional.only(start: width * 0.112),
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

  _dayPlanWidget(width, height) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          children: [
            Container(
              padding: EdgeInsetsDirectional.only(
                  start: width * 0.08, top: 10.0, bottom: 8.0),
              child: Text(
                getTranslated(context, 'do_plan_label'),
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
        Row(
          children: [
            Container(
              width: width * 0.84,
              padding: EdgeInsetsDirectional.only(
                  start: width * 0.08, top: 8.0, bottom: 10.0),
              child: Flexible(
                child: Text(
                  getTranslated(context, 'do_plan_label_2'),
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Container(
              padding: EdgeInsetsDirectional.only(
                  start: width * 0.08, top: 10.0, bottom: 8.0),
              child: Text(
                getTranslated(context, 'do_transfer_tab'),
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
        Container(
          width: width * 0.84,
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: GestureDetector(
            onTap: () {},
            child: InkWell(
              borderRadius: BorderRadius.circular(4.0),
              onTap: () {},
              child: Card(
                elevation: 2.0,
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
                      child: Padding(
                        padding: const EdgeInsets.all(0),
                        child: ClipPath(
                          clipper: ShapeBorderClipper(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                          ),
                          child: Image.asset(
                            'assets/images/car.jpg',
                            fit: BoxFit.fill,
                            height: height * 0.28,
                          ),
                        ),
                      ),
                    ),
//
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        getTranslated(context, 'do_plan_label_3'),
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
                      // color: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                                value: 3.5,
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
                                )),
                          ),
                        ],
                      ),
                    ),

                    Container(
                      // color: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 0.0,
                                    right: 0.0,
                                    left: 0.0,
                                    bottom: 0.0),
                                child: Text(
                                  getTranslated(context, 'do_plan_label_4'),
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.black),
                                )),
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
        Row(
          children: [
            Container(
              width: width * 0.84,
              padding: EdgeInsetsDirectional.only(
                  start: width * 0.08, top: 8.0, bottom: 10.0),
              child: Flexible(
                child: Text(
                  getTranslated(context, 'do_plan_label_2'),
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Container(
              padding: EdgeInsetsDirectional.only(
                  start: width * 0.08, top: 10.0, bottom: 8.0),
              child: Text(
                getTranslated(context, 'do_hotels_tab'),
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
        Container(
          width: width * 0.84,
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: GestureDetector(
            onTap: () {},
            child: InkWell(
              borderRadius: BorderRadius.circular(4.0),
              onTap: () {},
              child: Card(
                elevation: 2.0,
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
                      child: Padding(
                        padding: const EdgeInsets.all(0),
                        child: Image.asset(
                          'assets/images/hotel.jpg',
                          fit: BoxFit.fill,
                          height: height * 0.28,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        getTranslated(context, 'do_plan_label_5'),
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: Color(0xff07898B),
                        ),
                        softWrap: true,
                      ),
                    ),
                    Container(
                      // color: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                                value: 3.5,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 35,
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
                                )),
                          ),
                          Expanded(
                            flex: 15,
                            child: GFButton(
                                onPressed: () {},
                                color: Color(0xff07898B),
                                child: Center(
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                )),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      // color: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 0.0,
                                    right: 0.0,
                                    left: 0.0,
                                    bottom: 0.0),
                                child: Text(
                                  getTranslated(context, 'do_plan_label_4'),
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.black),
                                )),
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
        Container(
          width: width * 0.84,
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: InkWell(
            borderRadius: BorderRadius.circular(4.0),
            onTap: () {},
            child: Card(
              elevation: 0.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(color: Colors.black),
              ),
              clipBehavior: Clip.antiAlias,
              margin: const EdgeInsets.all(0.0),
              color: Color(0xffFAFAFA),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(0),
                    child: Padding(
                      padding: const EdgeInsets.all(0),
                      child: Image.asset(
                        'assets/images/end.jpg',
                        fit: BoxFit.fill,
                        height: height * 0.16,
                        width: width * 0.3,
                      ),
                    ),
                  ),
                  Container(
                    width: width * 0.54,
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: FittedBox(
                      child: Text(
                        getTranslated(context, 'do_plan_label_6'),
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          width: width * 0.82,
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Divider(
            color: Colors.black54,
            thickness: 2,
          ),
        ),
        Row(
          children: [
            Container(
              padding: EdgeInsetsDirectional.only(
                  start: width * 0.08, top: 10.0, bottom: 8.0),
              child: Text(
                getTranslated(context, 'do_plan_label_7'),
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
        Container(
          padding: EdgeInsetsDirectional.only(
              start: width * 0.08, top: 8.0, bottom: 10.0),
          child: Row(
            children: [
              Column(
                children: <Widget>[
                  Container(
                    width: 2,
                    height: height * 0.02,
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
                    height: height * 0.02,
                    color: Color(0xff07898B),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Flexible(
                  child: Text(
                    getTranslated(context, 'do_plan_label_8'),
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            Container(
              width: width * 0.84,
              padding: EdgeInsetsDirectional.only(
                  start: width * 0.08, top: 8.0, bottom: 10.0),
              child: Flexible(
                child: Text(
                  getTranslated(context, 'do_plan_label_9'),
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Container(
              padding: EdgeInsetsDirectional.only(
                  start: width * 0.08, top: 10.0, bottom: 8.0),
              child: Text(
                getTranslated(context, 'do_transfer_tab'),
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
        Container(
          width: width * 0.84,
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: GestureDetector(
            onTap: () {},
            child: InkWell(
              borderRadius: BorderRadius.circular(4.0),
              onTap: () {},
              child: Card(
                elevation: 2.0,
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
                      child: Padding(
                        padding: const EdgeInsets.all(0),
                        child: ClipPath(
                          clipper: ShapeBorderClipper(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                          ),
                          child: Image.asset(
                            'assets/images/car.jpg',
                            fit: BoxFit.fill,
                            height: height * 0.28,
                          ),
                        ),
                      ),
                    ),
//
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        getTranslated(context, 'do_plan_label_3'),
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
                      // color: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                                value: 3.5,
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
                                )),
                          ),
                        ],
                      ),
                    ),

                    Container(
                      // color: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 0.0,
                                    right: 0.0,
                                    left: 0.0,
                                    bottom: 0.0),
                                child: Text(
                                  getTranslated(context, 'do_plan_label_4'),
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.black),
                                )),
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
        Row(
          children: [
            Container(
              padding: EdgeInsetsDirectional.only(
                  start: width * 0.08, top: 10.0, bottom: 8.0),
              child: Text(
                getTranslated(context, 'do_plan_label_10'),
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
        Container(
          width: width * 0.84,
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: GestureDetector(
            onTap: () {},
            child: InkWell(
              borderRadius: BorderRadius.circular(4.0),
              onTap: () {},
              child: Card(
                elevation: 2.0,
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
                      child: Padding(
                        padding: const EdgeInsets.all(0),
                        child: ClipPath(
                          clipper: ShapeBorderClipper(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                          ),
                          child: Image.asset(
                            'assets/images/castle.jpg',
                            fit: BoxFit.fill,
                            height: height * 0.28,
                          ),
                        ),
                      ),
                    ),
//
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        getTranslated(context, 'do_plan_label_10'),
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
                      // color: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                                value: 3.5,
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
                                )),
                          ),
                        ],
                      ),
                    ),

                    Container(
                      // color: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 0.0,
                                    right: 0.0,
                                    left: 0.0,
                                    bottom: 0.0),
                                child: Text(
                                  getTranslated(context, 'do_plan_label_4'),
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.black),
                                )),
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
        Container(
          width: width * 0.84,
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: InkWell(
            borderRadius: BorderRadius.circular(4.0),
            onTap: () {},
            child: Card(
              elevation: 0.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(color: Colors.black),
              ),
              clipBehavior: Clip.antiAlias,
              margin: const EdgeInsets.all(0.0),
              color: Color(0xffFAFAFA),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(0),
                    child: Padding(
                      padding: const EdgeInsets.all(0),
                      child: Image.asset(
                        'assets/images/end.jpg',
                        fit: BoxFit.fill,
                        height: height * 0.16,
                        width: width * 0.3,
                      ),
                    ),
                  ),
                  Container(
                    width: width * 0.54,
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: FittedBox(
                      child: Text(
                        getTranslated(context, 'do_plan_label_11'),
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
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
              padding: EdgeInsetsDirectional.only(
                  start: width * 0.08, top: 10.0, bottom: 8.0),
              child: Text(
                getTranslated(context, 'do_plan_label_12'),
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
        Container(
          padding: EdgeInsetsDirectional.only(
              start: width * 0.08, top: 8.0, bottom: 10.0),
          child: Row(
            children: [
              Column(
                children: <Widget>[
                  Container(
                    width: 2,
                    height: height * 0.02,
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
                    height: height * 0.02,
                    color: Color(0xff07898B),
                  ),
                ],
              ),
              Container(
                width: width * 0.84,
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Flexible(
                      child: Text(
                        getTranslated(context, 'do_plan_label_13'),
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
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
          width: width * 0.84,
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: InkWell(
            borderRadius: BorderRadius.circular(4.0),
            onTap: () {},
            child: Card(
              elevation: 0.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(color: Colors.black),
              ),
              clipBehavior: Clip.antiAlias,
              margin: const EdgeInsets.all(0.0),
              color: Color(0xffFAFAFA),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(0),
                    child: Padding(
                      padding: const EdgeInsets.all(0),
                      child: Image.asset(
                        'assets/images/end.jpg',
                        fit: BoxFit.fill,
                        height: height * 0.16,
                        width: width * 0.3,
                      ),
                    ),
                  ),
                  Container(
                    width: width * 0.54,
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: FittedBox(
                      child: Text(
                        getTranslated(context, 'do_plan_label_14'),
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
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
              padding: EdgeInsetsDirectional.only(
                  start: width * 0.08, top: 10.0, bottom: 8.0),
              child: Text(
                getTranslated(context, 'do_plan_label_15'),
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
        _activityBar(width, height, getTranslated(context, 'do_plan_label_16'),
            _transports),
        _activityBar(width, height, getTranslated(context, 'do_plan_label_18'),
            _residence),
        _activityBar(
            width, height, getTranslated(context, 'do_plan_label_21'), _tours),
        _activityBar(width, height, getTranslated(context, 'do_plan_label_23'),
            _hotelActivities),
      ],
    );
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
                                    Text(
                                      getTranslated(
                                          context, 'do_comments_username'),
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
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

  _hotelsWidget(width, height) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: width * 0.84,
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: GestureDetector(
            onTap: () {},
            child: InkWell(
              borderRadius: BorderRadius.circular(4.0),
              onTap: () {},
              child: Card(
                elevation: 2.0,
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
                      child: Padding(
                        padding: const EdgeInsets.all(0),
                        child: Image.asset(
                          'assets/images/hotel.jpg',
                          fit: BoxFit.fill,
                          height: height * 0.28,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        getTranslated(context, 'do_plan_label_5'),
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: Color(0xff07898B),
                        ),
                        softWrap: true,
                      ),
                    ),
                    Container(
                      // color: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                                value: 3.5,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 35,
                            child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 0.0, right: 0.0, left: 0.0, bottom: 0.0),
                                child: Text(
                                  ' ',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Colors.black),
                                )),
                          ),
                          Expanded(
                            flex: 15,
                            child: GFButton(
                                onPressed: () {},
                                color: Color(0xff07898B),
                                child: Center(
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                )),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      // color: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 0.0, right: 0.0, left: 0.0, bottom: 0.0),
                                child: Text(
                                  getTranslated(context, 'do_plan_label_4'),
                                  textAlign: TextAlign.start,
                                  style:
                                      TextStyle(fontSize: 15, color: Colors.black),
                                )),
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
      ],
    );
  }

  _transportWidget(width, height) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: width * 0.84,
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: GestureDetector(
            onTap: () {},
            child: InkWell(
              borderRadius: BorderRadius.circular(4.0),
              onTap: () {},
              child: Card(
                elevation: 2.0,
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
                      child: Padding(
                        padding: const EdgeInsets.all(0),
                        child: ClipPath(
                          clipper: ShapeBorderClipper(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                          ),
                          child: Image.asset(
                            'assets/images/car.jpg',
                            fit: BoxFit.fill,
                            height: height * 0.28,
                          ),
                        ),
                      ),
                    ),
//
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        getTranslated(context, 'do_plan_label_3'),
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
                      // color: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                                value: 3.5,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 50,
                            child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 0.0, right: 0.0, left: 0.0, bottom: 0.0),
                                child: Text(
                                  ' ',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Colors.black),
                                )),
                          ),
                        ],
                      ),
                    ),

                    Container(
                      // color: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 0.0, right: 0.0, left: 0.0, bottom: 0.0),
                                child: Text(
                                  getTranslated(context, 'do_plan_label_4'),
                                  textAlign: TextAlign.start,
                                  style:
                                      TextStyle(fontSize: 15, color: Colors.black),
                                )),
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(0),
                          child: Padding(
                            padding: const EdgeInsets.all(0),
                            child: ClipPath(
                              clipper: ShapeBorderClipper(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                              ),
                              child: Image.asset(
                                'assets/images/c4.jpg',
                                fit: BoxFit.fill,
                                height: screenHeight * 0.28,
                              ),
                            ),
                          ),
                        ),
//
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            getTranslated(context, 'home_offer_card_city'),
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
                          // color: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                                    value: 3.5,
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
                                    )),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          // color: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 8.0),
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
                                      getTranslated(
                                          context, 'home_offer_card_days'),
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          color: Colors.black),
                                    )),
                              ),
                              Expanded(
                                flex: 50,
                                child: Text(
                                  getTranslated(
                                          context, 'home_offer_card_price') +
                                      ' 220\$',
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Colors.black),
                                  softWrap: true,
                                ),
                              ),
                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            getTranslated(context, 'home_offer_card_details'),
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
                              crossAxisAlignment: CrossAxisAlignment.stretch,
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
                                          margin:
                                              const EdgeInsets.only(top: 6.0),
                                          child: FittedBox(
                                            child: Text(
                                              getTranslated(context,
                                                  'home_offer_card_rate'),
                                              textAlign: TextAlign.center,
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
                                          margin:
                                              const EdgeInsets.only(top: 6.0),
                                          child: FittedBox(
                                            child: Text(
                                              getTranslated(context,
                                                  'home_offer_card_flight'),
                                              textAlign: TextAlign.center,
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
                                        Image.asset('assets/icons/dish.png'),
                                        Container(
                                          margin:
                                              const EdgeInsets.only(top: 6.0),
                                          child: FittedBox(
                                            child: Text(
                                              getTranslated(context,
                                                  'home_offer_card_breakfast'),
                                              textAlign: TextAlign.center,
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
                                          margin:
                                              const EdgeInsets.only(top: 6.0),
                                          child: FittedBox(
                                            child: Text(
                                              getTranslated(context,
                                                  'home_offer_card_transportation'),
                                              textAlign: TextAlign.center,
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
              width: screenWidth * 0.84,
              padding: EdgeInsets.only(
                  top: 10.0, right: 0.0, left: 0.0, bottom: 0.0),
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.black,
                  side: BorderSide(color: Colors.black, width: 2),
                ),
                onPressed: () {},
                child: Text(
                  getTranslated(context, 'domestic_offer_book_btn'),
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
              ),
            ),
            Row(
              children: [
                Container(
                  padding: EdgeInsetsDirectional.only(
                      start: screenWidth * 0.08, top: 20.0, bottom: 10.0),
                  child: Text(
                    getTranslated(context, 'domestic_offer_plan_label'),
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
            Container(
              width: screenWidth,
              padding: EdgeInsetsDirectional.only(top: 20.0, bottom: 10.0),
              child: TabBar(
                indicatorColor: Colors.white,
                labelColor: Color(0xff07898B),
                unselectedLabelColor: Color(0xffB4DCDC),
                indicatorWeight: 4,
                controller: _tabController,
                labelStyle:
                    TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                onTap: (index) {
                  switch (index) {
                    case 0:
                      setState(() {
                        _selectedTabBar = 0;
                      });
                      break;
                    case 1:
                      setState(() {
                        _selectedTabBar = 1;
                      });
                      break;
                    case 2:
                      setState(() {
                        _selectedTabBar = 2;
                      });
                      break;
                    case 3:
                      setState(() {
                        _selectedTabBar = 3;
                      });
                      break;
                  }
                },
                tabs: [
                  Tab(
                    text: getTranslated(context, 'do_plan_tab'),
                  ),
                  Tab(
                    text: getTranslated(context, 'do_flights_tab'),
                  ),
                  Tab(
                    text: getTranslated(context, 'do_hotels_tab'),
                  ),
                  Tab(
                    text: getTranslated(context, 'do_transfer_tab'),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: screenWidth,
                    child: Builder(
                      builder: (BuildContext context) {
                        if (_selectedTabBar == 0)
                          return _dayPlanWidget(screenWidth, screenHeight);
                        else if (_selectedTabBar == 1)
                          return Container(
                            width: screenWidth * 0.84,
                            height: 150,
                          );
                        else if (_selectedTabBar == 2)
                          return _hotelsWidget(screenWidth, screenHeight);
                        else
                          return _transportWidget(screenWidth, screenHeight);
                      },
                    )),
              ],
            ),
            Row(
              children: [
                Container(
                  padding: EdgeInsetsDirectional.only(
                      start: screenWidth * 0.08, top: 20.0, bottom: 8.0),
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
