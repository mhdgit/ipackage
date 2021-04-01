import 'package:dropdown_below/dropdown_below.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:ipackage/localization/localizationValues.dart';
import 'package:ipackage/modules/City.dart';
import 'package:ipackage/modules/my_icons.dart';

class ForeignTour extends StatefulWidget {
  @override
  _ForeignTourState createState() => _ForeignTourState();
}

class _ForeignTourState extends State<ForeignTour> {
  List<City> _cities = [
    City(id: 1, enName: 'Egypt', arName: 'مصر'),
    City(id: 2, enName: 'Turkey', arName: 'تركيا'),
    City(id: 3, enName: 'Italy', arName: 'إيطاليا'),
  ];

  var _pickedDate;
  int _adultsNumber = 2;
  int _childrenNumber = 2;
  bool _isFlight = false;

  @override
  void initState() {
    super.initState();
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
                                        if(_childrenNumber > 1)
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
                                      onPressed: ()
                                      {
                                        if(_childrenNumber < 200)
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


  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final double screenHeight =
        MediaQuery.of(context).size.height - statusBarHeight - kToolbarHeight;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      color: Color(0xff07898B),
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
                Padding(
                  padding: const EdgeInsets.only(
                      top: 0.0, right: 0.0, left: 0.0, bottom: 0.0),
                  child: DropdownBelow(
                    itemTextstyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                    boxTextstyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0XFFbbbbbb)),
                    boxHeight: 45,
                    boxWidth: screenWidth * 0.4,
                    itemWidth: screenWidth * 0.4,
                    boxPadding: EdgeInsets.symmetric(horizontal: 8.0,),
                    hint: Text(
                      getTranslated(context, 'pyt_in_t_source_btn'),
                    ),
                    onChanged: (value) {},
                    items: _cities.map((City city) {
                      return new DropdownMenuItem<int>(
                        value: city.id,
                        child: Container(
                          // alignment: Alignment
                          //     .centerRight,
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Text(
                            city.enName,
                            // textAlign:
                            // TextAlign
                            //     .right,
                          ),
                        ),
                      );
                    }).toList(),
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
                        color: Colors.black),
                    boxTextstyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0XFFbbbbbb)),
                    boxHeight: 45,
                    boxWidth: screenWidth * 0.4,
                    itemWidth: screenWidth * 0.4,
                    boxPadding: EdgeInsets.symmetric(horizontal: 8.0,),
                    hint: Text(
                      getTranslated(context, 'pyt_in_t_des_btn'),
                    ),
                    onChanged: (value) {},
                    items: _cities.map((City city) {
                      return new DropdownMenuItem<int>(
                        value: city.id,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Text(
                            city.enName,
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
    );
  }
}
