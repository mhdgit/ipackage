import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:ipackage/localization/localizationValues.dart';
import 'package:ipackage/modules/City.dart';
import 'package:ipackage/widgets/search/ambassadors_services.dart';
import 'package:ipackage/widgets/search/tourist_services.dart';
import 'package:ipackage/widgets/users/new_membership.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IPackageAmbassadors extends StatefulWidget {
  @override
  _IPackageAmbassadorsState createState() => _IPackageAmbassadorsState();
}

class _IPackageAmbassadorsState extends State<IPackageAmbassadors> {
  // List<City> _cities = [
  //   City(id: 1, enName: 'Egypt', arName: 'مصر'),
  //   City(id: 2, enName: 'Turkey', arName: 'تركيا'),
  //   City(id: 3, enName: 'Italy', arName: 'إيطاليا'),
  // ];

  @override
  void initState() {
    super.initState();

    _checkIfAmbIsLogin();
  }

  _checkIfAmbIsLogin() async {
    final prefs = await SharedPreferences.getInstance();

    final isAmbLogin = prefs.getString('amb_is_login');

    if (isAmbLogin == '1')
      Navigator.of(context).push(
        new MaterialPageRoute(
            builder: (BuildContext context) => new TouristServices()),
      );
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final double screenHeight =
        MediaQuery.of(context).size.height - statusBarHeight - kToolbarHeight;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: screenWidth * 0.9,
              padding: EdgeInsets.symmetric(vertical: screenWidth * 0.02),
              child: Image.asset(
                'assets/images/map.jpg',
                fit: BoxFit.fill,
              ),
            ),

            Container(
              width: screenWidth * 0.8,
              padding: EdgeInsetsDirectional.only(
                // start: screenWidth * 0.04,
                top: 10.0,
                bottom: 10.0,
              ),
              child: Row(
                children: [
                  Flexible(
                    child: Text(
                      getTranslated(context, 'home_ambassadors_label_1'),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        // fontWeight: FontWeight.bold,
                        // color: Color(0xff07898B),
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Container(
            //   width: screenWidth * 0.5,
            //   padding:
            //   EdgeInsets.only(top: 10.0, right: 0.0, left: 0.0, bottom: 0.0),
            //   child: TextButton(
            //     style: TextButton.styleFrom(
            //       backgroundColor: Colors.black,
            //       side: BorderSide(color: Colors.black, width: 2),
            //     ),
            //     onPressed: () {
            //     },
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: <Widget>[
            //         Text(
            //           getTranslated(context, 'home_ambassadors_btn_2'),
            //           style: TextStyle(
            //               fontSize: 14,
            //               color: Colors.white
            //           ),
            //         ),
            //         Icon(
            //           Icons.keyboard_arrow_down,
            //           color: Colors.white,
            //         ),
            //       ],
            //     ),
            //   ),
            // ),

            Container(
              width: screenWidth * 0.8,
              padding: EdgeInsets.only(
                  top: 10.0, right: 0.0, left: 0.0, bottom: 30.0),
              child: GFButton(
                onPressed: () {
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (BuildContext context) => new NewMembership()));
                },
                size: 40,
                text: getTranslated(context, 'home_ambassadors_btn_3'),
                textColor: Colors.white,
                textStyle: TextStyle(fontSize: 16),
                color: Color(0xff07898B),
              ),
            ),

            // Container(
            //   width: screenWidth * 0.5,
            //   padding:
            //   EdgeInsets.only(top: 10.0, right: 0.0, left: 0.0, bottom: 0.0),
            //   child: GFButton(
            //     onPressed: (){
            //       Navigator.of(context).push(new MaterialPageRoute(
            //           builder: (BuildContext context) => new AmbassadorsServices()));
            //     },
            //     text: getTranslated(context, 'home_ambassadors_btn_4'),
            //     textColor: Colors.white,
            //     textStyle: TextStyle(fontSize: 14),
            //     color: Colors.amberAccent,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
