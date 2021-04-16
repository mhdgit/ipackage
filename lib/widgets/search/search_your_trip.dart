import 'package:flutter/material.dart';
import 'package:ipackage/localization/localizationValues.dart';
import 'package:ipackage/modules/my_icons.dart';
import 'package:ipackage/widgets/home/home.dart';
import 'package:ipackage/widgets/my_books.dart';
import 'package:ipackage/widgets/plan_your_trip/plan_your_trip.dart';
import 'package:ipackage/widgets/search/countries.dart';
import 'package:ipackage/widgets/search/packages.dart';
import 'package:ipackage/widgets/settings.dart';
import 'package:ipackage/widgets/search/foreign_tour.dart';

class SearchYourTrip extends StatefulWidget {
  final int initialTabIndex;

  SearchYourTrip({this.initialTabIndex});

  @override
  _SearchYourTripState createState() => _SearchYourTripState();
}

class _SearchYourTripState extends State<SearchYourTrip> {
  @override
  Widget build(BuildContext context) {

    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final double screenHeight =
        MediaQuery.of(context).size.height - statusBarHeight - kToolbarHeight;
    final double screenWidth = MediaQuery.of(context).size.width;

    return DefaultTabController(
      initialIndex: widget.initialTabIndex,
      length: 3,
      child: Scaffold(
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
          bottom: TabBar(
            indicatorColor: Color(0xff07898B),
            labelColor: Color(0xff07898B),
            unselectedLabelColor: Colors.black,
            indicatorWeight: 4,

            labelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            tabs: [
              Tab(
                text: getTranslated(context, 'pyt_in_t_search_btn'),
              ),
              Tab(
                text: getTranslated(context, 'home_b_bar_countries'),
              ),
              Tab(
                text: getTranslated(context, 'pyt_programs'),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            ForeignTour(),
            Countries(),
            Packages(),
            // DomesticTour(),
            // IPackageAmbassadors(),
          ],
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
