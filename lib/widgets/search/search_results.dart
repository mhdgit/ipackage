import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:ipackage/localization/localizationValues.dart';
import 'package:ipackage/modules/BetaApiAssistant.dart';
import 'package:ipackage/modules/LocalAssistant.dart';
import 'package:ipackage/modules/SpecialForeignOffer.dart';
import 'package:ipackage/modules/my_icons.dart';
import 'package:ipackage/widgets/home/foreign_offer_main.dart';
import 'package:ipackage/widgets/home/home.dart';
import 'package:ipackage/widgets/my_books.dart';
import 'package:ipackage/widgets/plan_your_trip/plan_your_trip.dart';
import 'package:ipackage/widgets/settings.dart';

class SearchResults extends StatefulWidget {

  final int countryId;
  final int packageId;

  SearchResults({this.countryId , this.packageId});

  @override
  _SearchResultsState createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {

  List<SpecialForeignOffer> _specialForeignOffers = [];
  BetaApiAssistant betaApiAssistant = new BetaApiAssistant();
  LocalAssistant localAssistant = new LocalAssistant();

  bool _isLoading = true;


  @override
  void initState() {
    super.initState();

    betaApiAssistant.getSearchResults(widget.countryId, widget.packageId).then((value) {
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

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            'assets/images/logo.jpg',
            height: screenHeight * 0.07,
            fit: BoxFit.fill,
          ),
        ),
      ),
      body: _isLoading ?
      Center(
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: GFLoader(
            type: GFLoaderType.circle,
            loaderColorOne: Color(0xff07898B),
            loaderColorTwo: Color(0xff07898B),
            loaderColorThree: Color(0xff07898B),
          ),
        ),
      )
          :
      Container(
        width: screenWidth,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              Text(
                getTranslated(context,
                    'offers_search_results'),
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff07898B),
                ),
              ),

              for(int index = 0 ; index < _specialForeignOffers.length ; index++)
                Container(
                  width: screenWidth * 0.84,
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: GestureDetector(
                    onTap: () {},
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
                          mainAxisAlignment: MainAxisAlignment.center,
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
                                            BorderRadius.only(topRight: Radius.circular(15),topLeft: Radius.circular(15))),
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
                                        color: Colors.amber,
                                        borderColor: Colors.amber,
                                        allowHalfRating: true,
                                        value: double.parse(_specialForeignOffers[index].rating.toString()),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Container(
                            //   // color: Colors.white,
                            //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            //   child: Row(
                            //     mainAxisAlignment: MainAxisAlignment.start,
                            //     children: [
                            //       Expanded(
                            //         flex: 50,
                            //         child: FittedBox(
                            //           child: GFRating(
                            //             color: Colors.amber,
                            //             borderColor: Colors.amber,
                            //             allowHalfRating: true,
                            //             value: double.parse(widget.rating.toString()),
                            //           ),
                            //         ),
                            //       ),
                            //       Expanded(
                            //         flex: 50,
                            //         child: Padding(
                            //             padding: const EdgeInsets.only(
                            //                 top: 0.0,
                            //                 right: 0.0,
                            //                 left: 0.0,
                            //                 bottom: 0.0),
                            //             child: Text(
                            //               ' ',
                            //               textAlign: TextAlign.start,
                            //               style: TextStyle(
                            //                   fontWeight: FontWeight.bold,
                            //                   fontSize: 15,
                            //                   color: Colors.black),
                            //             )),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            // Container(
                            //   // color: Colors.white,
                            //   padding: const EdgeInsets.symmetric(
                            //       horizontal: 8.0, vertical: 8.0),
                            //   child: Row(
                            //     mainAxisAlignment: MainAxisAlignment.center,
                            //     children: [
                            //       Expanded(
                            //         flex: 50,
                            //         child: Padding(
                            //             padding: const EdgeInsets.only(
                            //                 top: 0.0,
                            //                 right: 0.0,
                            //                 left: 0.0,
                            //                 bottom: 0.0),
                            //             child: Text(
                            //               offer.daysNumber.toString() +' '+ getTranslated(
                            //                   context, 'home_offer_card_days'),
                            //               textAlign: TextAlign.start,
                            //               style: TextStyle(
                            //                   fontWeight: FontWeight.bold,
                            //                   fontSize: 15,
                            //                   color: Colors.black),
                            //             )),
                            //       ),
                            //       Expanded(
                            //         flex: 50,
                            //         child: Text(
                            //           getTranslated(
                            //               context, 'home_offer_card_price') +
                            //               ' 220\$',
                            //           textAlign: TextAlign.end,
                            //           style: TextStyle(
                            //               fontWeight: FontWeight.bold,
                            //               fontSize: 15,
                            //               color: Colors.black),
                            //           softWrap: true,
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ),

                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                getTranslated(context, 'home_offer_card_details'),
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
                                      flex: 25,
                                      child: Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Column(
                                          children: <Widget>[
                                            Icon(
                                              MyIcons.bed,
                                              color: Colors.white,
                                            ),
                                            Container(
                                              margin:
                                              const EdgeInsets.only(top: 4.0),
                                              child: FittedBox(
                                                child: Text(
                                                  getTranslated(context,
                                                      'home_offer_card_rate'),
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
                                      flex: 25,
                                      child: Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Column(
                                          children: <Widget>[
                                            Icon(
                                              Icons.airplanemode_inactive,
                                              color: Colors.white,
                                            ),
                                            Container(
                                              margin:
                                              const EdgeInsets.only(top: 4.0),
                                              child: FittedBox(
                                                child: Text(
                                                  getTranslated(context,
                                                      'home_offer_card_flight'),
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
                                      flex: 25,
                                      child: Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Column(
                                          children: <Widget>[
                                            Image.asset('assets/icons/dish.png'),
                                            Container(
                                              margin:
                                              const EdgeInsets.only(top: 4.0),
                                              child: FittedBox(
                                                child: Text(
                                                  getTranslated(context,
                                                      'home_offer_card_breakfast'),
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
                                      flex: 25,
                                      child: Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Column(
                                          children: <Widget>[
                                            Icon(
                                              Icons.directions_car_outlined,
                                              color: Colors.white,
                                            ),
                                            Container(
                                              margin:
                                              const EdgeInsets.only(top: 4.0),
                                              child: FittedBox(
                                                child: Text(
                                                  getTranslated(context,
                                                      'home_offer_card_transportation'),
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
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        unselectedItemColor: Color(0xff9FD0D2),
        selectedItemColor: Color(0xff07898B),
        onTap: onTabTapped, // new
        currentIndex: 0,
        type: BottomNavigationBarType.fixed,
        items: [
          new BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: getTranslated(context, 'bottom_bar_home_btn'),
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: getTranslated(context, 'bottom_bar_trip_plan_btn'),
          ),
          new BottomNavigationBarItem(
            icon: Icon(MyIcons.basket),
            label: getTranslated(context, 'bottom_bar_my_reservations_btn'),
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: getTranslated(context, 'bottom_bar_settings_btn'),
          ),
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    if (index == 0) {
      Navigator.of(context).push(
        new MaterialPageRoute(
            builder: (BuildContext context) => new Home()),
      );
    } else if (index == 1) {
      Navigator.of(context).push(
        new MaterialPageRoute(
            builder: (BuildContext context) => new PlanYourTrip()),
      );
    } else if (index == 2) {
      Navigator.of(context).push(new MaterialPageRoute(
          builder: (BuildContext context) => new MyBooks()));
    } else if (index == 3) {
      Navigator.of(context).push(new MaterialPageRoute(
          builder: (BuildContext context) => new Settings()));
    }
  }
}
