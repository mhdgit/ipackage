import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ipackage/localization/localizationValues.dart';
import 'package:ipackage/main.dart';
import 'package:ipackage/modules/Language.dart';
import 'package:ipackage/modules/my_icons.dart';
import 'package:ipackage/widgets/about.dart';
import 'package:ipackage/widgets/blog.dart';
import 'package:ipackage/widgets/home/home.dart';
import 'package:ipackage/widgets/my_books.dart';
import 'package:ipackage/widgets/plan_your_trip/plan_your_trip.dart';
import 'package:ipackage/widgets/users/new_membership.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  void _changeLanguage(Language lang) async {
    Locale currentLocale = Localizations.localeOf(context);

    print(lang.code);
    print(currentLocale.languageCode);

    Locale _locale = await setLocale(lang.code);
    MyApp.setLocale(context, _locale);

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        backgroundColor: Color(0xffE9F7F8),
        elevation: 0.0,
        shadowColor: Colors.white,
        title: Text(
          getTranslated(context, 'bottom_bar_settings_btn'),
        ),
        centerTitle: true,
      ),

      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10.0),
            child: Card(
              elevation: 2.0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    InkWell(
                      onTap: (){},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 20,
                              child: Icon(Icons.create_outlined, color: Color(0xff07898B),),
                            ),
                            Expanded(
                              flex: 80,
                              child: Text(
                              getTranslated(context, 'settings_username_label'),
                              style: TextStyle(fontSize: 18,),
                            ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: (){},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 20,
                              child: Icon(Icons.mail_outline, color: Color(0xff07898B),),
                            ),
                            Expanded(
                              flex: 80,
                              child: Text(
                              getTranslated(context, 'settings_email_label'),
                              style: TextStyle(fontSize: 18,),
                            ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: (){},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 20,
                              child: Icon(Icons.lock_outlined, color: Color(0xff07898B),),
                            ),
                            Expanded(
                              flex: 80,
                              child: Text(
                              getTranslated(context, 'settings_new_password'),
                              style: TextStyle(fontSize: 18,),
                            ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.of(context).push(new MaterialPageRoute(
                            builder: (BuildContext context) => new NewMembership()));
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 20,
                              child: Icon(Icons.person, color: Color(0xff07898B),),
                            ),
                            Expanded(
                              flex: 80,
                              child: Text(
                              getTranslated(context, 'create_membership'),
                              style: TextStyle(fontSize: 18,),
                            ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          flex: 20,
                          child: Icon(Icons.translate_outlined, color: Color(0xff07898B),),
                        ),
                        Expanded(
                          flex: 80,
                          child: ListTile(
                            title: Text(
                              getTranslated(context, 'settings_lang_label'),
                              style: TextStyle(fontSize: 18,),
                            ),
                            // subtitle: Text(
                            //   getTranslated(context, 'settings_lang_label'),
                            //   style: TextStyle(fontSize: 18,color: Colors.black54, fontFamily: "CustomFont",),
                            // ),
                            trailing: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                              child: DropdownButton(
                                icon: Icon(Icons.arrow_drop_down_outlined , color: Color(0xff07898B),),
                                underline: SizedBox(),
                                items: Language.languageList()
                                    .map<DropdownMenuItem<Language>>(
                                        (lang) => DropdownMenuItem(
                                      value: lang,
                                      child: Text(lang.name),
                                    ))
                                    .toList(),
                                onChanged: (Language lang) {
                                  _changeLanguage(lang);
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            child: Card(
              elevation: 2.0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    InkWell(
                      onTap: (){
                        Navigator.of(context).push(new MaterialPageRoute(
                            builder: (BuildContext context) =>
                            new AboutUs()));
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 20,
                              child: Icon(Icons.info, color: Color(0xff07898B),),
                            ),
                            Expanded(
                              flex: 80,
                              child: Text(
                              getTranslated(context, 'drawer_about_us'),
                              style: TextStyle(fontSize: 18,),
                            ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.of(context).push(new MaterialPageRoute(
                            builder: (BuildContext context) =>
                            new Blog()));
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 20,
                              child: Icon(Icons.info, color: Color(0xff07898B),),
                            ),
                            Expanded(
                              flex: 80,
                              child: Text(
                              getTranslated(context, 'settings_blog'),
                              style: TextStyle(fontSize: 18,),
                            ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: (){},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 20,
                              child: Icon(Icons.logout, color: Color(0xff07898B),),
                            ),
                            Expanded(
                              flex: 80,
                              child: Text(
                              getTranslated(context, 'drawer_logout'),
                              style: TextStyle(fontSize: 18,),
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
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        unselectedItemColor: Color(0xff9FD0D2),
        selectedItemColor: Color(0xff07898B),
        onTap: onTabTapped, // new
        currentIndex: 3,
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
