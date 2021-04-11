import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ipackage/localization/localizationValues.dart';
import 'package:ipackage/widgets/notifications.dart';

class UserChat extends StatefulWidget {
  // final String userID;
  // final String userName;
  // UserChat({Key key, this.userID , this.userName}) : super(key: key);

  @override
  UserChatState createState() => UserChatState();
}

class UserChatState extends State<UserChat> {

  final TextEditingController _messageController = new TextEditingController();

  List<String> _rMessages = [
    'مرحبا أنا محمد أحمد و أريد التواصل معك',
    'مرحبا أنا محمد أحمد و أريد التواصل معك',
  ];

  List<bool> authors = [
    true,
    false,
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _otherMessageWidget(String message) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[

        Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10.0),
              margin: const EdgeInsets.all(10.0),
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.65,
              ),
              decoration: BoxDecoration(
                  color: Color(0xffFFFFFF),
                  borderRadius: BorderRadius.all(Radius.circular(12)).subtract(
                          BorderRadius.only(bottomLeft: Radius.circular(12.0)))),
              child: Column(
                crossAxisAlignment:CrossAxisAlignment.end,
                children: <Widget>[

                  Text(
                    message.toString(),
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.start,
                  ),

                ],
              ),
            ),

            FittedBox(
              fit: BoxFit.scaleDown,
              alignment: AlignmentDirectional.centerEnd,
              child: Text(
                '8:10',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.blueGrey,
                ),
              ),
            ),

          ],
        ),

        Padding(
          padding: const EdgeInsets.all(3.0),
          child: CircleAvatar(
            radius: 30,
            backgroundImage:
            AssetImage('assets/images/profile2.jpg'),
          ),
        ),

      ],
    );
  }

  _userMessageWidget(String message) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[


        Padding(
          padding: const EdgeInsets.all(3.0),
          child: CircleAvatar(
            radius: 30,
            backgroundImage:
            AssetImage('assets/images/profile.jpg'),
          ),
        ),

        Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10.0),
              margin: const EdgeInsets.all(10.0),
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.65,
              ),
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.all(Radius.circular(12)).subtract(
                          BorderRadius.only(bottomRight: Radius.circular(12.0)))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    message.toString(),
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ),

            Text(
              '8:10',
              style: TextStyle(
                fontSize: 13,
                color: Colors.blueGrey,
              ),
              textAlign: TextAlign.end,
            ),
          ],
        )
      ],
    );
  }

  _messageWidget(String content , bool isOtherOne)
  {
    return isOtherOne ? _otherMessageWidget(content) : _userMessageWidget(content);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: StatefulBuilder(
        builder: (context, setState) {
          return SafeArea(
            child: Container(
              color: Color(0xffE9F7F8),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: ListView.builder(
                        reverse: true,
                        shrinkWrap: true,
                        // itemExtent: MediaQuery.of(context).size.height * 0.08,
                        itemCount: _rMessages.length,
                        itemBuilder: (context, index) {
                          return _messageWidget(
                              _rMessages[index],
                              authors[index]);
                        }),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.08,
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(horizontal: 3.0),
                    color: Color(0xffE9F7F8),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 5,
                          child: Container(
                            color: Colors.white60,
                            // width: MediaQuery.of(context).size.width * 0.84,
                            child: TextFormField(

                              textAlign: TextAlign.right,
                              decoration: InputDecoration(
                                hintText: 'اكتب رسالتك هنا...',
                                hintStyle: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black54,
                                  fontFamily: "CustomIcons",
                                ),
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                fillColor: Colors.white,
                                border: new OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(5.0),
                                  borderSide: new BorderSide(),
                                ),
                              ),
                              controller: _messageController,
                              onChanged: null,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              color: Color(0xff77BEC0),
                            ),
                            child: IconButton(
                                icon: Icon(
                                  Icons.send,
                                  color: Colors.white,
                                ),
                                color: Color(0xff77BEC0),
                                onPressed: () {
                                }),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

