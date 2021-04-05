import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:image_viewer/image_viewer.dart';
import 'package:ipackage/localization/localizationValues.dart';
import 'package:ipackage/widgets/change_hotel_room.dart';

class HotelDetails extends StatefulWidget {
  @override
  _HotelDetailsState createState() => _HotelDetailsState();
}

class _HotelDetailsState extends State<HotelDetails> {
  int carouselIndex;
  List<String> imageList = [
    'assets/images/hotel.jpg',
    'assets/images/c3.jpg',
    'assets/images/c1.jpg',
    'assets/images/c1.jpg',
    'assets/images/c3.jpg',
    'assets/images/c4.jpg',
  ];

  List<String> hotelAssets = [
    'تكون النظافة بمستوى عالي',
    'توفر إطلالة رائعة على البحر',
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
                                      height: height * 0.05,
                                      child: FittedBox(
                                        alignment: AlignmentDirectional.centerStart,
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
                                        alignment: AlignmentDirectional.centerStart,
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

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        shadowColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            GFCarousel(
              enlargeMainPage: true,
              viewportFraction: 1.0,
              autoPlay: true,
              pagination: true,
              activeIndicator: Color(0xff07898B),
              items: imageList.map(
                (url) {
                  return Container(
                    margin: EdgeInsets.all(0.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      child: InkWell(
                        onTap: () {
                          ImageViewer.showImageSlider(
                            images: imageList,
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
            Row(
              children: [
                Container(
                  width: screenWidth * 0.84,
                  padding: EdgeInsetsDirectional.only(
                      start: screenWidth * 0.08, top: 20.0, bottom: 5.0),
                  child: Row(
                    children: [
                      Flexible(
                        child: Text(
                          getTranslated(context, 'hotel_details_label'),
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
            Row(
              children: [
                Container(
                  width: screenWidth * 0.84,
                  padding: EdgeInsetsDirectional.only(
                      start: screenWidth * 0.1, top: 5.0, bottom: 5.0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 40,
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
                        flex: 60,
                        child: Text(
                          ' ',
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
            Row(
              children: [
                Container(
                  width: screenWidth * 0.84,
                  padding: EdgeInsetsDirectional.only(
                      start: screenWidth * 0.08, top: 5.0, bottom: 5.0),
                  child: Row(
                    children: [
                      Flexible(
                        child: Text(
                          getTranslated(context, 'hotel_details_label_2'),
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
            Row(
              children: [
                Container(
                  width: screenWidth * 0.9,
                  padding: EdgeInsetsDirectional.only(
                      start: screenWidth * 0.08, top: 10.0, bottom: 10.0),
                  child: Row(
                    children: [
                      Flexible(
                        child: Text(
                          getTranslated(context, 'hotel_details_label_3'),
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 14,
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
                      start: screenWidth * 0.08, top: 20.0, bottom: 10.0),
                  child: Row(
                    children: [
                      Flexible(
                        child: Text(
                          getTranslated(context, 'hotel_details_room'),
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
            Row(
              children: [
                Container(
                  width: screenWidth * 0.84,
                  margin: EdgeInsetsDirectional.only(
                      start: screenWidth * 0.08, top: 5.0, bottom: 10.0),
                  child: Card(
                    elevation: 2.0,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 35,
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(3.0),
                              bottomRight: Radius.circular(3.0),
                            ),
                            child: Image.asset('assets/images/bedroom.jpg',
                                fit: BoxFit.cover, width: screenWidth * 0.1),
                          ),
                        ),
                        Expanded(
                          flex: 50,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: screenWidth * 0.025),
                            child: FittedBox(
                              child: Text(
                                getTranslated(context, 'hotel_details_room_2'),
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 15,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    backgroundColor: Color(0xffBBDEE0),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).push(new MaterialPageRoute(
                                        builder: (BuildContext context) => new ChangeHotelRoom()));
                                  },
                                  child: Center(
                                      child: Icon(
                                    Icons.edit,
                                    size: 13,
                                  )),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
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
                      start: screenWidth * 0.08, top: 20.0, bottom: 10.0),
                  child: Row(
                    children: [
                      Flexible(
                        child: Text(
                          getTranslated(context, 'hotel_details_room_3'),
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
            Row(
              children: [
                Container(
                  width: screenWidth * 0.84,
                  // decoration: BoxDecoration(
                  //     border: Border.all(color: Colors.grey, width: 1),
                  //     borderRadius: BorderRadius.all(
                  //       Radius.circular(3.0),
                  //     )),
                  margin: EdgeInsetsDirectional.only(
                      start: screenWidth * 0.08, top: 10.0, bottom: 10.0),
                  child: Card(
                    elevation: 2.0,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: screenHeight * 0.03,horizontal: screenWidth * 0.02),
                      child: Column(
                        children: <Widget>[
                          for(int index = 0 ; index < hotelAssets.length ; index++)
                          Row(
                            children: <Widget>[
                              Expanded(
                                flex: 10,
                                child: Icon(
                                  Icons.check,
                                  color: Color(0xff07898B),
                                  size: 15,
                                ),
                              ),
                              Expanded(
                                flex:90,
                                child: Row(
                                  children: [
                                    Flexible(
                                      child: Text(
                                        hotelAssets[index].toString(),
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontSize: 14,
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
                          getTranslated(context, 'do_comments'),
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
            _commentsWidget(screenWidth, screenHeight),
          ],
        ),
      ),
    );
  }
}
