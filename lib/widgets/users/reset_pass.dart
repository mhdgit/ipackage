import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:ipackage/localization/localizationValues.dart';
import 'package:ipackage/modules/my_icons.dart';


class reset_pass extends StatefulWidget {
  @override
  _reset_pass createState() => _reset_pass();
}

class _reset_pass extends State<reset_pass> {

  int form_id = 2;

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
                      SizedBox(height: 40,),
                      Image.asset(
                        'assets/images/users/i2.png',
                        fit: BoxFit.fitHeight,
                        height: screenHeight * 0.30,
                        width: screenWidth,
                      ),
                      SizedBox(height: 10,),

                      form1(),

                    ]
                )
            )
        )
    );
  }

  Widget form1(){

    if (form_id == 1)
      {
        return Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(getTranslated(context, 'login_reset_pass_main'),style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,fontFamily: 'cairo',)),
              SizedBox(height: 5,),
              Text(getTranslated(context, 'reset_pass_subtitle'),style: TextStyle(fontSize: 18,fontFamily: 'cairo',color: Color(0XFF666666))),

              SizedBox(height: 20,),
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




              GFButton(
                color: Color(0xff07898b),
                textColor: Colors.white,
                fullWidthButton: true,
                text: getTranslated(context, 'Continue'),
                size: 50.0,
                textStyle: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'cairo',
                ),
                onPressed: () {

                },
              ),

            ],
          ),
        );
      }
    else if (form_id == 2){
      return Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(getTranslated(context, 'reset_code_title'),style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,fontFamily: 'cairo',)),
            SizedBox(height: 5,),
            Text(getTranslated(context, 'reset_code_subtitle'),style: TextStyle(fontSize: 18,fontFamily: 'cairo',color: Color(0XFF666666))),

            SizedBox(height: 20,),
            Text(getTranslated(context, 'reset_code_title'),style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,fontFamily: 'cairo',),textAlign: TextAlign.right,),
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




            GFButton(
              color: Color(0xff07898b),
              textColor: Colors.white,
              fullWidthButton: true,
              text: getTranslated(context, 'Continue'),
              size: 50.0,
              textStyle: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'cairo',
              ),
              onPressed: () {

              },
            ),

          ],
        ),
      );
    }

    else if (form_id == 3){
      return Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(getTranslated(context, 'reset_new_pass_title'),style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,fontFamily: 'cairo',)),
            SizedBox(height: 5,),
            Text(getTranslated(context, 'reset_code_subtitle'),style: TextStyle(fontSize: 18,fontFamily: 'cairo',color: Color(0XFF666666))),

            SizedBox(height: 20,),
            Text(getTranslated(context, 'settings_password_label'),style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,fontFamily: 'cairo',),textAlign: TextAlign.right,),
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

            SizedBox(height: 20,),
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
            SizedBox(height: 10,),



            GFButton(
              color: Color(0xff07898b),
              textColor: Colors.white,
              fullWidthButton: true,
              text: getTranslated(context, 'reset_new_pass_title'),
              size: 50.0,
              textStyle: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'cairo',
              ),
              onPressed: () {

              },
            ),

          ],
        ),
      );
    }

  }
}