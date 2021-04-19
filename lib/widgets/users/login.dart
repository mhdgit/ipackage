import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:ipackage/localization/localizationValues.dart';
import 'package:ipackage/modules/my_icons.dart';
import 'package:ipackage/widgets/users/reset_pass.dart';


class login extends StatefulWidget {
  @override
  _login createState() => _login();
}

class _login extends State<login> {

  @override
  Widget build(BuildContext context) {

    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final double screenHeight =
        MediaQuery.of(context).size.height - statusBarHeight - kToolbarHeight;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(

        body: Container(
            child: SingleChildScrollView(
                child: Column(
                    children: <Widget>[

                      Image.asset(
                        'assets/images/users/i1.png',
                        fit: BoxFit.fill,
                        height: screenHeight * 0.30,
                        width: screenWidth,
                      ),
                      SizedBox(height: 10,),
                      Text(getTranslated(context, 'drawer_login'),style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,fontFamily: 'cairo',),textAlign: TextAlign.center,),

                      Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10,),
                            Text(getTranslated(context, 'login_name_hint'),style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,fontFamily: 'cairo',),textAlign: TextAlign.right,),
                            SizedBox(height: 5,),
                            TextField(
                              decoration: InputDecoration(
                                border: new OutlineInputBorder(
                                    borderSide: new BorderSide(color: Colors.black)),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.black, width: 0.0),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.black, width: 0.0),
                                ),
                              ),
                              style: TextStyle(
                                fontFamily: 'CustomIcons',
                              ),
                              //controller: _usernameController,
                            ),
                            SizedBox(height: 10,),

                            Text(getTranslated(context, 'login_password_hint'),style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,fontFamily: 'cairo',),textAlign: TextAlign.right,),
                            SizedBox(height: 5,),
                            TextField(
                              decoration: InputDecoration(
                                border: new OutlineInputBorder(
                                    borderSide: new BorderSide(color: Colors.black)),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.black, width: 0.0),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.black, width: 0.0),
                                ),
                              ),
                              style: TextStyle(
                                fontFamily: 'CustomIcons',
                              ),
                              //controller: _usernameController,
                            ),
                            SizedBox(height: 20,),

                            TextButton(
                              child: Text(getTranslated(context, 'login_reset_pass_main')),
                              style: TextButton.styleFrom(
                                primary: Colors.black,

                                textStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontFamily: 'cairo',
                                  decoration: TextDecoration.underline,
                                ),

                              ),
                              onPressed: () {
                                Navigator.of(context).push(new MaterialPageRoute(
                                    builder: (BuildContext context) => new reset_pass()));
                              },
                            ),

                            GFButton(
                              color: Color(0xff07898b),
                              textColor: Colors.white,
                              fullWidthButton: true,
                              text: getTranslated(context, 'drawer_login'),
                              size: 50.0,
                              textStyle: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'cairo',
                              ),
                              onPressed: () {

                              },
                            ),

                            SizedBox(height: 10,),
                            Center(
                              child:Text(getTranslated(context, 'OR_hint'),style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,fontFamily: 'cairo',),textAlign: TextAlign.center,),
                            ),
                            SizedBox(height: 10,),

                            SizedBox(
                          width: double.infinity,
                          child:TextButton.icon(
                              label: Text(getTranslated(context, 'login_facebook'),textAlign: TextAlign.center,),
                              icon: Icon(MyIcons.facebook_square,color: Color(0xff07898b),),
                              style: TextButton.styleFrom(

                                primary: Colors.black,

                                textStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontFamily: 'cairo',

                                ),

                                side: BorderSide(color: Color(0xff07898b), width: 1),

                              ),
                              onPressed: () {
                                print('Pressed');
                              },
                            ),),
                            SizedBox(height: 10,),
                            SizedBox(
                              width: double.infinity,
                              child:TextButton.icon(
                                label: Text(getTranslated(context, 'login_google'),textAlign: TextAlign.center,),
                                icon: Icon(MyIcons.google,color: Color(0xff07898b),),
                                style: TextButton.styleFrom(

                                  primary: Colors.black,

                                  textStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontFamily: 'cairo',

                                  ),

                                  side: BorderSide(color: Color(0xff07898b), width: 1),

                                ),
                                onPressed: () {
                                  print('Pressed');
                                },
                              ),),





                          ],
                        ),
                      ),
                    ]
                )
            )
        )
    );
  }
}
