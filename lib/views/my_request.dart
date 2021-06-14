import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haarway_app/utils/common_data.dart';

class MyRequest extends StatefulWidget {
  @override
  _MyRequestState createState() => _MyRequestState();
}

class _MyRequestState extends State<MyRequest> {
  List<String> events_partyList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    events_partyList = <String>[
      "assets/events_party.png",
      "assets/events_party.png",
      "assets/events_party.png",
      "assets/events_party.png",
    ];
  }

  int _selectedIndex = 0;
  CommonData commonData = new CommonData();
  static final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>();

  void _openEndDrawer() {
    _scaffoldKey.currentState.openEndDrawer();
  }

  Color colorFromHex(String hexColor) {
    final hexCode = hexColor.replaceAll('#', '');
    return Color(int.parse('FF$hexCode', radix: 16));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title: Align(
            alignment: Alignment.topLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                    child: Image.asset(
                  'assets/haarway.png',
                  width: 140,
                  height: 80.0,
                )),
              ],
            ),
          ),
          bottomOpacity: 5.0,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      height: 50.0,
                      decoration: BoxDecoration(color: Colors.black12),
                      child: Center(
                        child: Text(
                          "My Needs",
                          style: GoogleFonts.poppins(
                              fontSize: 14.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Container(
                decoration: BoxDecoration(),
                width: MediaQuery.of(context).size.width * 0.95,
                height: MediaQuery.of(context).size.height * 0.95,
                child: ListView.builder(
                    itemCount: events_partyList.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) {
                      String imageUrl = events_partyList[index];
                      return WidgetEventsAndParty(context, index, imageUrl);
                    }),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          showUnselectedLabels: true,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Image.asset(
                "assets/home_icon.png",
                fit: BoxFit.fitWidth,
                height: 30.0,
                width: 30.0,
              ),
//            ImageIcon(
//              AssetImage("assets/home_icon.png"),
////                color: colorFromHex("#e95d5d")
//            ),
              title: Text(
                'Home',
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 12.0,
                    fontWeight: FontWeight.normal),
              ),
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage("assets/my_request.png"),
//                size: 40.0,
                  color: colorFromHex("#e95d5d")
//                colorFromHex('#e95d5d')
                  ),
              title: Text(
                'Request',
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 12.0,
                    fontWeight: FontWeight.normal),
              ),
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage("assets/pay_icon.png"),
                  size: 30.0, color: colorFromHex("#e95d5d")
//                colorFromHex('#e95d5d')
                  ),
              title: Text(
                'Pay',
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 12.0,
                    fontWeight: FontWeight.normal),
              ),
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage("assets/explore_icon.png"),
                  size: 30.0, color: colorFromHex("#e95d5d")
//                colorFromHex('#e95d5d')
                  ),
              title: Text(
                'Explore',
                style: GoogleFonts.poppins(
                    fontSize: 12.0,
                    color: Colors.black,
                    fontWeight: FontWeight.normal),
              ),
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage("assets/more_icon.png"),
                color: colorFromHex("#e95d5d"),
                size: 30,
//                colorFromHex('#e95d5d')
              ),
              title: Text(
                'More',
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 12.0,
                    fontWeight: FontWeight.normal),
              ),
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.black,
          onTap: (_selectedIndex) {
//          _onItemTapped(_selectedIndex);
            _openEndDrawer();
          },
        ),
        endDrawer: Container(
          width: MediaQuery.of(context).size.width * 0.90,
          height: MediaQuery.of(context).size.height * 1.0,
          color: colorFromHex("#e95d5d"),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 60.0),
                  child: ListTile(
                    leading: Image.asset(
                      "assets/profile_icon.png",
                      height: 52.0,
                      width: 52.0,
                    ),
                    title: Text(
                      "Dharam Dutt Mishra",
                      style: GoogleFonts.poppins(
//                        fontSize: 10.0,
                          color: Colors.white,
                          fontWeight: FontWeight.normal),
                    ),
                    subtitle: Text(
                      "9002618898",
                      style: GoogleFonts.poppins(
//                        fontSize: 10.0,
                          color: Colors.white,
                          fontWeight: FontWeight.normal),
                    ),
//                    trailing: RaisedButton.icon(
//                        color: colorFromHex("#e95d5d"),
//                        onPressed: () {},
//                        icon: Icon(
//                          Icons.power_settings_new,
//                          color: Colors.white,
//                        ),
//                        label: Text(
//                          "Logout",
//                          style: GoogleFonts.poppins(
//                              fontSize: 10.0,
//                              color: Colors.white,
//                              fontWeight: FontWeight.bold),
//                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: Container(
//                  width: MediaQuery.of(context).size.width * 0.90,
                    height: MediaQuery.of(context).size.height * 0.782,
//              color: Colors.white,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(65),
                            topLeft: Radius.circular(65))),
                    child: ListView(
                      children: <Widget>[
                        ListTile(
                          leading: Image.asset(
                            "assets/bssn_owner.png",
                            height: 20.0,
                            width: 20.0,
                          ),
                          title: Text(
                            "Are you a business owner?",
                            style: GoogleFonts.poppins(
                                fontSize: 10.0, fontWeight: FontWeight.bold),
                          ),
                          trailing: Container(
                            width: 150.0,
                            child: RaisedButton(
                              color: colorFromHex("#e95d5d"),
                              onPressed: () {},
                              child: Text(
                                "List your Business/AD",
                                style: GoogleFonts.poppins(
                                    fontSize: 9.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        ListTile(
                          leading: Image.asset(
                            "assets/advertise.png",
                            height: 20.0,
                            width: 20.0,
                          ),
                          title: Text("Advertise"),
                        ),
                        ListTile(
                          leading: Image.asset(
                            "assets/settings.png",
                            height: 20.0,
                            width: 20.0,
                          ),
                          title: Text("Settings"),
                        ),
                        ListTile(
                          leading: Image.asset(
                            "assets/account.png",
                            height: 20.0,
                            width: 20.0,
                          ),
                          title: Text("Account Info"),
                        ),
                        ListTile(
                          leading: Image.asset(
                            "assets/location.png",
                            height: 20.0,
                            width: 20.0,
                          ),
                          title: Text("Location"),
                        ),
                        ListTile(
                          leading: Image.asset(
                            "assets/privacy.png",
                            height: 20.0,
                            width: 20.0,
                          ),
                          title: Text("Privacy"),
                        ),
                        ListTile(
                          leading: Image.asset(
                            "assets/help_support.png",
                            height: 20.0,
                            width: 20.0,
                          ),
                          title: Text("Help & Support"),
                        ),
                        ListTile(
                          leading: Image.asset(
                            "assets/language.png",
                            height: 20.0,
                            width: 20.0,
                          ),
                          title: Text("Language"),
                        ),
                        ListTile(
                          leading: Image.asset(
                            "assets/rating.png",
                            height: 20.0,
                            width: 20.0,
                          ),
                          title: Text("Rate Us"),
                        ),
                        ListTile(
                          leading: Image.asset(
                            "assets/about.png",
                            height: 20.0,
                            width: 20.0,
                          ),
                          title: Text("About Us"),
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.power_settings_new,
                            size: 20,
                            color: Colors.black,
                          ),

//                          Image.asset(
//                            "assets/about.png",
//                            height: 20.0,
//                            width: 20.0,
//                          ),
                          title: Text("Logout"),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Widget WidgetEventsAndParty(
      BuildContext context, int index, String imageUrl) {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                  height: 100.0, width: 100.0, child: Image.asset(imageUrl)),
              SizedBox(width: 20.0),
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      "Plumber Services",
                      style: GoogleFonts.poppins(
                          fontSize: 16.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Checkbox(
                                value: true,
                                onChanged: (val) {},
//                                checkColor: Colors.black,
//                                activeColor: Colors.redAccent,
                              ),
                              Text("You Hired an Expert ",
                                  style: GoogleFonts.poppins(
                                      fontSize: 12.0,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.normal)),
                            ],
                          ),
                          Text("Requested on 9th Jan, 2020 ",
                              style: GoogleFonts.poppins(
                                  fontSize: 12.0,
                                  color: Colors.grey,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.normal)),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
          Divider(
            thickness: 2,
            color: Colors.grey,
          )
        ],
      ),
    );
  }
}
