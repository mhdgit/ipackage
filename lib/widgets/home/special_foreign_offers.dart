import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:ipackage/localization/localizationValues.dart';
import 'package:ipackage/modules/SpecialForeignOffer.dart';
import 'package:ipackage/modules/my_icons.dart';
import '../../modules/BetaApiAssistant.dart';
import '../../modules/LocalAssistant.dart';
import 'foreign_offer_main.dart';

class SpecialForeignOffers extends StatefulWidget {

  @override
  _SpecialForeignOffersState createState() => _SpecialForeignOffersState();
}

class _SpecialForeignOffersState extends State<SpecialForeignOffers> {

  List<SpecialForeignOffer> _specialForeignOffers = [];
  BetaApiAssistant betaApiAssistant = new BetaApiAssistant();
  LocalAssistant localAssistant = new LocalAssistant();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    betaApiAssistant.getSpecialForeignOffers().then((value) {
      setState(() {
        _specialForeignOffers = List.of(value);

        _isLoading = false;
      });
    });

  }

  @override
  Widget build(BuildContext context) {

    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final double screenHeight =
        MediaQuery.of(context).size.height - statusBarHeight - kToolbarHeight;
    final double screenWidth = MediaQuery.of(context).size.width;

    return _isLoading ?
    Container(
      margin: EdgeInsets.symmetric(vertical: 5.0),
      height: screenHeight * 0.65,
      width: screenWidth,
      child: Center(
        child: GFLoader(
          type:GFLoaderType.circle,
          loaderColorOne: Color(0xff07898B),
          loaderColorTwo: Color(0xff07898B),
          loaderColorThree: Color(0xff07898B),
        ),
      ),
    ) :
    Container(
      margin: EdgeInsets.symmetric(vertical: 5.0),
      height: screenHeight * 0.66,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _specialForeignOffers.length,
        shrinkWrap: true,
        itemBuilder: (context , index){
          return Container(
            width: screenWidth * 0.6,
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {

              },
              child: InkWell(
                borderRadius: BorderRadius.circular(4.0),
                onTap: () {
                  Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => new ForeignOfferMain(
                      id: _specialForeignOffers[index].id,
                      package: localAssistant.getSpecialForeignOfferByLocale(context, _specialForeignOffers[index], 'package'),
                      rating: _specialForeignOffers[index].rating.toString(),),
                  ));
                },
                child: Card(
                  shadowColor: Colors.white,
                  elevation: 0.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  clipBehavior: Clip.antiAlias,
                  margin: const EdgeInsets.all(0.0),
                  color: Color(0xffFAFAFA),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
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
                                  'https://ipackagetours.com/storage/app/' + _specialForeignOffers[index].image.toString(),
                                  fit: BoxFit.fill,
                                  height: screenHeight * 0.28,
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
                                      localAssistant.getSpecialForeignOfferByLocale(context, _specialForeignOffers[index], 'package'),
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
                          localAssistant.getSpecialForeignOfferByLocale(context, _specialForeignOffers[index], 'title'),
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
                                    _specialForeignOffers[index].daysNumber.toString() +
                                        getTranslated(context,
                                            'home_offer_card_days'),
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
                                  value: double.parse(_specialForeignOffers[index].rating.toString()),
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
                              _specialForeignOffers[index].startPrice.toString() + '\$',
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
                            fontSize: 11,
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
                                        margin: const EdgeInsets.only(top: 4.0),
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
                                        margin: const EdgeInsets.only(top: 4.0),
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
                                        margin: const EdgeInsets.only(top: 4.0),
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
                                        margin: const EdgeInsets.only(top: 4.0),
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
          );
        },

      ),
    );
  }
}
