import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:ipackage/localization/localizationValues.dart';
import 'package:ipackage/widgets/hotel_details.dart';

class ChangeHotelRoom extends StatefulWidget {
  @override
  _ChangeHotelRoomState createState() => _ChangeHotelRoomState();
}

class _ChangeHotelRoomState extends State<ChangeHotelRoom> {


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
          getTranslated(context, 'change_hotel_room'),
        ),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            for(int index = 0 ; index < 5 ; index++)
              Row(
                children: [
                  Container(
                    width: screenWidth * 0.9,
                    margin: EdgeInsetsDirectional.only(
                        start: screenWidth * 0.08, top: 5.0, bottom: 10.0),
                    child: Card(
                      elevation: 2.0,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 35,
                            child: ClipRRect(
                              borderRadius: BorderRadius.all(
                                Radius.circular(3.0),
                              ),
                              child: Image.asset('assets/images/bedroom.jpg',
                                  fit: BoxFit.cover, width: screenWidth * 0.1 , height: screenHeight * 0.15,),
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
                                      backgroundColor: Color(0xff07898B),
                                    ),
                                    onPressed: () {},
                                    child: Center(
                                        child: Icon(
                                          Icons.add,
                                          color: Colors.white,
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
          ],
        ),
      ),
    );
  }
}
