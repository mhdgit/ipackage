import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:ipackage/localization/localizationValues.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
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
          getTranslated(context, 'notifications'),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              for (int i = 0; i < 6; i++)
                Container(
                    width: screenWidth * 0.9,
                    padding:
                        EdgeInsetsDirectional.only(top: 5.0, bottom: 5.0),
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
                                        width: screenWidth * 0.35,
                                        child: FittedBox(
                                          alignment:
                                              AlignmentDirectional.centerStart,
                                          fit: BoxFit.scaleDown,
                                          child: Text(
                                            getTranslated(
                                                context, 'notification_name'),
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
                                      Container(
                                        width: screenWidth * 0.35,
                                        child: FittedBox(
                                          alignment:
                                              AlignmentDirectional.centerStart,
                                          fit: BoxFit.scaleDown,
                                          child: Text(
                                            getTranslated(context,
                                                'notification_content'),
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
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
                        subtitle: Text(
                          getTranslated(context, 'notification_content_2'),
                        ),
                      ),
                    )),
            ],
          ),
        ),
      ),
    );
  }
}
