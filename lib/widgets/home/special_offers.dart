import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:ipackage/localization/localizationValues.dart';
import 'package:ipackage/modules/my_icons.dart';

class SpecialOffers extends StatefulWidget {
  @override
  _SpecialOffersState createState() => _SpecialOffersState();
}

class _SpecialOffersState extends State<SpecialOffers> {
  @override
  Widget build(BuildContext context) {

    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final double screenHeight =
        MediaQuery.of(context).size.height - statusBarHeight - kToolbarHeight;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.0),
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
                onTap: () {},
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  clipBehavior: Clip.antiAlias,
                  elevation: 0.5,
                  margin: const EdgeInsets.all(0.0),
                  color: Colors.white,
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
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff07898B),
                          ),
                          softWrap: true,
                        ),
                      ),

                      Container(
                        color: Colors.white,
                        margin: const EdgeInsets.all(8.0),
                        padding: const EdgeInsets.all(0.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 50,
                              child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 0.0,
                                      right: 8.0,
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
                                  color: Colors.yellow,
                                  borderColor: Colors.yellow,
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
                        padding: const EdgeInsets.all(8.0),
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
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Expanded(
                                flex:25,
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Column(
                                    children: <Widget>[
                                      Icon(
                                        MyIcons.bed,
                                        color: Colors.white,
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(top: 6.0),
                                        child: FittedBox(
                                          child: Text(
                                            getTranslated(
                                                context, 'home_offer_card_rate'),
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
                                flex:25,
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Column(
                                    children: <Widget>[
                                      Icon(
                                        Icons.airplanemode_inactive,
                                        color: Colors.white,
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(top: 6.0),
                                        child: FittedBox(
                                          child: Text(
                                            getTranslated(
                                                context, 'home_offer_card_flight'),
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
                                flex:25,
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Column(
                                    children: <Widget>[
                                      Image.asset(
                                          'assets/icons/dish.png'
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(top: 6.0),
                                        child: FittedBox(
                                          child: Text(
                                            getTranslated(
                                                context, 'home_offer_card_breakfast'),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 14,
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
                                flex:25,
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Column(
                                    children: <Widget>[
                                      Icon(
                                        Icons.directions_car_outlined,
                                        color: Colors.white,
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(top: 6.0),
                                        child: FittedBox(
                                          child: Text(
                                            getTranslated(
                                                context, 'home_offer_card_transportation'),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 14,
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
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  clipBehavior: Clip.antiAlias,
                  elevation: 0.5,
                  margin: const EdgeInsets.all(0.0),
                  color: Colors.white,
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
                                  'assets/images/2.png',
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
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff07898B),
                          ),
                          softWrap: true,
                        ),
                      ),

                      Container(
                        color: Colors.white,
                        margin: const EdgeInsets.all(8.0),
                        padding: const EdgeInsets.all(0.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 50,
                              child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 0.0,
                                      right: 8.0,
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
                                  color: Colors.yellow,
                                  borderColor: Colors.yellow,
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
                        padding: const EdgeInsets.all(8.0),
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
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Expanded(
                                flex:25,
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Column(
                                    children: <Widget>[
                                      Icon(
                                        MyIcons.bed,
                                        color: Colors.white,
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(top: 6.0),
                                        child: FittedBox(
                                          child: Text(
                                            getTranslated(
                                                context, 'home_offer_card_rate'),
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
                                flex:25,
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Column(
                                    children: <Widget>[
                                      Icon(
                                        Icons.airplanemode_inactive,
                                        color: Colors.white,
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(top: 6.0),
                                        child: FittedBox(
                                          child: Text(
                                            getTranslated(
                                                context, 'home_offer_card_flight'),
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
                                flex:25,
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Column(
                                    children: <Widget>[
                                      Image.asset(
                                          'assets/icons/dish.png'
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(top: 6.0),
                                        child: FittedBox(
                                          child: Text(
                                            getTranslated(
                                                context, 'home_offer_card_breakfast'),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 14,
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
                                flex:25,
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Column(
                                    children: <Widget>[
                                      Icon(
                                        Icons.directions_car_outlined,
                                        color: Colors.white,
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(top: 6.0),
                                        child: FittedBox(
                                          child: Text(
                                            getTranslated(
                                                context, 'home_offer_card_transportation'),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 14,
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
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  clipBehavior: Clip.antiAlias,
                  elevation: 0.5,
                  margin: const EdgeInsets.all(0.0),
                  color: Colors.white,
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
                                  'assets/images/1.png',
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
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff07898B),
                          ),
                          softWrap: true,
                        ),
                      ),

                      Container(
                        color: Colors.white,
                        margin: const EdgeInsets.all(8.0),
                        padding: const EdgeInsets.all(0.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 50,
                              child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 0.0,
                                      right: 8.0,
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
                                  color: Colors.yellow,
                                  borderColor: Colors.yellow,
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
                        padding: const EdgeInsets.all(8.0),
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
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Expanded(
                                flex:25,
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Column(
                                    children: <Widget>[
                                      Icon(
                                        MyIcons.bed,
                                        color: Colors.white,
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(top: 6.0),
                                        child: FittedBox(
                                          child: Text(
                                            getTranslated(
                                                context, 'home_offer_card_rate'),
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
                                flex:25,
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Column(
                                    children: <Widget>[
                                      Icon(
                                        Icons.airplanemode_inactive,
                                        color: Colors.white,
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(top: 6.0),
                                        child: FittedBox(
                                          child: Text(
                                            getTranslated(
                                                context, 'home_offer_card_flight'),
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
                                flex:25,
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Column(
                                    children: <Widget>[
                                      Image.asset(
                                          'assets/icons/dish.png'
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(top: 6.0),
                                        child: FittedBox(
                                          child: Text(
                                            getTranslated(
                                                context, 'home_offer_card_breakfast'),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 14,
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
                                flex:25,
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Column(
                                    children: <Widget>[
                                      Icon(
                                        Icons.directions_car_outlined,
                                        color: Colors.white,
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(top: 6.0),
                                        child: FittedBox(
                                          child: Text(
                                            getTranslated(
                                                context, 'home_offer_card_transportation'),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 14,
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
    )
    ;
  }
}