import 'dart:convert';
import 'dart:io';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:haarway_app/model/data.dart';
import 'package:haarway_app/model/location/location_services.dart';
import 'package:haarway_app/model/location/user_location.dart';
import 'package:haarway_app/providers/location_provider.dart';
import 'package:haarway_app/providers/provider_model.dart';
import 'package:haarway_app/utils/certificate_file.dart';
import 'package:haarway_app/utils/common_data.dart';
import 'package:haarway_app/views/details_page/service_details_page.dart';
import 'package:haarway_app/views/home/home_page.dart';
import 'package:haarway_app/views/login_page.dart';
import 'package:provider/provider.dart';

void main() async {
  //  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //      statusBarColor: Colors.transparent,
  //      statusBarBrightness: Brightness.light));

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
//  FirebaseApp.initializeApp();
  CommonData commonData = new CommonData();
  String currentUser = await commonData.getUser();
  Map jsonData = new Map();

  if (currentUser != null) {
    jsonData = jsonDecode(currentUser);
    Data myUserData = Data.fromJson(jsonData);
    String customerId = myUserData.customerID;
    print(customerId);
    print("\n$currentUser");
  }
  HttpOverrides.global = new MyHttpOverrides();
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider<ProviderModel>.value(value: ProviderModel()),
        ChangeNotifierProvider<LocationProvider>.value(
            value: LocationProvider()),
//        ChangeNotifierProvider<LocationService>.value(value: LocationService()),
        StreamProvider<UserLocation>.value(
            value: LocationService().locationStream)
      ],
      child: MaterialApp(
//        home:
//      HomePage()
//        SubCategory(),
//  MyRequest())));
//            currentUser != null ? HomePage() : SignInPage(),
        routes: <String, WidgetBuilder>{
          '/': (BuildContext context) =>
              currentUser != null ? HomePage() : SignInPage(),
          '/detailsPage': (BuildContext context) => ServiceDetailsPage(),
        },
      )));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: SignInPage()
//      OTPScreen(mobileNumber: "8826188798"),
        );
  }
}
