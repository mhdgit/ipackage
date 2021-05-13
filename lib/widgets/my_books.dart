import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:getwidget/getwidget.dart';
import 'package:ipackage/api/mybooks_api.dart';
import 'package:ipackage/localization/localizationValues.dart';
import 'package:ipackage/modules/LocalAssistant.dart';
import 'package:ipackage/modules/my_icons.dart';
import 'package:ipackage/widgets/home/domestic_offer_main.dart';
import 'package:ipackage/widgets/home/home.dart';
import 'package:ipackage/widgets/mybook/book_offer_main.dart';
import 'package:ipackage/widgets/plan_your_trip/plan_your_trip.dart';
import 'package:ipackage/widgets/settings.dart';
import 'package:ipackage/widgets/users/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyBooks extends StatefulWidget {
  @override
  _MyBooksState createState() => _MyBooksState();
}

class _MyBooksState extends State<MyBooks> {


  MyBooksApi books_api = new MyBooksApi();
  List my_book_list = [];
  bool _isGuest = false;
  bool is_loading = true;


  LocalAssistant localAssistant = new LocalAssistant();

  get_mybooks() async{
    final prefs = await SharedPreferences.getInstance();
    final key2 = 'api_token';
    final token = prefs.get(key2) ?? 0;
    //print("api: "+token.toString());

    books_api.get_books(token).then((value) {


      my_book_list = List.of(value['data']);

      setState(() {
        is_loading = false;
      });

    });
  }
  checkLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'is_login';
    final is_login_value = prefs.get(key) ?? 0;

    if (is_login_value == "1") {
      setState(() {
        _isGuest = false;
      });

      get_mybooks();



    } else {

      setState(() {
        _isGuest = true;
      });


    }

    print("gust: "+_isGuest.toString());
  }

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

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
          getTranslated(context, 'bottom_bar_my_reservations_btn'),
        ),
        centerTitle: true,
      ),
      body:_isGuest?
          InkWell(

        borderRadius: BorderRadius.circular(5),
        onTap: () {},
        child: Card(


          clipBehavior: Clip.antiAlias,
          margin: const EdgeInsets.only(top:10.0),
          //color: Colors.grey,
          elevation: 0,

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        child: Center(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  getTranslated(context, 'my_books_login_hint'),
                                  style: TextStyle(
                                      fontFamily: 'Cairo', fontSize: 20
                                  ),textAlign: TextAlign.center,
                                ),
                              ),


                              SizedBox(height: 30,),
                              InkWell(onTap: () {
                                Navigator.of(context).push(
                                  new MaterialPageRoute(
                                      builder: (BuildContext context) => new login()),
                                );
                              } , child: Container(
                                width: MediaQuery.of(context).size.width,
                                padding: const EdgeInsets.all(7),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white),
                                    //borderRadius: BorderRadius.only(bottomRight: Radius.circular(5),bottomLeft: Radius.circular(5)),
                                    borderRadius: BorderRadius.circular(5),
                                    color: Color(0xff07898B)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[

                                    Text(
                                      getTranslated(context, 'favorites_sign_in_btn'),
                                      style: TextStyle(
                                        fontSize: 22,
                                        color: Colors.white,
                                        fontFamily: "Cairo",
                                      ),
                                    ),
                                  ],
                                ),
                              ),)
                            ],
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
      )
          : is_loading? GFLoader(
        type:GFLoaderType.circle,
        loaderColorOne: Color(0xff07898B),
        loaderColorTwo: Color(0xff07898B),
        loaderColorThree: Color(0xff07898B),
      )

          :Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[

          Row(
            children: [
              Container(
                width: screenWidth * 0.84,
                padding: EdgeInsetsDirectional.only(
                    start: screenWidth * 0.08, top: 20.0, bottom: 10.0),
                child: Row(
                  children: [
                    Flexible(
                      child: Text(
                        getTranslated(context, 'my_reservations_title'),
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


          Expanded(child:Padding(
            padding: EdgeInsetsDirectional.only(
                 top: 8.0, bottom: 20.0),
            child: Container(
              //constraints: BoxConstraints.expand(),
              //height: screenHeight*0.6,
              child: ListView(
                scrollDirection: Axis.vertical,
                children: <Widget>[

                  for(int i=0; i < my_book_list.length;i++)
                    Container(
                    width: screenWidth,
                    padding: const EdgeInsets.all(8.0),
                    margin: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {},
                      child: InkWell(
                        borderRadius: BorderRadius.circular(4.0),
                        onTap: () {

                          //print(my_book_list[i].toString());
                          Navigator.of(context).push(new MaterialPageRoute(
                            builder: (BuildContext context) => new BookOfferMain(
                                package: my_book_list[i]['package_ar'].toString(),
                                rating: my_book_list[i]['stars'].toString(),
                              id: i,
                              ),
                          ));
                        },
                        child: Card(
                          elevation: 1.0,
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
                                child: Padding(
                                  padding: const EdgeInsets.all(0),
                                  child: ClipPath(
                                    clipper: ShapeBorderClipper(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(15)),
                                    ),
                                    child: Image.network(
                                      'https://ipackagetours.com/storage/app/' + my_book_list[i]['image'],
                                      fit: BoxFit.fill,
                                      height: screenHeight * 0.28,
                                    ),
                                  ),
                                ),
                              ),
//
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  localAssistant.MyBookTitle(context, my_book_list[i]['description_ar'], my_book_list[i]['description_en']),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff07898B),
                                  ),
                                  softWrap: true,
                                ),
                              ),

                              book_status(my_book_list[i]['status'].toString()),

                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),)
          )

        ],
      ),

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        unselectedItemColor: Color(0xff9FD0D2),
        selectedItemColor: Color(0xff07898B),
        onTap: onTabTapped, // new
        currentIndex: 2,
        type: BottomNavigationBarType.fixed, // new
        items: [
          new BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: getTranslated(
                context, 'bottom_bar_home_btn'),
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: getTranslated(
                context, 'bottom_bar_trip_plan_btn'),
          ),
          new BottomNavigationBarItem(
            icon: Icon(MyIcons.basket),
            label: getTranslated(
                context, 'bottom_bar_my_reservations_btn'),),
          new BottomNavigationBarItem(icon: Icon(Icons.settings),
            label: getTranslated(
                context, 'bottom_bar_settings_btn'),),
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

  Widget book_status(String status)
  {

    Locale currentLocale = Localizations.localeOf(context);
    String text = '';

    Color xx = Colors.green;
    if (status == "0")
      {
        if(currentLocale.languageCode == 'ar')
          {
            text = 'لم يتم الدفع';
            xx =Colors.grey;
          }else
            {
              text = 'No payment has been made';
              xx =Colors.grey;
            }

      }else if (status == "1")
    {
      if(currentLocale.languageCode == 'ar') {
        text = ' تم الحجز';
        xx = Color(0xff07898B);
      }else{
        text = 'Booked';
        xx =Color(0xff07898B);
      }


    }else if (status == "3")
    {
      if(currentLocale.languageCode == 'ar')
        {
          text = 'ملغي';
          xx =Colors.red;
        }else
          {
            text = 'Canceled';
            xx =Colors.red;
          }



    }

    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
              padding: const EdgeInsets.only(
                  top: 0.0,
                  right: 0.0,
                  left: 0.0,
                  bottom: 0.0),
              child: GFButton(
                textColor: Colors.white,
                onPressed: (){},
                text: text,
                color: xx,
                textStyle: TextStyle(fontFamily: 'Cairo',fontSize: 16),
              )
          ),
        ],
      ),
    );
  }
}
