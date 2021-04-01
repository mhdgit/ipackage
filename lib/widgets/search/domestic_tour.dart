import 'package:flutter/material.dart';
import 'package:getwidget/components/rating/gf_rating.dart';
import 'package:ipackage/localization/localizationValues.dart';

class DomesticTour extends StatefulWidget {
  @override
  _DomesticTourState createState() => _DomesticTourState();
}

class _DomesticTourState extends State<DomesticTour> {
  @override
  Widget build(BuildContext context) {

    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final double screenHeight =
        MediaQuery.of(context).size.height - statusBarHeight - kToolbarHeight;
    final double screenWidth = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Container(
        color: Color(0xff82C3C5),
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(
                  top: 20.0, bottom: 10.0, right: 8, left: 8),
              child: Text(
                getTranslated(context, 'pyt_n_t_label'),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),

            Container(
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 0.0, bottom: 10.0, right: 15, left: 15),
                child: Text(
                  getTranslated(context, 'pyt_n_t_label_2'),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            Container(
              margin: EdgeInsets.only(top: 5.0, left: 10.0 , bottom: 0.0),
              height: screenHeight * 0.55,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  Column(
                    children: [
                      Container(
                        width: screenWidth * 0.65,
                        padding: const EdgeInsets.all(10.0),
                        child: GestureDetector(
                          onTap: () {},
                          child: InkWell(
                            borderRadius: BorderRadius.circular(4.0),
                            onTap: () {},
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7.0),
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
                                                  BorderRadius.circular(7.0)),
                                            ),
                                            child: Image.asset(
                                              'assets/images/c3.jpg',
                                              fit: BoxFit.fill,
                                              height: screenHeight * 0.24,
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
                                                    height: 20,
                                                    padding:
                                                    const EdgeInsets.all(0.0),
                                                    margin: EdgeInsets.only(
                                                        top: screenHeight * 0.15),
                                                    constraints: BoxConstraints(),
                                                    child: FittedBox(
                                                      child: Text(
                                                            'Saudi arabia',
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                          color: Colors.white,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  ),

                                                  Container(
                                                    width: 80,
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
                                                ],
                                              ),


                                            ],
                                          ),
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
                        width: screenWidth * 0.65,
                        padding: const EdgeInsets.all(10.0),
                        child: GestureDetector(
                          onTap: () {},
                          child: InkWell(
                            borderRadius: BorderRadius.circular(4.0),
                            onTap: () {},
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7.0),
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
                                                  BorderRadius.circular(7.0)),
                                            ),
                                            child: Image.asset(
                                              'assets/images/c1.jpg',
                                              fit: BoxFit.fill,
                                              height: screenHeight * 0.24,
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
                                                    height: 20,
                                                    padding:
                                                    const EdgeInsets.all(0.0),
                                                    margin: EdgeInsets.only(
                                                        top: screenHeight * 0.15),
                                                    constraints: BoxConstraints(),
                                                    child: FittedBox(
                                                      child: Text(
                                                        getTranslated(context,
                                                            'home_offer_card_city'),
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                          color: Colors.white,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  ),

                                                  Container(
                                                    width: 80,
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
                                                ],
                                              ),


                                            ],
                                          ),
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
                  ),
                  Column(
                    children: [
                      Container(
                        width: screenWidth * 0.65,
                        padding: const EdgeInsets.all(10.0),
                        child: GestureDetector(
                          onTap: () {},
                          child: InkWell(
                            borderRadius: BorderRadius.circular(4.0),
                            onTap: () {},
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7.0),
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
                                                  BorderRadius.circular(7.0)),
                                            ),
                                            child: Image.asset(
                                              'assets/images/c3.jpg',
                                              fit: BoxFit.fill,
                                              height: screenHeight * 0.24,
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
                                                    height: 20,
                                                    padding:
                                                    const EdgeInsets.all(0.0),
                                                    margin: EdgeInsets.only(
                                                        top: screenHeight * 0.15),
                                                    constraints: BoxConstraints(),
                                                    child: FittedBox(
                                                      child: Text(
                                                            'Saudi arabia',
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                          color: Colors.white,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  ),

                                                  Container(
                                                    width: 80,
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
                                                ],
                                              ),


                                            ],
                                          ),
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
                        width: screenWidth * 0.65,
                        padding: const EdgeInsets.all(10.0),
                        child: GestureDetector(
                          onTap: () {},
                          child: InkWell(
                            borderRadius: BorderRadius.circular(4.0),
                            onTap: () {},
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7.0),
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
                                                  BorderRadius.circular(7.0)),
                                            ),
                                            child: Image.asset(
                                              'assets/images/c1.jpg',
                                              fit: BoxFit.fill,
                                              height: screenHeight * 0.24,
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
                                                    height: 20,
                                                    padding:
                                                    const EdgeInsets.all(0.0),
                                                    margin: EdgeInsets.only(
                                                        top: screenHeight * 0.15),
                                                    constraints: BoxConstraints(),
                                                    child: FittedBox(
                                                      child: Text(
                                                        getTranslated(context,
                                                            'home_offer_card_city'),
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                          color: Colors.white,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  ),

                                                  Container(
                                                    width: 80,
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
                                                ],
                                              ),


                                            ],
                                          ),
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
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
