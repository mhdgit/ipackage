import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ipackage/localization/localizationValues.dart';
import 'package:ipackage/widgets/chats/user_chat.dart';
import 'package:ipackage/widgets/notifications.dart';

class Chats extends StatefulWidget {
  @override
  _ChatsState createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  List<String> _rUsers = [
    'مستخدم أول',
    'مستخدم ثاني',
  ];

  // Future _getChatsUsers() async {
  //   _users = [];
  //   final prefs = await SharedPreferences.getInstance();
  //   final key = 'is_login';
  //   final value = prefs.get(key);
  //   print('$value');
  //   if (value == '1') {
  //     final key2 = 'user_id';
  //     final value2 = prefs.get(key2);
  //     print(value2);
  //
  //     setState(() {
  //       _isUsersLoading = true;
  //     });
  //
  //     var data = {
  //       'user_id': value2.toString(),
  //     };
  //
  //     User tUser;
  //
  //     var res = await http.post(
  //         'https://iraqibayt.com/api/chats/users/get_interseted_users',
  //         body: data);
  //     var body = json.decode(res.body);
  //     print(body);
  //
  //     for (var user in body) {
  //       tUser = User.fromJson(user);
  //       _users.add(tUser);
  //     }
  //     print('users length is : ' + _users.length.toString());
  //
  //     return _users;
  //   } else {
  //     setState(() {
  //       _isAuth = false;
  //     });
  //     return _users;
  //   }
  // }
  //
  // Future getUserUnreadMessages(String uid) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final key2 = 'user_id';
  //   final value2 = prefs.get(key2);
  //
  //   var data = {
  //     'user_id': value2.toString(),
  //   };
  //
  //   try {
  //     var res = await http.post(
  //         'https://iraqibayt.com/api/chats/users/' +
  //             uid +
  //             '/get_unread_msgs_count',
  //         body: data);
  //     //print(res.body);
  //     //print('sending...');
  //     var body = json.decode(res.body);
  //     print(body);
  //
  //     return body;
  //   } catch (e) {
  //     return ' ';
  //   }
  // }
  //
  // Future getUsersBadges(List<User> users) async {
  //   _unreadMessages.length = users.length;
  //
  //   for (int i = 0; i < users.length; i++) {
  //     await getUserUnreadMessages(users[i].id.toString()).then((value) {
  //       setState(() {
  //         _unreadMessages[i] = value.toString();
  //       });
  //     });
  //   }
  // }

  @override
  void initState() {
    super.initState();
    // _unreadMessages = new List<String>();
    //
    // setState(() {
    //   _isUsersLoading = true;
    // });
    // _getChatsUsers().then((value) {
    //   setState(() {
    //     _rUsers = List.from(value);
    //     getUsersBadges(_rUsers).whenComplete(() {
    //       setState(() {
    //         _isUsersLoading = false;
    //       });
    //     });
    //   });
    // });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final double screenHeight =
        MediaQuery.of(context).size.height - statusBarHeight - kToolbarHeight;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color(0XFFc4c4c4),
      appBar: AppBar(
        backgroundColor: Color(0xff77BEC0),
        elevation: 0.0,
        shadowColor: Colors.white,
        title: Text(
          getTranslated(context, 'tourist_services_username'),
        ),
        actions: [
          IconButton(icon: Icon(Icons.mail_outline , color: Colors.black,), onPressed: (){}),
          IconButton(icon: Icon(Icons.notifications_outlined , color: Colors.black,), onPressed: (){
            Navigator.of(context).push(new MaterialPageRoute(
                builder: (BuildContext context) => new Notifications()));
          }),
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: CircleAvatar(
              radius: 30,
              backgroundImage:
              AssetImage('assets/images/profile.jpg'),
            ),
          ),
        ],
      ),
      body:  _rUsers.length == 0
          ? Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Center(
              child: Text(
                'لتبدأ محادثتك الأولى مع أحد أصحاب الإعلانات على الموقع',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Center(
              child: Text(
                'أنقر على زر "أرسل رسالة" الموجود في صفحة تفاصيل الإعلان',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
            ),
          )
        ],
      )
          :Container(
        width: screenWidth * 0.9,
            child: Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: screenHeight,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: _rUsers.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                              new MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      new UserChat()));
                        },
                        child: Card(
                          elevation: 2,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0),
                            child: ListTile(
                              leading: CircleAvatar(
                                child: Image.asset(
                                    'assets/images/profile2.jpg'),
                              ),
                              title: Text(
                                _rUsers[index].toString(),
                                style: TextStyle(
                                    fontSize: 18,
                                    ),
                              ),
                              // trailing: GFBadge(
                              //   color: _unreadMessages[index]
                              //               .toString() ==
                              //           '0'
                              //       ? Colors.white
                              //       : GFColors.DANGER,
                              //   textColor: Colors.white,
                              //   child: Text(
                              //     _unreadMessages[index].toString(),
                              //     style: TextStyle(
                              //       fontSize: 13,
                              //       fontFamily: 'CustomIcons',
                              //       // color: Colors.blueGrey,
                              //     ),
                              //   ),
                              // ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
        ),
          ),
            );
  }

}
