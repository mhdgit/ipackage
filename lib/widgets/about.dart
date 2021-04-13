import 'package:flutter/material.dart';
import 'package:ipackage/localization/localizationValues.dart';

class AboutUs extends StatefulWidget {
  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {

    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final double screenHeight =
        MediaQuery.of(context).size.height - statusBarHeight - kToolbarHeight;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(

      appBar: AppBar(
        backgroundColor: Color(0xffE9F7F8),
        elevation: 0.0,
        shadowColor: Colors.white,
        title: Text(
          getTranslated(context, 'drawer_about_us'),
        ),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[

            Padding(
              padding: const EdgeInsets.all(10),
              child: ClipPath(
                clipper: ShapeBorderClipper(
                  shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(15)),
                ),
                child: Image.asset(
                  'assets/images/c3.jpg',
                  fit: BoxFit.fill,
                  height: screenHeight * 0.34,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                getTranslated(context, 'drawer_about_us'),
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                getTranslated(context, 'company_name'),
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff07898B),
                ),
              ),
            ),

            Row(
              children: [
                Container(
                  width: screenWidth * 0.9,
                  padding: EdgeInsetsDirectional.only(
                      start: screenWidth * 0.08, top: 10.0, bottom: 5.0),
                  child: Row(
                    children: [
                      Flexible(
                        child: Text(
                          getTranslated(context, 'company_about'),
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  width: screenWidth * 0.9,
                  padding: EdgeInsetsDirectional.only(
                      start: screenWidth * 0.08, top: 10.0, bottom: 30.0),
                  child: Row(
                    children: [
                      Flexible(
                        child: Text(
                          getTranslated(context, 'company_about_2'),
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black38,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),


          ],
        ),
      ),
    );
  }

}
