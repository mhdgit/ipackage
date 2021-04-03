import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:ipackage/localization/localizationValues.dart';
import 'package:ipackage/modules/City.dart';
import 'package:ipackage/modules/my_icons.dart';
import 'package:ipackage/widgets/home/home.dart';
import 'package:ipackage/widgets/settings.dart';

class PlanYourTrip extends StatefulWidget {
  @override
  _PlanYourTripState createState() => _PlanYourTripState();
}

class _PlanYourTripState extends State<PlanYourTrip>
    with TickerProviderStateMixin {
  TabController _tabController;
  int _selectedTabBar = 0;

  //Stage 0
  List<City> _cities = [
    City(id: 1, enName: 'Egypt', arName: 'مصر'),
    City(id: 2, enName: 'Turkey', arName: 'تركيا'),
    City(id: 3, enName: 'Italy', arName: 'إيطاليا'),
  ];

  List<String> _types = [
    'باقة عائلية',
    'سياحة',
    'مجموعة سياحية',
    'تخييم',
  ];

  //Stage 1
  var _pickedDate;
  int _daysNumber = 2;

  //Stage 2
  bool _is3Star = false;
  bool _is4Star = false;
  bool _is5Star = false;
  bool _isAllStar = false;
  bool _isTransfer = false;
  bool _isBreakfast = false;

  //Stage 3
  int _adultsNumber = 2;
  int _childrenNumber = 2;
  int _babiesNumber = 2;

  //Stage 4
  final TextEditingController _nameController = new TextEditingController();
  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _whatsAppController = new TextEditingController();
  final TextEditingController _budgetController = new TextEditingController();
  final TextEditingController _notesController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 6, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  void _showCitiesDialog(context, screenHeight, screenWidth) {
    showDialog(
        context: context,
        builder: (BuildContext bc) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                top: screenHeight * 0.66,
              ),
              child: Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                )),
                elevation: 16,
                child: StatefulBuilder(builder: (context, setState) {
                  return Container(
                    padding: EdgeInsets.all(8.0),
                    height: screenHeight * 0.17,
                    width: screenWidth * 0.9,
                    child: Column(
                      children: <Widget>[
                        for (int i = 0; i < _cities.length; i++)
                          Row(
                            children: <Widget>[
                              InkWell(
                                onTap: () {},
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Text(
                                    _cities[i].arName,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
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

  void _showTypesDialog(context, screenHeight, screenWidth) {
    showDialog(
        context: context,
        builder: (BuildContext bc) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                top: screenHeight * 0.7,
              ),
              child: Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                )),
                elevation: 16,
                child: StatefulBuilder(builder: (context, setState) {
                  return Container(
                    padding: EdgeInsets.all(8.0),
                    height: screenHeight * 0.17,
                    width: screenWidth * 0.9,
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          for (int i = 0; i < _types.length; i++)
                            Row(
                              children: <Widget>[
                                InkWell(
                                  onTap: () {},
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Text(
                                      _types[i].toString(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
          );
        });
  }

  _navigationBar(width, height) {
    return Container(
      width: width * 0.9,
      height: height * 0.13,
      color: Color(0xff07898B),
      margin: EdgeInsets.symmetric(vertical: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 50,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.03),
              child: GFButton(
                size: 50,
                onPressed: () {
                  if (_selectedTabBar > 0)
                    setState(() {
                      _selectedTabBar -= 1;
                    });
                },
                color: Color(0xffFECD44),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black,
                        size: 15.0,
                      ),
                      Text(
                        getTranslated(context, 'book_trip_previous'),
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 50,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.03),
              child: GFButton(
                size: 50,
                onPressed: () {
                  if (_selectedTabBar < 5)
                    setState(() {
                      _selectedTabBar += 1;
                    });
                },
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        getTranslated(context, 'book_trip_next'),
                        style: TextStyle(fontSize: 14, color: Colors.black),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.black,
                        size: 15.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _presentDatePicker() {
    showDatePicker(
        confirmText: 'Set',
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2018),
        lastDate: DateTime.now(),
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
      });
    });
  }

  void _showDaysDialog(context, screenHeight, screenWidth) {
    showDialog(
        context: context,
        builder: (BuildContext bc) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                top: screenHeight * 0.7,
              ),
              child: Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                )),
                elevation: 16,
                child: StatefulBuilder(builder: (context, setState) {
                  return Container(
                    padding: EdgeInsets.all(8.0),
                    height: screenHeight * 0.1,
                    width: screenWidth * 0.9,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                getTranslated(context, 'book_trip_days_2'),
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
                                      onPressed: () {
                                        if (_daysNumber > 1)
                                          setState(() {
                                            _daysNumber -= 1;
                                          });
                                      },
                                    ),
                                    Container(
                                      child: Text(
                                        _daysNumber.toString(),
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
                                      onPressed: () {
                                        if (_daysNumber < 50)
                                          setState(() {
                                            _daysNumber += 1;
                                          });
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

  void _showAdultsDialog(context, screenHeight, screenWidth) {
    showDialog(
        context: context,
        builder: (BuildContext bc) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                top: screenHeight * 0.36,
              ),
              child: Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                )),
                elevation: 16,
                child: StatefulBuilder(builder: (context, setState) {
                  return Container(
                    padding: EdgeInsets.all(8.0),
                    height: screenHeight * 0.1,
                    width: screenWidth * 0.9,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              flex: 50,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: FittedBox(
                                  child: Text(
                                    getTranslated(
                                        context, 'book_trip_adults_number'),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                  ),
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
                                      onPressed: () {
                                        if (_adultsNumber > 1)
                                          setState(() {
                                            _adultsNumber -= 1;
                                          });
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
                                      onPressed: () {
                                        if (_adultsNumber < 50)
                                          setState(() {
                                            _adultsNumber += 1;
                                          });
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

  void _showChildrenDialog(context, screenHeight, screenWidth) {
    showDialog(
        context: context,
        builder: (BuildContext bc) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                top: screenHeight * 0.505,
              ),
              child: Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                )),
                elevation: 16,
                child: StatefulBuilder(builder: (context, setState) {
                  return Container(
                    padding: EdgeInsets.all(8.0),
                    height: screenHeight * 0.1,
                    width: screenWidth * 0.9,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              flex: 50,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: FittedBox(
                                  child: Text(
                                    getTranslated(
                                        context, 'book_trip_children_number'),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                  ),
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
                                      onPressed: () {
                                        if (_childrenNumber > 0)
                                          setState(() {
                                            _childrenNumber -= 1;
                                          });
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
                                      onPressed: () {
                                        if (_childrenNumber < 50)
                                          setState(() {
                                            _childrenNumber += 1;
                                          });
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

  void _showBabiesDialog(context, screenHeight, screenWidth) {
    showDialog(
        context: context,
        builder: (BuildContext bc) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                top: screenHeight * 0.66,
              ),
              child: Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                )),
                elevation: 16,
                child: StatefulBuilder(builder: (context, setState) {
                  return Container(
                    padding: EdgeInsets.all(8.0),
                    height: screenHeight * 0.1,
                    width: screenWidth * 0.9,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              flex: 50,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: FittedBox(
                                  child: Text(
                                    getTranslated(
                                        context, 'book_trip_babies_number'),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                  ),
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
                                      onPressed: () {
                                        if (_babiesNumber > 0)
                                          setState(() {
                                            _babiesNumber -= 1;
                                          });
                                      },
                                    ),
                                    Container(
                                      child: Text(
                                        _babiesNumber.toString(),
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
                                      onPressed: () {
                                        if (_babiesNumber < 50)
                                          setState(() {
                                            _babiesNumber += 1;
                                          });
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

  _stage0Widget(width, height) {
    return Column(
      children: <Widget>[
        Container(
          width: width * 0.9,
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Card(
            shadowColor: Colors.white,
            elevation: 0.0,
            clipBehavior: Clip.antiAlias,
            margin: const EdgeInsets.all(0.0),
            color: Color(0xffFAFAFA),
            child: Padding(
              padding: const EdgeInsets.all(0),
              child: ClipPath(
                clipper: ShapeBorderClipper(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7.0)),
                ),
                child: Image.asset(
                  'assets/images/flight.jpg',
                  fit: BoxFit.fill,
                  height: height * 0.26,
                ),
              ),
            ),
          ),
        ),
        Container(
          width: width * 0.9,
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Container(
            width: width * 0.84,
            padding:
                EdgeInsets.only(top: 0.0, right: 0.0, left: 0.0, bottom: 0.0),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.white,
                side: BorderSide(color: Colors.black, width: 1),
              ),
              onPressed: () {
                _showCitiesDialog(context, height, width);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 90,
                    child: Text(
                      getTranslated(context, 'book_trip_label'),
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
        ),
        Container(
          width: width * 0.9,
          child: Container(
            width: width * 0.84,
            padding:
                EdgeInsets.only(top: 0.0, right: 0.0, left: 0.0, bottom: 0.0),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.white,
                side: BorderSide(color: Colors.black, width: 1),
              ),
              onPressed: () {
                _showTypesDialog(context, height, width);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 90,
                    child: Text(
                      getTranslated(context, 'book_trip_label_2'),
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
        ),
        _navigationBar(width, height),
      ],
    );
  }

  _stage1Widget(width, height) {
    return Column(
      children: <Widget>[
        Container(
          width: width * 0.9,
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Card(
            shadowColor: Colors.white,
            elevation: 0.0,
            clipBehavior: Clip.antiAlias,
            margin: const EdgeInsets.all(0.0),
            color: Color(0xffFAFAFA),
            child: Padding(
              padding: const EdgeInsets.all(0),
              child: ClipPath(
                clipper: ShapeBorderClipper(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7.0)),
                ),
                child: Image.asset(
                  'assets/images/forest.jpg',
                  fit: BoxFit.fill,
                  height: height * 0.26,
                ),
              ),
            ),
          ),
        ),
        Container(
          width: width * 0.9,
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Container(
            width: width * 0.84,
            padding:
                EdgeInsets.only(top: 0.0, right: 0.0, left: 0.0, bottom: 0.0),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.white,
                side: BorderSide(color: Colors.black, width: 1),
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
                      getTranslated(context, 'pyt_in_t_date_btn'),
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
        ),
        Container(
          width: width * 0.9,
          child: Container(
            width: width * 0.84,
            padding:
                EdgeInsets.only(top: 0.0, right: 0.0, left: 0.0, bottom: 0.0),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.white,
                side: BorderSide(color: Colors.black, width: 1),
              ),
              onPressed: () {
                _showDaysDialog(context, height, width);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 90,
                    child: Text(
                      getTranslated(context, 'book_trip_days'),
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
        ),
        _navigationBar(width, height),
      ],
    );
  }

  _stage2Widget(width, height) {
    return Column(
      children: <Widget>[
        Container(
          width: width * 0.9,
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Card(
            shadowColor: Colors.white,
            elevation: 0.0,
            clipBehavior: Clip.antiAlias,
            margin: const EdgeInsets.all(0.0),
            color: Color(0xffFAFAFA),
            child: Padding(
              padding: const EdgeInsets.all(0),
              child: ClipPath(
                clipper: ShapeBorderClipper(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7.0)),
                ),
                child: Image.asset(
                  'assets/images/hotel.jpg',
                  fit: BoxFit.fill,
                  height: height * 0.26,
                ),
              ),
            ),
          ),
        ),
        Container(
          width: width * 0.9,
          padding:
              EdgeInsets.only(top: 5.0, right: 0.0, left: 0.0, bottom: 5.0),
          child: Row(
            children: [
              Expanded(
                flex: 50,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor:
                          _is3Star ? Color(0xff07898B) : Colors.white,
                      side: BorderSide(color: Colors.black, width: 1),
                    ),
                    onPressed: () {
                      setState(() {
                        _is3Star = !_is3Star;
                      });
                    },
                    child: Text(
                      getTranslated(context, 'book_trip_3_stars'),
                      style: TextStyle(
                        fontSize: 14,
                        color: _is3Star ? Colors.white : Color(0xff07898B),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 50,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor:
                          _is4Star ? Color(0xff07898B) : Colors.white,
                      side: BorderSide(color: Colors.black, width: 1),
                    ),
                    onPressed: () {
                      setState(() {
                        _is4Star = !_is4Star;
                      });
                    },
                    child: Text(
                      getTranslated(context, 'book_trip_4_stars'),
                      style: TextStyle(
                        fontSize: 14,
                        color: _is4Star ? Colors.white : Color(0xff07898B),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          width: width * 0.9,
          padding:
              EdgeInsets.only(top: 5.0, right: 0.0, left: 0.0, bottom: 5.0),
          child: Row(
            children: [
              Expanded(
                flex: 50,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor:
                          _is5Star ? Color(0xff07898B) : Colors.white,
                      side: BorderSide(color: Colors.black, width: 1),
                    ),
                    onPressed: () {
                      setState(() {
                        _is5Star = !_is5Star;
                      });
                    },
                    child: Text(
                      getTranslated(context, 'book_trip_5_stars'),
                      style: TextStyle(
                        fontSize: 14,
                        color: _is5Star ? Colors.white : Color(0xff07898B),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 50,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor:
                          _isAllStar ? Color(0xff07898B) : Colors.white,
                      side: BorderSide(color: Colors.black, width: 1),
                    ),
                    onPressed: () {
                      setState(() {
                        _isAllStar = !_isAllStar;
                      });
                    },
                    child: Text(
                      getTranslated(context, 'book_trip_all_stars'),
                      style: TextStyle(
                        fontSize: 14,
                        color: _isAllStar ? Colors.white : Color(0xff07898B),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          width: width * 0.9,
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            children: [
              Container(
                padding: EdgeInsetsDirectional.only(
                    start: 10.0, top: 0.0, bottom: 0.0),
                child: Text(
                  getTranslated(context, 'book_trip_addition'),
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
        Container(
          width: width * 0.9,
          padding:
              EdgeInsets.only(top: 5.0, right: 0.0, left: 0.0, bottom: 5.0),
          child: Row(
            children: [
              Expanded(
                flex: 50,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: BorderSide(
                          color: _isTransfer ? Color(0xff07898B) : Colors.black,
                          width: 1),
                    ),
                    onPressed: () {
                      setState(() {
                        _isTransfer = !_isTransfer;
                      });
                    },
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.check_circle_outline,
                              size: 20,
                              color: _isTransfer
                                  ? Color(0xff07898B)
                                  : Colors.white,
                            ),
                          ],
                        ),
                        Image.asset(
                          'assets/images/car.jpg',
                          fit: BoxFit.fill,
                          height: height * 0.06,
                        ),
                        Text(
                          getTranslated(
                              context, 'home_offer_card_transportation'),
                          style: TextStyle(
                            fontSize: 14,
                            color:
                                _isTransfer ? Color(0xff07898B) : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 50,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: BorderSide(
                          color:
                              _isBreakfast ? Color(0xff07898B) : Colors.black,
                          width: 1),
                    ),
                    onPressed: () {
                      setState(() {
                        _isBreakfast = !_isBreakfast;
                      });
                    },
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.check_circle_outline,
                              size: 20,
                              color: _isBreakfast
                                  ? Color(0xff07898B)
                                  : Colors.white,
                            ),
                          ],
                        ),
                        Image.asset(
                          'assets/images/meal.png',
                          fit: BoxFit.fill,
                          height: height * 0.06,
                        ),
                        Text(
                          getTranslated(context, 'home_offer_card_breakfast'),
                          style: TextStyle(
                            fontSize: 14,
                            color:
                                _isBreakfast ? Color(0xff07898B) : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        _navigationBar(width, height),
      ],
    );
  }

  _stage3Widget(width, height) {
    return Column(
      children: <Widget>[
        Container(
          width: width * 0.9,
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            children: [
              Container(
                padding: EdgeInsetsDirectional.only(
                    start: 10.0, top: 0.0, bottom: 0.0),
                child: Text(
                  getTranslated(context, 'book_trip_adults_number'),
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
        Container(
          width: width * 0.9,
          child: Container(
            width: width * 0.84,
            padding:
                EdgeInsets.only(top: 0.0, right: 0.0, left: 0.0, bottom: 0.0),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.white,
                side: BorderSide(color: Colors.black, width: 1),
              ),
              onPressed: () {
                _showAdultsDialog(context, height, width);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 90,
                    child: Text(
                      getTranslated(context, 'book_trip_adults_number'),
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
        ),
        Container(
          width: width * 0.9,
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            children: [
              Container(
                padding: EdgeInsetsDirectional.only(
                    start: 10.0, top: 0.0, bottom: 0.0),
                child: Text(
                  getTranslated(context, 'book_trip_children_number'),
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
        Container(
          width: width * 0.9,
          child: Container(
            width: width * 0.84,
            padding:
                EdgeInsets.only(top: 0.0, right: 0.0, left: 0.0, bottom: 0.0),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.white,
                side: BorderSide(color: Colors.black, width: 1),
              ),
              onPressed: () {
                _showChildrenDialog(context, height, width);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 90,
                    child: Text(
                      getTranslated(context, 'book_trip_children_number'),
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
        ),
        Container(
          width: width * 0.9,
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            children: [
              Container(
                padding: EdgeInsetsDirectional.only(
                    start: 10.0, top: 0.0, bottom: 0.0),
                child: Text(
                  getTranslated(context, 'book_trip_babies_number'),
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
        Container(
          width: width * 0.9,
          child: Container(
            width: width * 0.84,
            padding:
                EdgeInsets.only(top: 0.0, right: 0.0, left: 0.0, bottom: 0.0),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.white,
                side: BorderSide(color: Colors.black, width: 1),
              ),
              onPressed: () {
                _showBabiesDialog(context, height, width);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 90,
                    child: Text(
                      getTranslated(context, 'book_trip_babies_number'),
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
        ),
        _navigationBar(width, height),
      ],
    );
  }

  _stage4Widget(width, height) {
    return Column(
      children: <Widget>[
        Container(
          width: width * 0.9,
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            children: [
              Container(
                padding: EdgeInsetsDirectional.only(
                    start: 10.0, top: 0.0, bottom: 0.0),
                child: Text(
                  getTranslated(context, 'book_trip_full_name'),
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
        Container(
          width: width * 0.9,
          child: TextField(
            keyboardType: TextInputType.text,
            controller: _nameController,
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
            ),
            textAlign: TextAlign.start,
            decoration: InputDecoration(
                hintText: getTranslated(context, 'book_trip_full_name'),
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
          ),
        ),

        Container(
          width: width * 0.9,
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            children: [
              Container(
                padding: EdgeInsetsDirectional.only(
                    start: 10.0, top: 0.0, bottom: 0.0),
                child: Text(
                  getTranslated(context, 'book_trip_email'),
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
        Container(
          width: width * 0.9,
          child: TextField(
            keyboardType: TextInputType.text,
            controller: _emailController,
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
            ),
            textAlign: TextAlign.start,
            decoration: InputDecoration(
                hintText: getTranslated(context, 'book_trip_email'),
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
          ),
        ),

        Container(
          width: width * 0.9,
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            children: [
              Container(
                padding: EdgeInsetsDirectional.only(
                    start: 10.0, top: 0.0, bottom: 0.0),
                child: Text(
                  getTranslated(context, 'book_trip_whats_app'),
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
        Container(
          width: width * 0.9,
          child: TextField(
            keyboardType: TextInputType.text,
            controller: _whatsAppController,
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
            ),
            textAlign: TextAlign.start,
            decoration: InputDecoration(
                hintText: getTranslated(context, 'book_trip_whats_app'),
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
          ),
        ),

        Container(
          width: width * 0.9,
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            children: [
              Container(
                padding: EdgeInsetsDirectional.only(
                    start: 10.0, top: 0.0, bottom: 0.0),
                child: Text(
                  getTranslated(context, 'book_trip_budget'),
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
        Container(
          width: width * 0.9,
          child: TextField(
            keyboardType: TextInputType.text,
            controller: _budgetController,
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
            ),
            textAlign: TextAlign.start,
            decoration: InputDecoration(
                hintText: getTranslated(context, 'book_trip_budget'),
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
          ),
        ),

        Container(
          width: width * 0.9,
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            children: [
              Container(
                padding: EdgeInsetsDirectional.only(
                    start: 10.0, top: 0.0, bottom: 0.0),
                child: Text(
                  getTranslated(context, 'book_trip_notes'),
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
        Container(
          width: width * 0.9,
          child: TextField(
            keyboardType: TextInputType.text,
            controller: _notesController,
            maxLines: 3,
            minLines: 3,
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
            ),
            textAlign: TextAlign.start,
            decoration: InputDecoration(
                hintText: getTranslated(context, 'book_trip_note'),
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
          ),
        ),
        Container(
          width: width * 0.9,
          height: height * 0.13,
          color: Color(0xff07898B),
          margin: EdgeInsets.symmetric(vertical: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 50,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                  child: GFButton(
                    size: 50,
                    onPressed: () {
                      if (_selectedTabBar > 0)
                        setState(() {
                          _selectedTabBar -= 1;
                        });
                    },
                    color: Color(0xffFECD44),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.arrow_back_ios,
                            color: Colors.black,
                            size: 15.0,
                          ),
                          Text(
                            getTranslated(context, 'book_trip_previous'),
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 50,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                  child: GFButton(
                    size: 50,
                    onPressed: () {
                      if (_selectedTabBar < 5)
                        setState(() {
                          _selectedTabBar += 1;
                        });
                    },
                    color: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            getTranslated(context, 'book_trip_finish'),
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.black,
                            size: 15.0,
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
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final double screenHeight =
        MediaQuery.of(context).size.height - statusBarHeight - kToolbarHeight;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Card(
                  elevation: 2.0,
                  child: Container(
                    width: screenWidth,
                    padding:
                        EdgeInsets.symmetric(vertical: 40.0, horizontal: 0.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: screenWidth * 0.9,
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                flex: 70,
                                child: Text(
                                  getTranslated(context, 'book_trip_label'),
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Expanded(
                                  flex: 10,
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.phone,
                                      color: Color(0xff07898B),
                                    ),
                                    onPressed: () {},
                                  )),
                              Expanded(
                                  flex: 10,
                                  child: IconButton(
                                    icon: Icon(
                                      MyIcons.whatsapp,
                                      color: Color(0xff1AEA4A),
                                    ),
                                    onPressed: () {},
                                  )),
                              Expanded(
                                  flex: 10,
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.mail_outline,
                                      color: Color(0xff07898B),
                                    ),
                                    onPressed: () {},
                                  )),
                            ],
                          ),
                        ),
                        Container(
                          width: screenWidth * 0.9,
                          padding:
                              EdgeInsetsDirectional.only(top: 0.0, bottom: 0.0),
                          child: TabBar(
                            indicatorColor: Colors.white,
                            // labelColor: Color(0xff07898B),
                            // unselectedLabelColor: Color(0xffB4DCDC),
                            labelPadding: EdgeInsets.all(1.0),
                            indicatorWeight: 4,
                            controller: _tabController,
                            labelStyle: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
                            onTap: (index) {
                              switch (index) {
                                case 0:
                                  setState(() {
                                    _selectedTabBar = 0;
                                  });
                                  break;
                                case 1:
                                  setState(() {
                                    _selectedTabBar = 1;
                                  });
                                  break;
                                case 2:
                                  setState(() {
                                    _selectedTabBar = 2;
                                  });
                                  break;
                                case 3:
                                  setState(() {
                                    _selectedTabBar = 3;
                                  });
                                  break;
                                case 4:
                                  setState(() {
                                    _selectedTabBar = 4;
                                  });
                                  break;
                                case 5:
                                  setState(() {
                                    _selectedTabBar = 5;
                                  });
                                  break;
                              }
                            },
                            tabs: [
                              Tab(
                                child: Container(
                                  height: screenHeight * 0.013,
                                  color: _selectedTabBar == 0
                                      ? Color(0xff07898B)
                                      : Color(0xffB4DCDC),
                                ),
                              ),
                              Tab(
                                child: Container(
                                  height: screenHeight * 0.013,
                                  color: _selectedTabBar == 1
                                      ? Color(0xff07898B)
                                      : Color(0xffB4DCDC),
                                ),
                              ),
                              Tab(
                                child: Container(
                                  height: screenHeight * 0.013,
                                  color: _selectedTabBar == 2
                                      ? Color(0xff07898B)
                                      : Color(0xffB4DCDC),
                                ),
                              ),
                              Tab(
                                child: Container(
                                  height: screenHeight * 0.013,
                                  color: _selectedTabBar == 3
                                      ? Color(0xff07898B)
                                      : Color(0xffB4DCDC),
                                ),
                              ),
                              Tab(
                                child: Container(
                                  height: screenHeight * 0.013,
                                  color: _selectedTabBar == 4
                                      ? Color(0xff07898B)
                                      : Color(0xffB4DCDC),
                                ),
                              ),
                              Tab(
                                child: Container(
                                  height: screenHeight * 0.013,
                                  color: _selectedTabBar == 5
                                      ? Color(0xff07898B)
                                      : Color(0xffB4DCDC),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                width: screenWidth * 0.9,
                                child: Builder(
                                  builder: (BuildContext context) {
                                    if (_selectedTabBar == 5)
                                      return Container();
                                    else if (_selectedTabBar == 4)
                                      return _stage4Widget(
                                          screenWidth, screenHeight);
                                    else if (_selectedTabBar == 3)
                                      return _stage3Widget(
                                          screenWidth, screenHeight);
                                    else if (_selectedTabBar == 2)
                                      return _stage2Widget(
                                          screenWidth, screenHeight);
                                    else if (_selectedTabBar == 1)
                                      return _stage1Widget(
                                          screenWidth, screenHeight);
                                    else
                                      return _stage0Widget(
                                          screenWidth, screenHeight);
                                  },
                                )),
                          ],
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
        new MaterialPageRoute(builder: (BuildContext context) => new Home()),
      );
    } else if (index == 1) {
      Navigator.of(context).push(
        new MaterialPageRoute(
            builder: (BuildContext context) => new PlanYourTrip()),
      );
    } else if (index == 2) {
      // Navigator.of(context).push(new MaterialPageRoute(
      //     builder: (BuildContext context) => new MyAccount()));
    } else if (index == 3) {
      Navigator.of(context).push(new MaterialPageRoute(
          builder: (BuildContext context) => new Settings()));
    }
  }
}
