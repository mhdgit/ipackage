import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:ipackage/api/accounts_api.dart';
import 'package:ipackage/localization/localizationValues.dart';
import 'package:ipackage/modules/LocalAssistant.dart';
import 'package:http/http.dart' as http;
import 'package:ipackage/widgets/search/tourist_services.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewMembership extends StatefulWidget {
  @override
  _NewMembership createState() => _NewMembership();
}

class _NewMembership extends State<NewMembership> {
  int _currentWidget = 0;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final idController = TextEditingController();
  final pass1Controller = TextEditingController();
  final pass2Controller = TextEditingController();
  final phoneController = TextEditingController();
  final ageController = TextEditingController();
  final serviceController = TextEditingController();
  final biographyController = TextEditingController();

  AccountsApi accountsApi = new AccountsApi();
  LocalAssistant localAssistant = new LocalAssistant();
  List _nationalities = [];
  String _mySelection;
  bool _isBtnLoading = false;

  @override
  void initState() {
    super.initState();

    accountsApi.get_nationalities().then((value) {
      setState(() {
        print(value['data'].toString());
        _nationalities = List.of(value['data']);
      });
    });
  }

  _stage0() {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          Text(
            getTranslated(context, 'create_membership_name'),
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'cairo',
            ),
            textAlign: TextAlign.right,
          ),
          SizedBox(
            height: 5,
          ),
          TextField(
            controller: nameController,
            keyboardType: TextInputType.text,
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
            style: TextStyle(),
            //controller: _usernameController,
          ),
          SizedBox(
            height: 10,
          ),

          Text(
            getTranslated(context, 'create_membership_email'),
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'cairo',
            ),
            textAlign: TextAlign.right,
          ),
          SizedBox(
            height: 5,
          ),
          TextField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
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
            style: TextStyle(),
            //controller: _usernameController,
          ),
          SizedBox(
            height: 10,
          ),

          Text(
            getTranslated(context, 'create_membership_ID'),
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'cairo',
            ),
            textAlign: TextAlign.right,
          ),
          SizedBox(
            height: 5,
          ),
          TextField(
            controller: idController,
            keyboardType: TextInputType.number,
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
            style: TextStyle(),
            //controller: _usernameController,
          ),
          SizedBox(
            height: 10,
          ),

          Text(
            getTranslated(context, 'create_membership_country'),
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'cairo',
            ),
            textAlign: TextAlign.right,
          ),
          SizedBox(
            height: 5,
          ),
          DropdownButtonFormField(
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
            isExpanded: true,
            hint: Text(
              "اختر مفتاح الدولة",
              textAlign: TextAlign.right,
              textDirection: TextDirection.rtl,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                //fontWeight: FontWeight.w600,
                fontFamily: "cairo",
              ),
            ),
            items: _nationalities.map((item) {
              return new DropdownMenuItem(
                child: new Text(item['name_ar'],
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
              });
            },
            value: _mySelection,
          ),
          // TextField(
          //   decoration: InputDecoration(
          //     border: new OutlineInputBorder(
          //         borderSide: new BorderSide(color: Colors.black)),
          //     enabledBorder: const OutlineInputBorder(
          //       borderSide: const BorderSide(color: Colors.black, width: 0.0),
          //     ),
          //     focusedBorder: const OutlineInputBorder(
          //       borderSide: const BorderSide(color: Colors.black, width: 0.0),
          //     ),
          //   ),
          //   style: TextStyle(
          //     fontFamily: 'CustomIcons',
          //   ),
          //   //controller: _usernameController,
          // ),
          SizedBox(
            height: 40,
          ),

          Row(
            children: [
              Expanded(
                flex: 45,
                child: GFButton(
                  color: Color(0xff07898b),
                  textColor: Colors.white,
                  text: getTranslated(context, 'login_back_btn'),
                  size: 50.0,
                  textStyle: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'cairo',
                  ),
                  onPressed: () {
                    if(_currentWidget > 0)
                    setState(() {
                      _currentWidget--;
                    });
                  },
                ),
              ),
              SizedBox(
                width: 40,
              ),
              Expanded(
                flex: 45,
                child: GFButton(
                  color: Color(0xff07898b),
                  textColor: Colors.white,
                  text: getTranslated(context, 'create_membership_continue'),
                  size: 50.0,
                  textStyle: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'cairo',
                  ),
                  onPressed: () {
                    setState(() {
                      _currentWidget++;
                    });
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _stage1() {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          Text(
            getTranslated(context, 'create_membership_phone'),
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'cairo',
            ),
            textAlign: TextAlign.right,
          ),
          SizedBox(
            height: 5,
          ),
          TextField(
            controller: phoneController,
            keyboardType: TextInputType.phone,
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
            style: TextStyle(),
            //controller: _usernameController,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            getTranslated(context, 'create_membership_age'),
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'cairo',
            ),
            textAlign: TextAlign.right,
          ),
          SizedBox(
            height: 5,
          ),
          TextField(
            controller: ageController,
            keyboardType: TextInputType.number,
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
          SizedBox(
            height: 10,
          ),
          Text(
            getTranslated(context, 'create_membership_pass'),
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'cairo',
            ),
            textAlign: TextAlign.right,
          ),
          SizedBox(
            height: 5,
          ),
          TextField(
            controller: pass1Controller,
            keyboardType: TextInputType.visiblePassword,
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
          SizedBox(
            height: 10,
          ),
          Text(
            getTranslated(context, 'create_membership_pass_conf'),
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'cairo',
            ),
            textAlign: TextAlign.right,
          ),
          SizedBox(
            height: 5,
          ),
          TextField(
            controller: pass2Controller,
            keyboardType: TextInputType.visiblePassword,
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
          SizedBox(
            height: 40,
          ),
          Row(
            children: [
              Expanded(
                flex: 45,
                child: GFButton(
                  color: Color(0xff07898b),
                  textColor: Colors.white,
                  text: getTranslated(context, 'login_back_btn'),
                  size: 50.0,
                  textStyle: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'cairo',
                  ),
                  onPressed: () {
                    if(_currentWidget > 0)
                      setState(() {
                        _currentWidget--;
                      });
                  },
                ),
              ),
              SizedBox(
                width: 40,
              ),
              Expanded(
                flex: 45,
                child: GFButton(
                  color: Color(0xff07898b),
                  textColor: Colors.white,
                  text: getTranslated(context, 'create_membership_continue'),
                  size: 50.0,
                  textStyle: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'cairo',
                  ),
                  onPressed: () {
                    setState(() {
                      _currentWidget++;
                    });
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _stage2() {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          Text(
            getTranslated(context, 'create_membership_services'),
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'cairo',
            ),
            textAlign: TextAlign.right,
          ),
          SizedBox(
            height: 5,
          ),
          TextField(
            controller: serviceController,
            keyboardType: TextInputType.text,
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
            style: TextStyle(),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            getTranslated(context, 'create_membership_biography'),
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'cairo',
            ),
            textAlign: TextAlign.right,
          ),
          SizedBox(
            height: 5,
          ),
          TextField(
            controller: biographyController,
            keyboardType: TextInputType.text,
            maxLines: 7,
            minLines: 7,
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
            style: TextStyle(),
          ),
          SizedBox(
            height: 40,
          ),

          Row(
            children: [
              Expanded(
                flex: 20,
                child: GFButton(
                  color: Color(0xff07898b),
                  textColor: Colors.white,
                  text: getTranslated(context, 'login_back_btn'),
                  size: 50.0,
                  textStyle: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'cairo',
                  ),
                  onPressed: () {
                    if(_currentWidget > 0)
                      setState(() {
                        _currentWidget--;
                      });
                  },
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                flex: 80,
                child: GFButton(
                  color: Color(0xff07898b),
                  textColor: Colors.white,
                  child: _isBtnLoading
                      ? Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    )
                  )
                      : Text(
                    getTranslated(context, 'create_membership_create_btn'),
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'cairo',
                    ),
                  ),
                  size: 50.0,
                  onPressed: _handleRegister,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _formRouter() {
    switch (_currentWidget) {
      case 0:
        return _stage0();
        break;
      case 1:
        return _stage1();
        break;
      case 2:
        return _stage2();
        break;
    }
  }

  void _handleRegister() async {
    setState(() {
      _isBtnLoading = true;
    });

    if (nameController.text == "" || nameController.text == null) {
      _showAlert(context, getTranslated(context, 'Wrong_data'),
          getTranslated(context, 'Please enter the name'));
      setState(() {
        _isBtnLoading = false;
      });
      return;
    } else if (emailController.text == "" || emailController.text == null) {
      _showAlert(context, getTranslated(context, 'Wrong_data'),
          getTranslated(context, 'Please enter an email'));
      setState(() {
        _isBtnLoading = false;
      });
      return;
    } else if (pass1Controller.text == "" || pass1Controller.text == null) {
      _showAlert(context, getTranslated(context, 'Wrong_data'),
          getTranslated(context, 'Please enter the password'));
      setState(() {
        _isBtnLoading = false;
      });
      return;
    } else if (pass2Controller.text == "" || pass2Controller.text == null) {
      _showAlert(context, getTranslated(context, 'Wrong_data'),
          getTranslated(context, 'Please enter confirmation password'));
      setState(() {
        _isBtnLoading = false;
      });
      return;
    } else if (pass1Controller.text != pass2Controller.text) {
      _showAlert(context, getTranslated(context, 'Wrong_data'),
          getTranslated(context, 'Passwords do not match'));
      setState(() {
        _isBtnLoading = false;
      });
      return;
    } else if (_mySelection == "" || _mySelection == null) {
      _showAlert(context, getTranslated(context, 'Wrong_data'),
          getTranslated(context, 'Please select a country key'));
      setState(() {
        _isBtnLoading = false;
      });
      return;
    } else if (phoneController.text == "" || phoneController.text == null) {
      _showAlert(context, getTranslated(context, 'Wrong_data'),
          getTranslated(context, 'Please enter the phone number'));
      setState(() {
        _isBtnLoading = false;
      });
      return;
    } else {
      Uri uri = Uri.parse('https://ipackagetours.com/api/register/safer');
      final response = await http.post(uri, body: {
        'name': nameController.text,
        'id_number': idController.text,
        'age': ageController.text,
        'email': emailController.text,
        'password': pass1Controller.text,
        'password_confirmation': pass2Controller.text,
        'key': _mySelection,
        'nationality': _mySelection,
        'phone': phoneController.text,
        'services': serviceController.text,
        'about': biographyController.text,
      });
      var status = response.body.contains('error');

      var data = json.decode(response.body);

      if (status) {
        _showAlert(
            context,
            getTranslated(context, 'Wrong_data'),
            getTranslated(
                context, 'The email is already used in another account'));
        setState(() {
          _isBtnLoading = false;
        });
      } else {
        setState(() {
          _isBtnLoading = false;
        });

        _saveAmbassadorData(data['user']['id'],data['user']['name'],data['user']['email'],
            data['user']['nationality'],data['user']['phone'],data['user']['services'],
          data['user']['about'],data['user']['api_token'],);

        Navigator.of(context).push(
          new MaterialPageRoute(
              builder: (BuildContext context) => new TouristServices()),
        );
      }
    }
  }

  _saveAmbassadorData(int userId, String name, String email,
      String nationality, String phone,String services ,
      String about, String apiToken) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'amb_is_login';
    final value = "1";
    prefs.setString(key, value);

    final key1 = 'amb_id';
    final value1 = userId;
    prefs.setInt(key1, value1);

    final key2 = 'amb_name';
    final value2 = name;
    prefs.setString(key2, value2);


    final key4 = 'amb_email';
    final value4 = email;
    prefs.setString(key4, value4);

    final key5 = 'amb_nationality';
    final value5 = nationality;
    prefs.setString(key5, value5);

    final key6 = 'amb_phone';
    final value6 = phone;
    prefs.setString(key6, value6);

    final key7 = 'amb_api_token';
    final value7 = apiToken;
    prefs.setString(key7, value7);

    final key8 = 'amb_services';
    final value8 = phone;
    prefs.setString(key8, value8);

    final key9 = 'amb_about';
    final value9 = phone;
    prefs.setString(key9, value9);

  }

  _showAlert(context, String text, String des) {
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
            style: TextStyle(
                color: Colors.white, fontFamily: 'Cairo', fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          color: Color(0xff07898b),
          radius: BorderRadius.circular(3.0),
        ),
      ],
    ).show();
  }

  Widget fadeAlertAnimation(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return Align(
      child: FadeTransition(
        opacity: animation,
        child: child,
      ),
    );
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
                child: Column(children: <Widget>[
      Image.asset(
        'assets/images/users/i1.png',
        fit: BoxFit.fill,
        height: screenHeight * 0.30,
        width: screenWidth,
      ),
      SizedBox(
        height: 10,
      ),
      Text(
        getTranslated(context, 'create_membership'),
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          fontFamily: 'cairo',
        ),
        textAlign: TextAlign.center,
      ),
      _formRouter(),
    ]))));
  }
}
