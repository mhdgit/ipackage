import 'package:flutter/material.dart';
import 'package:ipackage/localization/localizationValues.dart';

class ChangeFlight extends StatefulWidget {
  @override
  _ChangeFlightState createState() => _ChangeFlightState();
}

class _ChangeFlightState extends State<ChangeFlight> {

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
          getTranslated(context, 'change_flight'),
        ),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[

            for(int index = 0 ; index < 5 ; index++)
              Container(
                margin: EdgeInsetsDirectional.only(top: 5.0, bottom: 5.0 , start: 10.0, end: 10.0),
                child: Card(
                  elevation: 2.0,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 33,
                            child: Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Container(
                                        padding: EdgeInsets.all(2.0),
                                        width: 25,
                                        height: 25,
                                        decoration: BoxDecoration(
                                          color: Color(0xffFFCECF),
                                          borderRadius: BorderRadius.circular(50),
                                          border: Border.all(
                                            width: 3,
                                            color: Colors.redAccent,
                                            style: BorderStyle.solid,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Text(
                                        'JED',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      '15:12:00',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black38,
                                      ),
                                      textAlign: TextAlign.end,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 33,
                            child: Column(
                              children: <Widget>[
                                Icon(Icons.flight, color: Color(0xff07898B),),
                                Text(
                                  '15:12:00',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black38,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 33,
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Container(
                                        padding: EdgeInsets.all(2.0),
                                        width: 25,
                                        height: 25,
                                        decoration: BoxDecoration(
                                          color: Color(0xffFFCECF),
                                          borderRadius: BorderRadius.circular(50),
                                          border: Border.all(
                                            width: 3,
                                            color: Colors.redAccent,
                                            style: BorderStyle.solid,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Text(
                                        'JED',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    )
                                  ],
                                ),
                                Text(
                                  '15:12:00',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black38,
                                  ),
                                  textAlign: TextAlign.end,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 33,
                            child: Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Container(
                                        padding: EdgeInsets.all(2.0),
                                        width: 25,
                                        height: 25,
                                        decoration: BoxDecoration(
                                          color: Color(0xffFFCECF),
                                          borderRadius: BorderRadius.circular(50),
                                          border: Border.all(
                                            width: 3,
                                            color: Colors.redAccent,
                                            style: BorderStyle.solid,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Text(
                                        'JED',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      '15:12:00',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black38,
                                      ),
                                      textAlign: TextAlign.end,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 33,
                            child: Column(
                              children: <Widget>[
                                Icon(Icons.flight, color: Color(0xff07898B),),
                                Text(
                                  '15:12:00',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black38,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 33,
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Container(
                                        padding: EdgeInsets.all(2.0),
                                        width: 25,
                                        height: 25,
                                        decoration: BoxDecoration(
                                          color: Color(0xffFFCECF),
                                          borderRadius: BorderRadius.circular(50),
                                          border: Border.all(
                                            width: 3,
                                            color: Colors.redAccent,
                                            style: BorderStyle.solid,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Text(
                                        'JED',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    )
                                  ],
                                ),
                                Text(
                                  '15:12:00',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black38,
                                  ),
                                  textAlign: TextAlign.end,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: screenWidth * 0.4,
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
                                ),),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
