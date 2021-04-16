import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:ipackage/modules/BetaApiAssistant.dart';
import 'package:ipackage/modules/Country.dart';
import 'package:ipackage/modules/LocalAssistant.dart';

class Countries extends StatefulWidget {
  @override
  _CountriesState createState() => _CountriesState();
}

class _CountriesState extends State<Countries> {

  BetaApiAssistant betaApi = new BetaApiAssistant();
  LocalAssistant localAssistant = new LocalAssistant();

  bool _isLoading = true;
  List<Country> _rCountries = [];


  @override
  void initState() {
    super.initState();

    betaApi.getCountries().then((value) {
      setState(() {
        _rCountries = List.of(value);

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

    return Container(
      child: _isLoading ?
      Center(
        child: GFLoader(
          type:GFLoaderType.circle,
          loaderColorOne: Color(0xff07898B),
          loaderColorTwo: Color(0xff07898B),
          loaderColorThree: Color(0xff07898B),
        ),
      ) :
      Row(
        children: <Widget>[


          Flexible(
            child: ListView.builder(
              itemCount: _rCountries.length,
                shrinkWrap: true,
                itemBuilder: (context , index){

                 return Container(
                    width: screenWidth * 0.65,
                    padding: const EdgeInsets.all(10.0),
                    child: GestureDetector(
                      onTap: () {},
                      child: InkWell(
                        borderRadius: BorderRadius.circular(4.0),
                        onTap: () {
                          // Navigator.of(context).push(new MaterialPageRoute(
                          //     builder: (BuildContext context) => new CityTrips()));
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7.0),
                          ),
                          clipBehavior: Clip.antiAlias,
                          elevation: 0.5,
                          margin: const EdgeInsets.all(0.0),
                          color: Colors.white,
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
                                              BorderRadius.circular(7.0)),
                                        ),
                                        child: Image.network(
                                          'https://ipackagetours.com/storage/app/' + _rCountries[index].image,
                                          fit: BoxFit.fill,
                                          height: screenHeight * 0.24,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(0),
                                      child: Flex(
                                        direction: Axis.vertical,
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: <Widget>[
                                          Opacity(opacity: 0.6,
                                          child: Container(
                                            color: Colors.blueGrey,
                                            width: screenWidth * 0.94,
                                            height: screenHeight * 0.065,
                                            margin: EdgeInsets.only(
                                                    top: screenHeight * 0.175),
                                          ),),
                                        ],
                                      ),
                                    ),
                                    Positioned.fill(
                                      bottom: screenHeight * 0.02,
                                      child: Align(
                                        alignment: AlignmentDirectional.bottomCenter,
                                        child: Text(
                                          localAssistant.getCountryByLocale(context, _rCountries[index]),
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
            }),
          ),
        ],
      ),
    );
  }
}
