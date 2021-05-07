import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:ipackage/api/accounts_api.dart';
import 'package:ipackage/localization/localizationValues.dart';
import 'package:ipackage/modules/BetaApiAssistant.dart';
import 'package:ipackage/modules/LocalAssistant.dart';
import 'package:ipackage/modules/my_icons.dart';
import 'package:ipackage/modules/nationalities.dart';
import 'package:ipackage/widgets/home/home.dart';
import 'package:ipackage/widgets/users/login.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class New_account extends StatefulWidget {
  @override
  _New_account createState() => _New_account();
}

class _New_account extends State<New_account> {


  List _nationalities = [];
  AccountsApi _AccountsApi = new AccountsApi();
  LocalAssistant localAssistant = new LocalAssistant();
  bool _isLoading = true;
  bool _is_btn_Loading = false;
  String _mySelection;
  String national_Selection;

  final name_Controller = TextEditingController();
  final email_Controller = TextEditingController();
  final pass1_Controller = TextEditingController();
  final pass2_Controller = TextEditingController();
  final phone_Controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    _AccountsApi.get_nationalities().then((value) {
      setState(() {
        print(value['data'].toString());
        _nationalities = List.of(value['data']);

        _isLoading = false;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery
        .of(context)
        .padding
        .top;
    final double screenHeight =
        MediaQuery
            .of(context)
            .size
            .height - statusBarHeight - kToolbarHeight;
    final double screenWidth = MediaQuery
        .of(context)
        .size
        .width;

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
                      Text(getTranslated(context, 'new_account'),
                        style: TextStyle(fontSize: 24,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'cairo',), textAlign: TextAlign.center,),

                      Padding(
                        padding: const EdgeInsets.only(top: 10.0,left: 30,right: 30,bottom: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10,),
                            Text(getTranslated(context, 'login_name_hint'),
                              style: TextStyle(fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'cairo',),
                              textAlign: TextAlign.right,),
                            SizedBox(height: 5,),
                            TextField(

                              controller: name_Controller,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(5.0),
                                border: new OutlineInputBorder(
                                    borderSide: new BorderSide(color: Colors
                                        .black)),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors
                                      .black, width: 0.0),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors
                                      .black, width: 0.0),
                                ),
                              ),
                              style: TextStyle(
                                fontFamily: 'cairo',
                              ),
                              //controller: _usernameController,
                            ),
                            SizedBox(height: 10,),

                            Text(getTranslated(context, 'login_email_hint'),
                              style: TextStyle(fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'cairo',),
                              textAlign: TextAlign.right,),
                            SizedBox(height: 5,),
                            TextField(
                              controller: email_Controller,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(5.0),
                                border: new OutlineInputBorder(
                                    borderSide: new BorderSide(color: Colors
                                        .black)),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors
                                      .black, width: 0.0),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors
                                      .black, width: 0.0),
                                ),
                              ),
                              style: TextStyle(
                                fontFamily: 'cairo',
                              ),
                              //controller: _usernameController,
                            ),
                            SizedBox(height: 10,),

                            Text(getTranslated(context, 'login_password_hint'),
                              style: TextStyle(fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'cairo',),
                              textAlign: TextAlign.right,),
                            SizedBox(height: 5,),
                            TextField(
                              controller: pass1_Controller,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(5.0),
                                border: new OutlineInputBorder(
                                    borderSide: new BorderSide(color: Colors
                                        .black)),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors
                                      .black, width: 0.0),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors
                                      .black, width: 0.0),
                                ),
                              ),
                              style: TextStyle(
                                fontFamily: 'cairo',
                              ),
                              //controller: _usernameController,
                            ),
                            SizedBox(height: 10,),

                            Text(getTranslated(
                                context, 'settings_conf_password_label'),
                              style: TextStyle(fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'cairo',),
                              textAlign: TextAlign.right,),
                            SizedBox(height: 5,),
                            TextField(
                              controller: pass2_Controller,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(5.0),
                                border: new OutlineInputBorder(
                                    borderSide: new BorderSide(color: Colors
                                        .black)),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors
                                      .black, width: 0.0),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors
                                      .black, width: 0.0),
                                ),
                              ),
                              style: TextStyle(
                                fontFamily: 'cairo',
                              ),
                              //controller: _usernameController,
                            ),
                            SizedBox(height: 10,),


                            Text(
                              getTranslated(context, 'Selectـtheـcountryـkey'),
                              style: TextStyle(fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'cairo',),
                              textAlign: TextAlign.right,),
                            SizedBox(height: 5,),
                            DropdownButtonFormField(
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(5.0),
                                border: new OutlineInputBorder(
                                    borderSide: new BorderSide(color: Colors
                                        .black)),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors
                                      .black, width: 0.0),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors
                                      .black, width: 0.0),
                                ),
                              ),
                              isExpanded: true,
                              hint: Text("اختر مفتاح الدولة",
                                textAlign: TextAlign.right,
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  //fontWeight: FontWeight.w600,
                                  fontFamily: "cairo",
                                ),),

                              items: _nationalities.map((item) {
                                //_mycitySelection = item['city_id'].toString();
                                return new DropdownMenuItem(
                                  child: new Text(
                                      item['phone'] + ' ' + item['name_ar'],
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        //fontWeight: FontWeight.w600,
                                        fontFamily: "cairo",
                                      )),
                                  value: item['id'].toString(),
                                );
                              }).toList(),
                              onChanged: (newVal) {
                                setState(() {
                                  _mySelection = newVal;
                                  //print(_mycitySelection);
                                });
                              },
                              value: _mySelection,

                            ),
                            SizedBox(height: 10,),

                            Text(getTranslated(context, 'MobileـPhoneـNumber'),
                              style: TextStyle(fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'cairo',),
                              textAlign: TextAlign.right,),
                            SizedBox(height: 5,),
                            TextField(
                              controller: phone_Controller,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(5.0),
                                border: new OutlineInputBorder(
                                    borderSide: new BorderSide(color: Colors
                                        .black)),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors
                                      .black, width: 0.0),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors
                                      .black, width: 0.0),
                                ),
                              ),
                              style: TextStyle(
                                fontFamily: 'cairo',
                              ),
                              //controller: _usernameController,
                            ),
                            SizedBox(height: 10,),

                            Text(getTranslated(context, 'Nationality'),
                              style: TextStyle(fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'cairo',),
                              textAlign: TextAlign.right,),
                            SizedBox(height: 5,),
                            DropdownButtonFormField(
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(5.0),
                                border: new OutlineInputBorder(
                                    borderSide: new BorderSide(color: Colors
                                        .black)),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors
                                      .black, width: 0.0),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors
                                      .black, width: 0.0),
                                ),
                              ),
                              isExpanded: true,
                              hint: Text("حدد الجنسية",
                                textAlign: TextAlign.right,
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  //fontWeight: FontWeight.w600,
                                  fontFamily: "cairo",
                                ),),

                              items: _nationalities.map((item) {
                                //_mycitySelection = item['city_id'].toString();
                                return new DropdownMenuItem(
                                  child: new Text(
                                      item['name_ar'], style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    //fontWeight: FontWeight.w600,
                                    fontFamily: "cairo",
                                  )),
                                  value: item['id'].toString(),
                                );
                              }).toList(),
                              onChanged: (newVal) {
                                setState(() {
                                  national_Selection = newVal;
                                  //print(_mycitySelection);
                                });
                              },
                              value: national_Selection,

                            ),

                            SizedBox(height: 20,),
                            new_account_button(),
                            /*GFButton(
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
                    ),*/

                            Row(
                                mainAxisAlignment: MainAxisAlignment.center ,//Center Column contents vertically,

                              children: [
                                Text(getTranslated(context, 'Already have an account'),
                                  style: TextStyle(fontSize: 16,
                                    fontFamily: 'cairo',),),

                                //SizedBox(width: 5,),
                                TextButton(
                                  child: Text(
                                      getTranslated(context, 'drawer_login')),
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
                                                BuildContext context) => new login()));
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

  void _handleRegister() async {
    setState(() {
      _is_btn_Loading = true;
    });

    if (name_Controller.text == "" || name_Controller.text == null) {
      //_showDialog("يرجى إدخال اسم الشركة");
      _show_alert(context, getTranslated(context, 'Wrong_data'), getTranslated(context, 'Please enter the name'));
      setState(() {
        _is_btn_Loading = false;
      });
      return;
    } else if (email_Controller.text == "" || email_Controller.text == null) {
      //_showDialog("يرجى إدخال اسم الشركة");
      _show_alert(context, getTranslated(context, 'Wrong_data'), getTranslated(context, 'Please enter an email'));
      setState(() {
        _is_btn_Loading = false;
      });
      return;
    } else if (pass1_Controller.text == "" || pass1_Controller.text == null) {
      //_showDialog("يرجى إدخال اسم الشركة");
      _show_alert(context, getTranslated(context, 'Wrong_data'), getTranslated(context, 'Please enter the password'));
      setState(() {
        _is_btn_Loading = false;
      });
      return;
    } else if (pass2_Controller.text == "" || pass2_Controller.text == null) {
      //_showDialog("يرجى إدخال اسم الشركة");
      _show_alert(context, getTranslated(context, 'Wrong_data'), getTranslated(context, 'Please enter confirmation password'));
      setState(() {
        _is_btn_Loading = false;
      });
      return;
    } else if (pass1_Controller.text != pass2_Controller.text) {
      //_showDialog("يرجى إدخال اسم الشركة");
      _show_alert(context, getTranslated(context, 'Wrong_data'), getTranslated(context, 'Passwords do not match'));
      setState(() {
        _is_btn_Loading = false;
      });
      return;
    } else if (_mySelection == "" || _mySelection == null) {
      _show_alert(context, getTranslated(context, 'Wrong_data'), getTranslated(context, 'Please select a country key'));
      setState(() {
        _is_btn_Loading = false;
      });
      return;
    } else if (phone_Controller.text == "" || phone_Controller.text == null) {
      //_showDialog("يرجى إدخال اسم الشركة");
      _show_alert(context, getTranslated(context, 'Wrong_data'), getTranslated(context, 'Please enter the phone number'));
      setState(() {
        _is_btn_Loading = false;
      });
      return;
    }  else if (national_Selection == "" || national_Selection == null) {
      _show_alert(context, getTranslated(context, 'Wrong_data'), getTranslated(context, 'Please select the nationality'));
      setState(() {
        _is_btn_Loading = false;
      });
      return;
    }else{

      //String myUrl = "https://ipackagetours.com/api/register";
      Uri uri = Uri.parse('https://ipackagetours.com/api/register');
      final response = await http.post(uri,
          body: {
            'name': name_Controller.text,
            'email': email_Controller.text,
            'password': pass1_Controller.text,
            'password_confirmation': pass2_Controller.text,
            'key': _mySelection,
            'nationality': national_Selection,
            'phone': phone_Controller.text,
          });
      var status = response.body.contains('error');

      var data = json.decode(response.body);

      if (status) {
        _show_alert(context, getTranslated(context, 'Wrong_data'), getTranslated(context, 'The email is already used in another account'));
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

  _saveUserData(int userId, String key, String name, String email, String nationality, String phone, String api_token) async {
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
    final value5 = nationality;
    prefs.setString(key5, value5);

    final key6 = 'phone';
    final value6 = phone;
    prefs.setString(key6, value6);

    final key7 = 'api_token';
    final value7 = api_token;
    prefs.setString(key7, value7);
  }

  Widget new_account_button() {
    return InkWell(
      onTap: _handleRegister,
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
                ) :Text(getTranslated(context, 'login_new_account_btn'),
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
