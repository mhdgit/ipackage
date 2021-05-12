import 'package:dropdown_below/dropdown_below.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:getwidget/types/gf_loader_type.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:intl/intl.dart';
import 'package:ipackage/localization/localizationValues.dart';
import 'package:ipackage/modules/BetaApiAssistant.dart';
import 'package:ipackage/modules/Country.dart';
import 'package:ipackage/modules/LocalAssistant.dart';
import 'package:ipackage/modules/Offer/Airport.dart';
import 'package:ipackage/modules/Package.dart';
import 'package:ipackage/modules/my_icons.dart';
import 'package:ipackage/widgets/search/search_results.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ForeignTour extends StatefulWidget {
  @override
  _ForeignTourState createState() => _ForeignTourState();
}

class _ForeignTourState extends State<ForeignTour> {

  BetaApiAssistant betaApiAssistant = new BetaApiAssistant();
  LocalAssistant localAssistant = new LocalAssistant();
  SharedPreferences prefs;
  final TextEditingController _nameController = new TextEditingController();
  var fullFormatter = new DateFormat('yyyy-MM-dd');
  List<Country> _countries = [];
  List<Package> _packages = [];

  var _pickedDate;
  int _adultsNumber = 2;
  int _childrenNumber = 0;
  bool _isFlight = false;
  String _sourceBtnLabel = ' ';
  String _destinationBtnLabel = ' ';
  int _destinationCountryId = 0;
  int _packageId = 0;
  String _departureDate = ' ';
  String _packageBtnLabel = ' ';
  List<Airport> _airports = [];
  bool _isAirportResults = false;
  bool _isAirportLoading = true;
  bool _isNotLocked = true;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    SharedPreferences.getInstance().then((value) {
      prefs = value;

      _loadUserPreferences();
      betaApiAssistant.getCountries().then((value) {
        setState(() {
          _countries = List.of(value);
        });

        betaApiAssistant.getPackages().then((value2) {
          setState(() {
            _packages = List.of(value2);
            _isLoading = false;
          });
        });
      });

    });

  }

  void _presentDatePicker() async{

    showDatePicker(
        confirmText: 'Set',
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2018),
        lastDate: DateTime.now().add(Duration(days: 730)),
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: Color(0xff07898B),
              accentColor: Color(0xff07898B),
              colorScheme: ColorScheme.light(primary: const Color(0xff07898B)),
              buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
            ),
            child: child,
          );
        }).then((selectedDate) {
      if (selectedDate == null) return;
      setState(() {
        _pickedDate = selectedDate;
        _departureDate = fullFormatter.format(_pickedDate).toString();

        prefs.setString('departure_date', fullFormatter.format(_pickedDate).toString());
      });
    });
  }

  void _showMembersDialog(context, screenHeight , screenWidth) {
    showDialog(
        context: context,
        builder: (BuildContext bc) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.66,),
              child: Dialog(
                shape:
                    RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20) , bottomRight: Radius.circular(20) ,)),
                elevation: 16,
                child: StatefulBuilder(builder: (context, setState) {
                  return Container(
                    padding: EdgeInsets.all(8.0),
                    height: screenHeight * 0.17,
                    width: screenWidth * 0.84,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                getTranslated(context, 'pyt_in_t_adult_label'),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Container(
                              height: 40,
                              child: FittedBox(
                                child: Row(
                                  children: <Widget>[
                                    MaterialButton(
                                      padding: const EdgeInsets.all(2.0),
                                      shape: CircleBorder(
                                        side: BorderSide(
                                            width: 2,
                                            color: Color(0xff07898B),
                                            style: BorderStyle.solid),
                                      ),
                                      child: Icon(
                                        MyIcons.minus,
                                        size: 10,
                                        color: Color(0xff07898B),
                                      ),
                                      color: Colors.white,
                                      onPressed: ()
                                      {
                                        if(_adultsNumber > 1)
                                          setState(() {
                                            _adultsNumber -= 1;
                                          });
                                        prefs.setInt('adults_number', _adultsNumber);
                                      },
                                    ),

                                    Container(
                                      child: Text(
                                        _adultsNumber.toString(),
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xff07898B),
                                        ),
                                      ),
                                    ),

                                    MaterialButton(
                                      padding: const EdgeInsets.all(2.0),
                                      shape: CircleBorder(
                                        side: BorderSide(
                                            width: 2,
                                            color: Color(0xff07898B),
                                            style: BorderStyle.solid),
                                      ),
                                      child: Icon(
                                        Icons.add,
                                        size: 15,
                                        color: Color(0xff07898B),
                                      ),
                                      color: Colors.white,
                                      onPressed: ()
                                      {
                                        if(_adultsNumber < 200)
                                          setState(() {
                                            _adultsNumber += 1;
                                          });
                                        prefs.setInt('adults_number', _adultsNumber);
                                      },
                                    ),

                                  ],
                                ),
                              ),
                            )

                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                getTranslated(context, 'pyt_in_t_children_label'),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Container(
                              height: 40,
                              child: FittedBox(
                                child: Row(
                                  children: <Widget>[
                                    MaterialButton(
                                      padding: const EdgeInsets.all(2.0),
                                      shape: CircleBorder(
                                        side: BorderSide(
                                            width: 2,
                                            color: Color(0xff07898B),
                                            style: BorderStyle.solid),
                                      ),
                                      child: Icon(
                                        MyIcons.minus,
                                        size: 10,
                                        color: Color(0xff07898B),
                                      ),
                                      color: Colors.white,
                                      onPressed: ()
                                      {
                                        if(_childrenNumber > 0)
                                          setState(() {
                                            _childrenNumber -= 1;
                                          });
                                        prefs.setInt('children_number', _childrenNumber);
                                      },
                                    ),

                                    Container(
                                      child: Text(
                                        _childrenNumber.toString(),
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xff07898B),
                                        ),
                                      ),
                                    ),

                                    MaterialButton(
                                      padding: const EdgeInsets.all(2.0),
                                      shape: CircleBorder(
                                        side: BorderSide(
                                            width: 2,
                                            color: Color(0xff07898B),
                                            style: BorderStyle.solid),
                                      ),
                                      child: Icon(
                                        Icons.add,
                                        size: 15,
                                        color: Color(0xff07898B),
                                      ),
                                      color: Colors.white,
                                      onPressed: ()
                                      {
                                        if(_childrenNumber < 200)
                                          setState(() {
                                            _childrenNumber += 1;
                                          });
                                        prefs.setInt('children_number', _childrenNumber);
                                      },
                                    ),

                                  ],
                                ),
                              ),
                            )

                          ],
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
          );
        });
  }

  _openSourceWidget(context , screenWidth, screenHeight) {

    showDialog(
        context: context,
        builder: (BuildContext bc) {
          return Dialog(
            child: StatefulBuilder(builder: (context, setState) {
              return Container(
                padding: EdgeInsets.all(0.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        width: screenWidth * 0.9,
                        color: Color(0xff07898B),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            getTranslated(context, 'fo_edit'),
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16 , color: Colors.white),
                          ),
                        ),
                      ),

                      Container(
                        width: screenWidth * 0.9,
                        padding: const EdgeInsets.symmetric(vertical: 10.0 , horizontal: 8.0),
                        child: TextField(
                          controller: _nameController,
                          keyboardType: TextInputType.text,
                          // controller: _emailController,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.start,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(vertical: 1.0 , horizontal: 6.0),
                              hintText: getTranslated(context, 'pyt_in_t_source_btn'),
                              hintStyle: TextStyle(
                                fontSize: 14.0,
                                color: Color(0xffC3C2C3),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: BorderSide(
                                  width: 1,
                                  color: Colors.black,
                                ),
                              ),
                              fillColor: Colors.white,
                              focusColor: Colors.black,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: BorderSide(
                                  width: 1,
                                  color: Colors.black,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: BorderSide(
                                  width: 1,
                                  color: Colors.black,
                                ),
                              ),
                              filled: true),

                          onChanged: (key){

                            if(_nameController.text == '')
                              setState((){
                                _isAirportResults = false;
                              });
                            else
                            {
                              setState((){
                                _isAirportResults = true;

                                betaApiAssistant.getAirport(key).then((value) {
                                  _airports = List.of(value);
                                  setState((){
                                    _isAirportLoading = false;
                                  });
                                });
                              });
                            }
                          },
                        ),
                      ),
                      Visibility(
                        visible: _isAirportResults,
                        child: Container(
                          width: screenWidth * 0.9,
                          child: _isAirportLoading ?
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
                            child: _airports.length == 0 ?
                            Center(child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                getTranslated(context, 'fo_no_airports'),
                              ),
                            ),)
                                :
                            Column(
                              children: <Widget>[
                                for(int index = 0 ; index < _airports.length ; index++)
                                  ListTile(
                                    onTap: () async{

                                      setState((){
                                        _isNotLocked = false;
                                        _nameController.text = localAssistant.getAirportByLocale(context,
                                            _airports[index]).toString() + '-' + _airports[index].iata;

                                        prefs.setString('source_airport_code', _airports[index].iata);

                                        prefs.setString('source_airport', localAssistant.getAirportByLocale(context,
                                            _airports[index]).toString());

                                        updateSourceAirport(_airports[index].iata);

                                        _isAirportResults = false;
                                        _isNotLocked = true;
                                      });

                                    },
                                    contentPadding:const EdgeInsets.symmetric(vertical: 2.0, horizontal: 16.0),
                                    leading: Icon(MyIcons.plane_arrival, color: Color(0xff07898B),),
                                    title: Text(
                                      localAssistant.getAirportByLocale(context,
                                          _airports[index]).toString(),
                                      style: TextStyle(
                                        fontSize: 15.0,
                                        fontFamily: 'cairo',
                                      ),
                                    ),
                                    trailing: Text(
                                      _airports[index].iata.toString(),
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontFamily: 'cairo',
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
                        child: GFButton(
                          color: Color(0xff07898b),
                          textColor: Colors.white,
                          fullWidthButton: true,
                          // text: getTranslated(context, 'fo_edit_save'),
                          size: 50.0,
                          // textStyle: TextStyle(
                          //   fontSize: 18.0,
                          //   fontFamily: 'cairo',
                          //   fontWeight: FontWeight.bold,
                          // ),
                          child: !_isNotLocked ?
                          GFLoader(
                            type: GFLoaderType.circle,
                            loaderColorOne: Colors.white,
                            loaderColorTwo: Colors.white,
                            loaderColorThree: Colors.white,
                          )
                              :
                          Text(
                            getTranslated(context, 'fo_edit_save'),
                            style: TextStyle(
                              fontSize: 18.0,
                              fontFamily: 'cairo',
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () {

                            if(_isNotLocked)
                            {
                              Navigator.of(context).pop();
                            }

                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          );
        });
  }

  _showPackagesDialog(context , screenWidth, screenHeight) {

    showDialog(
        context: context,
        builder: (BuildContext bc) {
          return Dialog(
            child: StatefulBuilder(builder: (context, setState) {
              return Container(
                padding: EdgeInsets.all(0.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        width: screenWidth * 0.9,
                        color: Color(0xff07898B),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            getTranslated(context, 'pyt_in_t_package_btn'),
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16 , color: Colors.white),
                          ),
                        ),
                      ),

                      for(int index = 0 ; index < _packages.length ; index++)
                        ListTile(
                          onTap: () async{

                            prefs.setInt('package_id', _packages[index].id);
                            prefs.setString('package_name', localAssistant.getPackageByLocale(context,
                                _packages[index]).toString());

                            setState((){
                              updatePackage(localAssistant.getPackageByLocale(context,
                                  _packages[index]).toString());

                              _packageId = _packages[index].id;
                            });
                            Navigator.of(context).pop();

                          },
                          contentPadding:const EdgeInsets.symmetric(vertical: 2.0, horizontal: 16.0),
                          // leading: Icon(MyIcons.plane_arrival, color: Color(0xff07898B),),
                          title: Text(
                            localAssistant.getPackageByLocale(context,
                                _packages[index]).toString(),
                            style: TextStyle(
                              fontSize: 15.0,
                              fontFamily: 'cairo',
                            ),
                          ),
                          // trailing: Text(
                          //   _airports[index].iata.toString(),
                          //   style: TextStyle(
                          //     fontSize: 16.0,
                          //     fontFamily: 'cairo',
                          //     fontWeight: FontWeight.bold,
                          //   ),
                          // ),
                        ),

                    ],
                  ),
                ),
              );
            }),
          );
        });
  }

  void updatePackage(String name)
  {
    setState(() {
      _packageBtnLabel = name;
    });
  }

  void updateSourceAirport(String name)
  {
    setState(() {
      _sourceBtnLabel = name;
    });
  }

  void _loadUserPreferences() async{

    final key = 'source_airport_code';
    final value = prefs.getString(key);
    if(value != null)
      setState(() {
        _sourceBtnLabel = value;
      });

    final key6 = 'source_airport';
    final value6 = prefs.getString(key6);
    if(value6 != null)
      setState(() {
        _nameController.text = value6 + ' - ' + value.toString();
      });

    final key2 = 'destination_country';
    final value2 = prefs.getString(key2);
    if(value2 != null)
      setState(() {
        _destinationBtnLabel = value2;
      });

    final key8 = 'destination_country_id';
    final value8 = prefs.getInt(key8);
    if(value8 != null)
      setState(() {
        _destinationCountryId = value8;
      });

    final key3 = 'departure_date';
    final value3 = prefs.getString(key3);
    if(value3 != null)
      setState(() {
        _departureDate = value3;
      });

    final key4 = 'adults_number';
    final value4 = prefs.getInt(key4);
    if(value4 != null)
      setState(() {
        _adultsNumber = value4;
      });

    final key5 = 'children_number';
    final value5 = prefs.getInt(key5);
    if(value5 != null)
      setState(() {
        _childrenNumber = value5;
      });

    final key7 = 'is_flight';
    final value7 = prefs.getBool(key7);
    if(value7 != null)
      setState(() {
        _isFlight = value7;
      });

    final key9 = 'package_name';
    final value9 = prefs.getString(key9);
    if(value9 != null)
      setState(() {
        _packageBtnLabel = value9;
      });

    final key10 = 'package_id';
    final value10 = prefs.getInt(key10);
    if(value10 != null)
      setState(() {
        _packageId = value10;
      });
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final double screenHeight =
        MediaQuery.of(context).size.height - statusBarHeight - kToolbarHeight;
    final double screenWidth = MediaQuery.of(context).size.width;

    // if(_sourceBtnLabel == ' ')
    // setState(() {
    //   _sourceBtnLabel = getTranslated(context, 'pyt_in_t_source_btn');
    // });

    if(_destinationBtnLabel == ' ')
      setState(() {
        _destinationBtnLabel = getTranslated(context, 'pyt_in_t_des_btn');
      });

    if(_departureDate == ' ')
      setState(() {
        _departureDate = getTranslated(context, 'pyt_in_t_date_btn');
      });

    if(_packageBtnLabel == ' ')
      setState(() {
        _packageBtnLabel = getTranslated(context, 'pyt_in_t_package_btn');
      });

    return _isLoading ?
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
      color: Color(0xff07898B),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(
                  top: 60.0, bottom: 10.0, right: 8, left: 8),
              child: Text(
                getTranslated(context, 'pyt_in_t_label'),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 0.0, bottom: 10.0, right: 15, left: 15),
                child: Text(
                  getTranslated(context, 'pyt_in_t_label_2'),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Container(
              width: screenWidth * 0.84,
              margin: const EdgeInsets.only(top: 18.0),
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Padding(
                  //   padding: const EdgeInsets.only(
                  //       top: 0.0, right: 0.0, left: 0.0, bottom: 0.0),
                  //   child: DropdownBelow(
                  //     itemTextstyle: TextStyle(
                  //         fontSize: 14,
                  //         fontWeight: FontWeight.w400,
                  //         color: Colors.black),
                  //     boxTextstyle: TextStyle(
                  //         fontSize: 14,
                  //         fontWeight: FontWeight.w400,
                  //         color: Color(0XFFbbbbbb)),
                  //     boxHeight: 45,
                  //     boxWidth: screenWidth * 0.4,
                  //     itemWidth: screenWidth * 0.4,
                  //     boxPadding: EdgeInsets.symmetric(horizontal: 8.0,),
                  //     hint: Text(
                  //       getTranslated(context, 'pyt_in_t_source_btn'),
                  //     ),
                  //     onChanged: (value) {},
                  //     items: _cities.map((City city) {
                  //       return new DropdownMenuItem<int>(
                  //         value: city.id,
                  //         child: Container(
                  //           // alignment: Alignment
                  //           //     .centerRight,
                  //           width: MediaQuery.of(context).size.width * 0.5,
                  //           child: Text(
                  //             city.enName,
                  //             // textAlign:
                  //             // TextAlign
                  //             //     .right,
                  //           ),
                  //         ),
                  //       );
                  //     }).toList(),
                  //   ),
                  // ),
                  Container(
                    width: screenWidth * 0.4,
                    padding:
                    EdgeInsets.only(top: 0.0, right: 0.0, left: 0.0, bottom: 0.0),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsetsDirectional.only(top: 10.0, start: 6.0, bottom: 10.0),
                        backgroundColor: Colors.white,
                        side: BorderSide(color: Color(0XFFaaaaa), width: 2),
                      ),
                      onPressed: () {
                        _openSourceWidget(context , screenWidth, screenHeight);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            // flex: 90,
                            child: Text(
                              getTranslated(context, 'pyt_in_t_source_btn')+' '+_sourceBtnLabel,
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0XFFbbbbbb),
                              ),
                            ),
                          ),
                          // Expanded(
                          //   flex: 10,
                          //   child: Icon(
                          //     Icons.arrow_drop_down_outlined,
                          //     color: Colors.white,
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(
                    width: screenWidth * 0.03,
                  ),

                  Padding(
                    padding: const EdgeInsets.only(
                        top: 0.0, right: 0.0, left: 0.0, bottom: 0.0),
                    child: DropdownBelow(
                      itemTextstyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'cairo',
                          color: Colors.black),
                      boxTextstyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'cairo',
                          color: Color(0XFFbbbbbb)),
                      boxHeight: 45,
                      boxWidth: screenWidth * 0.4,
                      itemWidth: screenWidth * 0.4,
                      boxPadding: EdgeInsets.symmetric(horizontal: 8.0,),
                      hint: Text(
                        _destinationBtnLabel,
                      ),
                      onChanged: (value) async{
                        prefs.setString('destination_country', localAssistant.getCountryByLocale(context, value));

                        prefs.setInt('destination_country_id', value.id);

                        setState(() {
                          _destinationBtnLabel = localAssistant.getCountryByLocale(context, value);
                          _destinationCountryId = value.id;
                        });
                      },
                      items: _countries.map((Country country) {
                        return new DropdownMenuItem(
                          value: country,
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Text(
                              localAssistant.getCountryByLocale(context, country),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: screenWidth * 0.84,
              padding:
                  EdgeInsets.only(top: 5.0, right: 0.0, left: 0.0, bottom: 0.0),
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white,
                  side: BorderSide(color: Color(0XFFaaaaa), width: 2),
                ),
                onPressed: () {
                  _presentDatePicker();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      flex: 90,
                      child: Text(
                        _departureDate,
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0XFFbbbbbb),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 10,
                      child: Icon(
                        Icons.date_range_outlined,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: screenWidth * 0.84,
              padding:
                  EdgeInsets.only(top: 10.0, right: 0.0, left: 0.0, bottom: 0.0),
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white,
                  side: BorderSide(color: Color(0XFFaaaaa), width: 2),
                ),
                onPressed: () {
                  _showMembersDialog(context, screenHeight , screenWidth);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      flex: 90,
                      child: Text(
                        getTranslated(context, 'pyt_in_t_number_btn'),
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0XFFbbbbbb),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 10,
                      child: Icon(
                        Icons.arrow_drop_down_outlined,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: screenWidth * 0.84,
              padding:
              EdgeInsets.only(top: 5.0, right: 0.0, left: 0.0, bottom: 0.0),
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white,
                  side: BorderSide(color: Color(0XFFaaaaa), width: 2),
                ),
                onPressed: () {
                  _showPackagesDialog(context , screenWidth, screenHeight);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      // flex: 90,
                      child: Text(
                        _packageBtnLabel,
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0XFFbbbbbb),
                        ),
                      ),
                    ),
                    // Expanded(
                    //   flex: 10,
                    //   child: Icon(
                    //     Icons.date_range_outlined,
                    //     color: Colors.black,
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
            Container(
              width: screenWidth * 0.84,
              padding:
              EdgeInsets.only(top: 10.0, right: 0.0, left: 0.0, bottom: 0.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Expanded(
                    flex: 20,
                    child: Text(
                      getTranslated(context, 'pyt_in_t_flight_btn'),
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 20,
                    child: Switch.adaptive(
                      value: _isFlight,
                      onChanged: (val){
                        setState(() {
                          _isFlight = ! _isFlight;
                        });
                        prefs.setBool('is_flight', _isFlight);
                      },
                      activeColor: Color(0xff07898B),
                      activeTrackColor: Colors.white,
                      inactiveThumbColor: Color(0xff07898B),
                      inactiveTrackColor: Colors.amber,
                    )
                    // GFToggle(
                    //   onChanged: (val){},
                    //   value: null,
                    //   type: GFToggleType.ios,
                    //   disabledThumbColor: Color(0xff07898B),
                    //   disabledTrackColor: Colors.amber,
                    //   enabledTrackColor: Colors.white,
                    //   enabledThumbColor: Color(0xff07898B),
                    // ),
                  ),

                  Expanded(
                    flex: 60,
                    child: Container(
                      height: 1,
                      width: 2,
                    ),
                  )
                ],
              ),
            ),

            Container(
              width: screenWidth * 0.84,
              padding:
              EdgeInsets.only(top: 10.0, right: 0.0, left: 0.0, bottom: 0.0),
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.black,
                  side: BorderSide(color: Colors.black, width: 2),
                ),
                onPressed: () {
                  print(_destinationCountryId);
                  print(_packageId);

                  if(_destinationCountryId != 0 && _packageId != 0)
                    Navigator.of(context).push(new MaterialPageRoute(
                      builder: (BuildContext context) => new SearchResults(
                        countryId: _destinationCountryId,
                        packageId: _packageId,
                      )));
                  else
                    showDialog(
                        context: context,
                        builder: (_) => AssetGiffyDialog(
                          onlyOkButton: true,
                          buttonCancelText: Text(
                              getTranslated(context, 'login_alert_d_cancel'),
                              style: TextStyle(fontSize: 16)),
                          buttonOkText: Text(getTranslated(context, 'login_alert_d_ok'),
                              style: TextStyle(fontSize: 16, color: Colors.white)),
                          buttonOkColor: Colors.redAccent,
                          image: Image.asset('assets/images/alert.png', fit: BoxFit.cover),
                          title: Text(
                            getTranslated(context, 'home_alert_login_title'),
                            style: TextStyle(fontSize: 18.0, color: Colors.teal),
                          ),
                          description: Text(
                            getTranslated(context, 'pyt_in_t_alert'),
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16),
                          ),
                          onOkButtonPressed: () {
                            Navigator.pop(context);
                          },
                        ));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      getTranslated(context, 'pyt_in_t_search_btn'),
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white
                      ),
                      ),
                    Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
