import 'package:dropdown_below/dropdown_below.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:ipackage/localization/localizationValues.dart';

class PaymentMethods extends StatefulWidget {
  @override
  _PaymentMethodsState createState() => _PaymentMethodsState();
}

class _PaymentMethodsState extends State<PaymentMethods> {

  int _groupRadio = 0;
  bool selected = true;

  List<String> _imageList = [
    'assets/images/visa.jpg',
    'assets/images/mastercard.png',
    'assets/images/paypal.png',
  ];

  List<String> _months = ['1','2','3','4','5','6','7','8','9','10','11','12',];
  List<String> _years = ['2021','2020','2019','2018','2017','2016','2015','2014','2013','2012','2011','2010',];

  @override
  Widget build(BuildContext context) {

    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final double screenHeight =
        MediaQuery.of(context).size.height - statusBarHeight - kToolbarHeight;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Color(0xffE9F7F8),
        elevation: 0.0,
        shadowColor: Colors.white,
        // title: Text(
        //   getTranslated(context, 'change_hotel'),
        // ),
        // centerTitle: true,
      ),

      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              for(int index = 0 ; index < _imageList.length ; index++)
                Container(
                  width: screenWidth * 0.9,
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Card(
                    elevation: 2.0,
                    child: Column(
                      children: [
                        RadioListTile(
                          onChanged: (val){

                            setState(() {
                              _groupRadio = val;
                            });
                          },
                          value: index,
                          groupValue: _groupRadio,
                          title: Image.asset(_imageList[index],
                              fit: BoxFit.contain, width: screenWidth * 0.15, height: screenHeight * 0.2,),
                        ),

                        _groupRadio == index ? GFAccordion(
                          // title: getTranslated(context, 'fo_details'),
                          collapsedTitleBackgroundColor: Colors.white,
                          expandedTitleBackgroundColor: Colors.white,
                          textStyle: TextStyle(
                            fontSize: 16,
                            color: Colors.black38,
                          ),
                          collapsedIcon: Icon(Icons.keyboard_arrow_up, color: Colors.black38,),
                          expandedIcon: Icon(Icons.keyboard_arrow_down, color: Colors.black38,),

                          contentChild: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: TextField(
                                  keyboardType: TextInputType.text,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.start,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(vertical: 4.0 , horizontal: 8.0),
                                      hintText: getTranslated(context, 'payment_methods_card_number'),
                                      hintStyle: TextStyle(
                                        fontSize: 14.0,
                                        color: Color(0xffbdc3c7),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5.0),
                                        borderSide: BorderSide(
                                          width: 2,
                                          color: Color(0xffecf0f1),
                                        ),
                                      ),
                                      fillColor: Colors.white,
                                      focusColor: Colors.black,
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5.0),
                                        borderSide: BorderSide(
                                          width: 2,
                                          color: Color(0xffecf0f1),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5.0),
                                        borderSide: BorderSide(
                                          width: 2,
                                          color: Color(0xffecf0f1),
                                        ),
                                      ),
                                      filled: true),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: TextField(
                                  keyboardType: TextInputType.text,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.start,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(vertical: 4.0 , horizontal: 8.0),
                                      hintText: getTranslated(context, 'payment_methods_card_name'),
                                      hintStyle: TextStyle(
                                        fontSize: 14.0,
                                        color: Color(0xffC3C2C3),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5.0),
                                        borderSide: BorderSide(
                                          width: 2,
                                          color: Color(0xffecf0f1),
                                        ),
                                      ),
                                      fillColor: Colors.white,
                                      focusColor: Colors.black,
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5.0),
                                        borderSide: BorderSide(
                                          width: 2,
                                          color: Color(0xffecf0f1),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5.0),
                                        borderSide: BorderSide(
                                          width: 2,
                                          color: Color(0xffecf0f1),
                                        ),
                                      ),
                                      filled: true),
                                ),
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 30,
                                    child: Padding(
                                      padding: const EdgeInsets.all(2.0),
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
                                        // boxWidth: screenWidth * 0.4,
                                        itemWidth: screenWidth * 0.15,
                                        boxPadding: EdgeInsets.symmetric(horizontal: 8.0,),
                                        hint: Text(
                                          'MM',
                                        ),
                                        onChanged: (value) {},
                                        items: _months.map((String month) {
                                          return new DropdownMenuItem<String>(
                                            value: month,
                                            child: Container(
                                              // alignment: Alignment
                                              //     .centerRight,
                                              width: MediaQuery.of(context).size.width * 0.5,
                                              child: Text(
                                                month,
                                                // textAlign:
                                                // TextAlign
                                                //     .right,
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 35,
                                    child: Padding(
                                      padding: const EdgeInsets.all(2.0),
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
                                        // boxWidth: screenWidth * 0.4,
                                        itemWidth: screenWidth * 0.25,
                                        boxPadding: EdgeInsets.symmetric(horizontal: 8.0,),
                                        hint: Text(
                                          'YYYY',
                                        ),
                                        onChanged: (value) {},
                                        items: _years.map((String year) {
                                          return new DropdownMenuItem<String>(
                                            value: year,
                                            child: Container(
                                              // alignment: Alignment
                                              //     .centerRight,
                                              width: MediaQuery.of(context).size.width * 0.5,
                                              child: Text(
                                                year,
                                                // textAlign:
                                                // TextAlign
                                                //     .right,
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: TextField(
                                  keyboardType: TextInputType.text,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.start,
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(vertical: 4.0 , horizontal: 8.0),
                                      hintText: 'CVV',
                                      hintStyle: TextStyle(
                                        fontSize: 14.0,
                                        color: Color(0xffC3C2C3),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5.0),
                                        borderSide: BorderSide(
                                          width: 2,
                                          color: Color(0xffecf0f1),
                                        ),
                                      ),
                                      fillColor: Colors.white,
                                      focusColor: Colors.black,
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5.0),
                                        borderSide: BorderSide(
                                          width: 2,
                                          color: Color(0xffecf0f1),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5.0),
                                        borderSide: BorderSide(
                                          width: 2,
                                          color: Color(0xffecf0f1),
                                        ),
                                      ),
                                      filled: true),
                                ),
                              ),

                              CheckboxListTile(value: selected,
                                onChanged: (val){
                                setState(() {
                                  selected = ! selected;
                                });
                                },
                                title: Text(getTranslated(context, 'payment_methods_card_save')),
                                activeColor: Color(0xffecf0f1),
                                checkColor: Color(0xff07898b),
                                shape: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 2,
                                    color: Color(0xffC3C2C3),
                                  ),
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 20.0),
                                child: GFButton(
                                  color: Color(0xff07898b),
                                  textColor: Colors.white,
                                  fullWidthButton: true,
                                  text: getTranslated(context, 'payment_methods_card_confirm'),
                                  size: 50.0,
                                  textStyle: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  onPressed: () {

                                  },
                                ),
                              ),

                            ],
                          ),
                        ) : Container(width: 1,height: 1,),

                      ],
                    ),
                  ),
                ),

            ],
          ),
        ),
      ),
    );
  }
}
