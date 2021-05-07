import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:ipackage/localization/localizationValues.dart';
import 'package:ipackage/modules/my_icons.dart';
import 'package:ipackage/widgets/home/home.dart';
import 'package:ipackage/widgets/users/reset_pass.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'new_account.dart';


class login extends StatefulWidget {
  @override
  _login createState() => _login();
}

class _login extends State<login> {
  bool _is_btn_Loading = false;
  final email_Controller = TextEditingController();
  final pass_Controller = TextEditingController();

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
                            Text(getTranslated(context, 'login_name_hint'),style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,fontFamily: 'cairo',),textAlign: TextAlign.right,),
                            SizedBox(height: 5,),
                            TextField(
                              controller: email_Controller,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(5.0),
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

                            Text(getTranslated(context, 'login_password_hint'),style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,fontFamily: 'cairo',),textAlign: TextAlign.right,),
                            SizedBox(height: 5,),
                            TextField(
                              controller: pass_Controller,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(5.0),
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
                            login_button(),
                            /*GFButton(
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
                            ),*/

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center ,//Center Column contents vertically,

                              children: [
                                Text(getTranslated(context, 'You do not have an account'),
                                  style: TextStyle(fontSize: 16,
                                    fontFamily: 'cairo',),),

                                //SizedBox(width: 5,),
                                TextButton(
                                  child: Text(
                                      getTranslated(context, 'new_account')),
                                  style: TextButton.styleFrom(
                                    primary: Color(0xff07898b),

                                    textStyle: TextStyle(
                                      color: Color(0xff07898b),
                                      fontSize: 16,
                                      fontFamily: 'cairo',

                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        new MaterialPageRoute(
                                            builder: (
                                                BuildContext context) => new New_account()));
                                  },
                                ),
                              ],
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
                                icon: Icon(MyIcons.facebook_square,color: Color(0xff264696),size: 30,),
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
                                icon: Icon(MyIcons.google,color: Colors.red,size: 30,),
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
                                label: Text(getTranslated(context, 'login_twitter_btn'),textAlign: TextAlign.center,),
                                icon: Icon(MyIcons.twitter_square,color: Color(0xff4aa1eb),size: 30,),
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
                                label: Text(getTranslated(context, 'login_apple_btn'),textAlign: TextAlign.center,),
                                icon: Icon(MyIcons.apple,color: Colors.black,size: 30,),
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

  void _handleLogin() async {
    setState(() {
      _is_btn_Loading = true;
    });

    if (email_Controller.text == "" || email_Controller.text == null) {
      //_showDialog("يرجى إدخال اسم الشركة");
      _show_alert(context, getTranslated(context, 'Wrong_data'), getTranslated(context, 'Please enter an email'));
      setState(() {
        _is_btn_Loading = false;
      });
      return;
    } else if (pass_Controller.text == "" || pass_Controller.text == null) {
      //_showDialog("يرجى إدخال اسم الشركة");
      _show_alert(context, getTranslated(context, 'Wrong_data'), getTranslated(context, 'Please enter the password'));
      setState(() {
        _is_btn_Loading = false;
      });
      return;
    } else{

      Uri uri = Uri.parse('https://ipackagetours.com/api/login');
      final response = await http.post(uri,
          body: {
            'email': email_Controller.text,
            'password': pass_Controller.text,
          });
      var status = response.body.contains('error');

      var data = json.decode(response.body);

      if (status) {

        _show_alert(context, '', getTranslated(context, 'Wrong_data'));
        setState(() {
          _is_btn_Loading = false;
        });
      }else{
        setState(() {
          _is_btn_Loading = false;
        });
        _saveUserData(data['user']['id'],data['user']['key'],data['user']['name'],data['user']['email'],
            data['user']['nationality'],data['user']['phone'],data['user']['api_token']);

        Navigator.of(context).push(
          new MaterialPageRoute(builder: (BuildContext context) => new Home()),
        );

      }
    }
  }

  Widget login_button() {
    return InkWell(
      onTap: _handleLogin,
      child: Container(
        height: 50,
        margin: EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 5,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xff07898b),
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                alignment: Alignment.center,
                child: _is_btn_Loading ? CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ) :Text(getTranslated(context, 'drawer_login'),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: "Cairo",
                        fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _saveUserData(int userId, String key, String name, String email, int nationality, String phone, String api_token) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'is_login';
    final value = "1";
    prefs.setString(key, value);

    final key1 = 'user_id';
    final value1 = userId;
    prefs.setInt(key1, value1);

    final key2 = 'name';
    final value2 = name;
    prefs.setString(key2, value2);

    final key3 = 'key';
    final value3 = key;
    prefs.setString(key3, value3);

    final key4 = 'email';
    final value4 = email;
    prefs.setString(key4, value4);

    final key5 = 'nationality';
    final value5 = nationality.toString();
    prefs.setString(key5, value5);

    final key6 = 'phone';
    final value6 = phone;
    prefs.setString(key6, value6);

    final key7 = 'api_token';
    final value7 = api_token;
    prefs.setString(key7, value7);
  }


  _show_alert(context, String text, String des) {
    Alert(
      context: context,
      type: AlertType.warning,
      title: text,
      desc: des,
      alertAnimation: fadeAlertAnimation,
      buttons: [
        DialogButton(
          child: Text(
            "OK",
            style: TextStyle(color: Colors.white,fontFamily: 'Cairo', fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          color: Color(0xff07898b),
          radius: BorderRadius.circular(3.0),
        ),
      ],
    ).show();
  }

  Widget fadeAlertAnimation(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child,) {
    return Align(
      child: FadeTransition(
        opacity: animation,
        child: child,
      ),
    );
  }

}
