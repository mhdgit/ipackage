
import 'package:flutter/material.dart';
import 'package:ipackage/localization/localizationValues.dart';
import 'package:ipackage/main.dart';
import 'package:ipackage/modules/Language.dart';
import 'package:ipackage/modules/my_icons.dart';
import 'package:ipackage/widgets/home/home.dart';
import 'package:ipackage/widgets/search/search_your_trip.dart';

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
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 80.0),
            child: ListTile(
              title: Text(
                getTranslated(context, 'settings_lang_label'),
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: "CustomFont",),
              ),
              // subtitle: Text(
              //   getTranslated(context, 'settings_lang_label'),
              //   style: TextStyle(fontSize: 18,color: Colors.black54, fontFamily: "CustomFont",),
              // ),
              trailing: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: DropdownButton(
                  icon: Icon(Icons.language , color: Color(0xff07898B),),
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
            builder: (BuildContext context) => new SearchYourTrip()),
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
