import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:ipackage/localization/localizationValues.dart';
import 'package:ipackage/widgets/users/login.dart';


class New_account extends StatefulWidget {
  @override
  _New_account createState() => _New_account();
}

class _New_account extends State<New_account> {

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
                Text(getTranslated(context, 'new_account'),style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,fontFamily: 'cairo',),textAlign: TextAlign.center,),

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

                    Text(getTranslated(context, 'login_email_hint'),style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,fontFamily: 'cairo',),textAlign: TextAlign.right,),
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
                    SizedBox(height: 10,),

                    Text(getTranslated(context, 'settings_conf_password_label'),style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,fontFamily: 'cairo',),textAlign: TextAlign.right,),
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
                    SizedBox(height: 40,),

                    GFButton(
                      color: Color(0xff07898b),
                      textColor: Colors.white,
                      fullWidthButton: true,
                      text: getTranslated(context, 'login_new_account_btn'),
                      size: 50.0,
                      textStyle: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'cairo',
                      ),
                      onPressed: () {

                      },
                    ),

                    TextButton(
                      child: Text(getTranslated(context, 'drawer_login')),
                      style: TextButton.styleFrom(
                        primary: Colors.black,

                        textStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'cairo',

                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(new MaterialPageRoute(
                            builder: (BuildContext context) => new login()));
                      },
                    )


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
