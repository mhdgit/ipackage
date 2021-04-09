import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:ipackage/localization/localizationValues.dart';
import 'package:ipackage/modules/City.dart';
import 'package:ipackage/widgets/search/ambassadors_services.dart';

class IPackageAmbassadors extends StatefulWidget {
  @override
  _IPackageAmbassadorsState createState() => _IPackageAmbassadorsState();
}

class _IPackageAmbassadorsState extends State<IPackageAmbassadors> {

  List<City> _cities = [
    City(id: 1, enName: 'Egypt', arName: 'مصر'),
    City(id: 2, enName: 'Turkey', arName: 'تركيا'),
    City(id: 3, enName: 'Italy', arName: 'إيطاليا'),
  ];

  @override
  Widget build(BuildContext context) {

    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final double screenHeight =
        MediaQuery.of(context).size.height - statusBarHeight - kToolbarHeight;
    final double screenWidth = MediaQuery.of(context).size.width;


    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

          Container(
            width: screenWidth * 0.9,
            padding: EdgeInsets.symmetric(vertical: screenWidth * 0.02),
            child: Image.asset('assets/images/map.jpg',
            fit: BoxFit.fill,),
          ),

          Container(
            width: screenWidth * 0.5,
            padding:
            EdgeInsets.only(top: 10.0, right: 0.0, left: 0.0, bottom: 0.0),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.black,
                side: BorderSide(color: Colors.black, width: 2),
              ),
              onPressed: () {
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    getTranslated(context, 'home_ambassadors_btn_2'),
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.white
                    ),
                  ),
                  Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),

          Container(
            width: screenWidth * 0.5,
            padding:
            EdgeInsets.only(top: 10.0, right: 0.0, left: 0.0, bottom: 0.0),
            child: GFButton(
              onPressed: (){},
              text: getTranslated(context, 'home_ambassadors_btn_3'),
              textColor: Colors.white,
              textStyle: TextStyle(fontSize: 14),
              color: Color(0xff07898B),
            ),
          ),

          Container(
            width: screenWidth * 0.5,
            padding:
            EdgeInsets.only(top: 10.0, right: 0.0, left: 0.0, bottom: 0.0),
            child: GFButton(
              onPressed: (){
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => new AmbassadorsServices()));
              },
              text: getTranslated(context, 'home_ambassadors_btn_4'),
              textColor: Colors.white,
              textStyle: TextStyle(fontSize: 14),
              color: Colors.amberAccent,
            ),
          ),


        ],
      ),
    );
  }
}
