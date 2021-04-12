import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:ipackage/localization/localizationValues.dart';

class NewMembership extends StatefulWidget {

  @override
  _NewMembership createState() => _NewMembership();
}

class _NewMembership extends State<NewMembership> {

  int _currentWidget = 0;

  _stage0(){
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10,),
          Text(getTranslated(context, 'create_membership_name'),style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,fontFamily: 'cairo',),textAlign: TextAlign.right,),
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

          Text(getTranslated(context, 'create_membership_email'),style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,fontFamily: 'cairo',),textAlign: TextAlign.right,),
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

          Text(getTranslated(context, 'create_membership_ID'),style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,fontFamily: 'cairo',),textAlign: TextAlign.right,),
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

          Text(getTranslated(context, 'create_membership_country'),style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,fontFamily: 'cairo',),textAlign: TextAlign.right,),
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
            text: getTranslated(context, 'create_membership_continue'),
            size: 50.0,
            textStyle: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'cairo',
            ),
            onPressed: () {

              setState(() {
                _currentWidget ++;
              });
            },
          ),

        ],
      ),
    );
  }
  _stage1(){
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10,),
          Text(getTranslated(context, 'create_membership_phone'),style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,fontFamily: 'cairo',),textAlign: TextAlign.right,),
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

          Text(getTranslated(context, 'create_membership_age'),style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,fontFamily: 'cairo',),textAlign: TextAlign.right,),
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

          Text(getTranslated(context, 'create_membership_pass'),style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,fontFamily: 'cairo',),textAlign: TextAlign.right,),
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

          Text(getTranslated(context, 'create_membership_pass_conf'),style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,fontFamily: 'cairo',),textAlign: TextAlign.right,),
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
            text: getTranslated(context, 'create_membership_continue'),
            size: 50.0,
            textStyle: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'cairo',
            ),
            onPressed: () {

              setState(() {
                _currentWidget ++;
              });
            },
          ),

        ],
      ),
    );
  }
  _stage2(){
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10,),
          Text(getTranslated(context, 'create_membership_services'),style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,fontFamily: 'cairo',),textAlign: TextAlign.right,),
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

          Text(getTranslated(context, 'create_membership_biography'),style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,fontFamily: 'cairo',),textAlign: TextAlign.right,),
          SizedBox(height: 5,),
          TextField(
            maxLines: 7,
            minLines: 7,
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
            text: getTranslated(context, 'create_membership_create_btn'),
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

  _formRouter(){
    switch(_currentWidget)
    {
      case 0: return _stage0();break;
      case 1: return _stage1();break;
      case 2: return _stage2();break;
    }
  }

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
                      Text(getTranslated(context, 'create_membership'),style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,fontFamily: 'cairo',),textAlign: TextAlign.center,),

                      _formRouter(),
                    ]
                )
            )
        )
    );
  }
}
