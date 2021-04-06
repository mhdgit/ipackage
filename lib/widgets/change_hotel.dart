import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:ipackage/localization/localizationValues.dart';
import 'package:ipackage/widgets/hotel_details.dart';

class ChangeHotel extends StatefulWidget {
  @override
  _ChangeHotelState createState() => _ChangeHotelState();
}

class _ChangeHotelState extends State<ChangeHotel> {

  _hotelsWidget(width, height) {
    return Container(
      width: width * 0.84,
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: GestureDetector(
        onTap: () {},
        child: InkWell(
          borderRadius: BorderRadius.circular(4.0),
          onTap: () {
            Navigator.of(context).push(new MaterialPageRoute(
                builder: (BuildContext context) => new HotelDetails()));
          },
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
    );
  }

  @override
  Widget build(BuildContext context) {

    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final double screenHeight =
        MediaQuery.of(context).size.height - statusBarHeight - kToolbarHeight;
    final double screenWidth = MediaQuery.of(context).size.width;


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffE9F7F8),
        elevation: 0.0,
        shadowColor: Colors.white,
        title: Text(
          getTranslated(context, 'change_hotel'),
        ),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        child: Center(
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
                    onTap: () {
                      Navigator.of(context).push(new MaterialPageRoute(
                          builder: (BuildContext context) => new HotelDetails()));
                    },
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
                                height: screenHeight * 0.28,
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
              _hotelsWidget(screenWidth, screenHeight),

            ],
          ),
        ),
      ),
    );
  }
}
