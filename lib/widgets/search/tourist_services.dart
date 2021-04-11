import 'package:flutter/material.dart';
import 'package:ipackage/localization/localizationValues.dart';
import 'package:ipackage/widgets/chats/chats.dart';
import 'package:ipackage/widgets/notifications.dart';
import 'package:ipackage/widgets/search/ambassador_service_main.dart';
import 'package:ipackage/widgets/search/tourist_service_main.dart';

class TouristServices extends StatefulWidget {
  @override
  _TouristServicesState createState() => _TouristServicesState();
}

class _TouristServicesState extends State<TouristServices> {

  @override
  Widget build(BuildContext context) {

    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final double screenHeight =
        MediaQuery.of(context).size.height - statusBarHeight - kToolbarHeight;
    final double screenWidth = MediaQuery.of(context).size.width;


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff77BEC0),
        elevation: 0.0,
        shadowColor: Colors.white,
        title: Text(
          getTranslated(context, 'ambassadors_services'),
        ),
        actions: [
          IconButton(icon: Icon(Icons.mail_outline , color: Colors.black,), onPressed: (){
            Navigator.of(context).push(new MaterialPageRoute(
                builder: (BuildContext context) => new Chats()));
          }),
          IconButton(icon: Icon(Icons.notifications_outlined , color: Colors.black,), onPressed: (){
            Navigator.of(context).push(new MaterialPageRoute(
                builder: (BuildContext context) => new Notifications()));
          }),
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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              for(int index = 0 ; index < 6 ; index++)
                Container(
                  width: screenWidth * 0.84,
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: GestureDetector(
                    onTap: () {},
                    child: InkWell(
                      borderRadius: BorderRadius.circular(4.0),
                      onTap: () {
                        Navigator.of(context).push(new MaterialPageRoute(
                            builder: (BuildContext context) => new TouristServiceMain()));
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
                            Container(
                              // color: Colors.white,
                              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 45,
                                    child: FittedBox(
                                      fit: BoxFit.none,
                                      alignment: AlignmentDirectional.centerStart,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 0.0,
                                            right: 0.0,
                                            left: 0.0,
                                            bottom: 0.0),
                                        child: Text(
                                          getTranslated(context, 'tourist_services_username'),
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                              color: Colors.black),
                                        ),),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 55,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 0.0,
                                          right: 0.0,
                                          left: 0.0,
                                          bottom: 0.0),
                                      child: Text(
                                        '220\$',
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Colors.black),
                                      ),),
                                  ),
                                ],
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsetsDirectional.only(start: 16.0),
                              child: Text(
                                getTranslated(context, 'tourist_services_request'),
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                                softWrap: true,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.only(start: 16.0),
                              child: Text(
                                getTranslated(context, 'tourist_services_request'),
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                                softWrap: true,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.only(start: 16.0),
                              child: Text(
                                getTranslated(context, 'tourist_services_request'),
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                                softWrap: true,
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
      ),
    );
  }
}
