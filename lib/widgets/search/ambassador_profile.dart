import 'package:flutter/material.dart';
import 'package:ipackage/localization/localizationValues.dart';
import 'package:ipackage/widgets/search/ambassador_add_service.dart';

class AmbassadorProfile extends StatefulWidget {
  @override
  _AmbassadorProfileState createState() => _AmbassadorProfileState();
}

class _AmbassadorProfileState extends State<AmbassadorProfile> {

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final double screenHeight =
        MediaQuery.of(context).size.height - statusBarHeight - kToolbarHeight;
    final double screenWidth = MediaQuery.of(context).size.width;


    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xff77BEC0),
        elevation: 0.0,
        shadowColor: Colors.white,
        title: Text(
          getTranslated(context, 'as_agent_name'),
        ),
        actions: [
          IconButton(icon: Icon(Icons.mail_outline , color: Colors.black,), onPressed: (){}),
          IconButton(icon: Icon(Icons.notifications_outlined , color: Colors.black,), onPressed: (){}),
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            Container(
              width: screenWidth,
              color: Color(0xffE9F7F8),
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: InkWell(
                onTap: (){
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (BuildContext context) => new AmbassadorAddService()));
                },
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 10,
                      child: Icon(
                        Icons.add_circle_outline,
                        color: Colors.black,
                      ),
                    ),
                    Expanded(
                      flex: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          getTranslated(context, 'ambassador_profile_add_btn'),
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 50,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          ' ',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ),
            Container(
              height: screenHeight * 0.35,
              padding: EdgeInsets.symmetric(vertical: screenHeight * 0.03),
              child: FittedBox(
                child: CircleAvatar(
                  radius: 30,
                  backgroundImage:
                  AssetImage('assets/images/profile.jpg',),
                ),
              ),
            ),
            Container(
              width: screenWidth * 0.9,
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 33,
                    child: FittedBox(
                      alignment: AlignmentDirectional.center,
                      fit: BoxFit.scaleDown,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          getTranslated(context, 'ambassador_profile_name'),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 33,
                    child: FittedBox(
                      alignment: AlignmentDirectional.center,
                      fit: BoxFit.scaleDown,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          getTranslated(context, 'ambassador_profile_agents'),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 33,
                    child: FittedBox(
                      alignment: AlignmentDirectional.center,
                      fit: BoxFit.scaleDown,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          getTranslated(context, 'ambassador_profile_level'),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: screenWidth * 0.9,
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 33,
                    child: FittedBox(
                      alignment: AlignmentDirectional.center,
                      fit: BoxFit.scaleDown,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          getTranslated(context, 'do_comments_username'),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 33,
                    child: FittedBox(
                      alignment: AlignmentDirectional.center,
                      fit: BoxFit.scaleDown,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          '17',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 33,
                    child: FittedBox(
                      alignment: AlignmentDirectional.center,
                      fit: BoxFit.scaleDown,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          '100%',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: screenWidth * 0.8,
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 50,
                    child: FittedBox(
                      alignment: AlignmentDirectional.center,
                      fit: BoxFit.scaleDown,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          getTranslated(context, 'ambassador_profile_speed'),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 50,
                    child: FittedBox(
                      alignment: AlignmentDirectional.center,
                      fit: BoxFit.scaleDown,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          getTranslated(context, 'ambassador_profile_last_check'),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: screenWidth * 0.8,
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 50,
                    child: FittedBox(
                      alignment: AlignmentDirectional.center,
                      fit: BoxFit.scaleDown,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          getTranslated(context, 'ambassador_profile_speed_value'),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 50,
                    child: FittedBox(
                      alignment: AlignmentDirectional.center,
                      fit: BoxFit.scaleDown,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          getTranslated(context, 'ambassador_profile_last_check_value'),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
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
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Divider(
                color: Colors.black,
                thickness: 2,
              ),
            ),

          ],
        ),
      ),
    );
  }
}
