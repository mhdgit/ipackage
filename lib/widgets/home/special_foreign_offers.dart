import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:ipackage/api/home_api.dart';
import 'package:ipackage/localization/localizationValues.dart';
import 'package:ipackage/modules/my_icons.dart';
import 'package:ipackage/widgets/home/domestic_offer_main.dart';
import 'package:ipackage/widgets/home/foreign_offer_main.dart';

class SpecialForeignOffers extends StatefulWidget {
  @override
  _SpecialForeignOffersState createState() => _SpecialForeignOffersState();
}

class _SpecialForeignOffersState extends State<SpecialForeignOffers> {
  HomeApi homeApi = new HomeApi();

  List<dynamic> Special_Offers;


  var is_Special_loading = true;



  void initState() {
    super.initState();

    homeApi.getSpecialOffers().then((value) {
      setState(() {

        Map<String, dynamic> data = value;
        Special_Offers = data["data"];;

        if (Special_Offers != '')
          {
            is_Special_loading = false;
          }

      });
    });

  }

  String Special_lang(int i, String type) {
    Locale currentLocale = Localizations.localeOf(context);

    if (currentLocale.languageCode == 'ar') {
      switch (type) {
        case 'title':
          return Special_Offers[i]['description_ar'];
          break;
        case 'package':
          return Special_Offers[i]['package_ar'];
          break;
        case 'days':
          return Special_Offers[i]['days'].toString()+' أيام';
          break;
      }
    } else {
      switch (type) {
        case 'title':
          return Special_Offers[i]['description_en'];
          break;
        case 'package':
          return Special_Offers[i]['package_en'];
          break;
        case 'days':
          return Special_Offers[i]['days'].toString()+' days';
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final double screenHeight =
        MediaQuery.of(context).size.height - statusBarHeight - kToolbarHeight;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.0),
      height: screenHeight * 0.6,
      child: Container(

        child:
          is_Special_loading?
          Container(
            child: Center(
              child: GFLoader(
                type: GFLoaderType.circle,
                loaderColorOne: Color(0xFF2196f3),
                loaderColorTwo: Color(0xFF2196f3),
                loaderColorThree: Color(0xFF2196f3),
              ),
            ),
          )
              : ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              //for (int i = 0; i < _rCoupons.length; i++)
              for(int i = 0; i < Special_Offers.length; i++)
                Container(
                  width: screenWidth * 0.65,
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {},
                    child: InkWell(
                      borderRadius: BorderRadius.circular(4.0),
                      onTap: () {
                        Navigator.of(context).push(new MaterialPageRoute(
                            builder: (BuildContext context) => new ForeignOfferMain()));
                      },
                      child: Card(shadowColor: Colors.grey,
                        elevation: 1.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        clipBehavior: Clip.antiAlias,
                        margin: const EdgeInsets.all(0.0),
                        color: Color(0xffffffff),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(0),
                              child: Stack(
                                fit: StackFit.passthrough,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(0),
                                    child: ClipPath(
                                      clipper: ShapeBorderClipper(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(15)),
                                      ),
                                      child: Image.network(
                                        'https://ipackagetours.com/storage/app/'+Special_Offers[i]['image'],
                                        fit: BoxFit.scaleDown,
                                        //height: screenHeight * 0.28,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(6),
                                    child: Flex(
                                      direction: Axis.horizontal,
                                      mainAxisAlignment:
                                      MainAxisAlignment.end,
                                      children: <Widget>[
                                        Container(
                                          padding:
                                          const EdgeInsets.all(3.0),
                                          margin: const EdgeInsets.only(
                                              top: 20.0),
                                          constraints: BoxConstraints(),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                              color: Colors.white,
                                            ),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10.0),
                                            ),
                                          ),
                                          child: Text(
                                            Special_lang(i, 'package'),
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
//
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                Special_lang(i,'title'),
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff07898B),
                                ),
                                softWrap: true,
                              ),
                            ),

                            Container(
                              color: Colors.white,
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    flex: 50,
                                    child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 0.0,
                                            right: 0.0,
                                            left: 0.0,
                                            bottom: 0.0),
                                        child: Text(
                                          Special_lang(i, 'days'),
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                              color: Colors.black),
                                        )),
                                  ),
                                  Expanded(
                                    flex: 50,
                                    child: FittedBox(
                                      child: GFRating(
                                        color: Colors.yellow,
                                        borderColor: Colors.yellow,
                                        allowHalfRating: true,
                                        value: double.parse(Special_Offers[i]['stars']),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                getTranslated(
                                    context, 'home_offer_card_price') +
                                    ' 220\$',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Colors.black),
                                softWrap: true,
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                getTranslated(
                                    context, 'home_offer_card_details'),
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.brown,
                                ),
                                softWrap: true,
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Container(
                                padding: const EdgeInsets.all(5.0),
                                color: Color(0xff07898B),
                                height: screenHeight * 0.11,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    Expanded(
                                      flex:25,
                                      child: Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Column(
                                          children: <Widget>[
                                            Icon(
                                              MyIcons.bed,
                                              color: Colors.white,
                                            ),
                                            Container(
                                              margin: const EdgeInsets.only(top: 6.0),
                                              child: FittedBox(
                                                child: Text(
                                                  getTranslated(
                                                      context, 'home_offer_card_rate'),
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),

                                    Expanded(
                                      flex:25,
                                      child: Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Column(
                                          children: <Widget>[
                                            Icon(
                                              Icons.airplanemode_inactive,
                                              color: Colors.white,
                                            ),
                                            Container(
                                              margin: const EdgeInsets.only(top: 6.0),
                                              child: FittedBox(
                                                child: Text(
                                                  getTranslated(
                                                      context, 'home_offer_card_flight'),
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),

                                    Expanded(
                                      flex:25,
                                      child: Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Column(
                                          children: <Widget>[
                                            Image.asset(
                                                'assets/icons/dish.png'
                                            ),
                                            Container(
                                              margin: const EdgeInsets.only(top: 6.0),
                                              child: FittedBox(
                                                child: Text(
                                                  getTranslated(
                                                      context, 'home_offer_card_breakfast'),
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex:25,
                                      child: Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Column(
                                          children: <Widget>[
                                            Icon(
                                              Icons.directions_car_outlined,
                                              color: Colors.white,
                                            ),
                                            Container(
                                              margin: const EdgeInsets.only(top: 6.0),
                                              child: FittedBox(
                                                child: Text(
                                                  getTranslated(
                                                      context, 'home_offer_card_transportation'),
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),




      ),
    );
  }
}
