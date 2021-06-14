import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haarway_app/model/data.dart';
import 'package:haarway_app/model/my_request/request_item_model.dart';
import 'package:haarway_app/model/review/review_request.dart';
import 'package:haarway_app/providers/provider_model.dart';
import 'package:haarway_app/utils/common_data.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class RequestItemPage extends StatefulWidget {
  final String seoUrl;
//  final String customerID;
//  final String rating;
//  final VoidCallback requestItemCallBack;

  RequestItemPage({
    @required this.seoUrl,
//      @required this.customerID,
//      @required this.rating,
//      @required this.requestItemCallBack
  });

  @override
  _RequestItemPageState createState() => _RequestItemPageState();
}

class _RequestItemPageState extends State<RequestItemPage> {
  Data myUserData = new Data();
  String tc;
  bool checkbox_policy = false;
  CommonData commonData = new CommonData();
  TextEditingController reviewTitleTextController = new TextEditingController();
  TextEditingController nameTextController = new TextEditingController();
  TextEditingController numberTextController = new TextEditingController();
  TextEditingController emailTextController = new TextEditingController();
  TextEditingController messageTextController = new TextEditingController();

  void addReview(BuildContext context, ReviewRequest reviewRequest) async {
    var response = await Provider.of<ProviderModel>(context, listen: false)
        .addReviewApiCall(context, reviewRequest);
    Map responseData = new Map();
    responseData = jsonDecode(response.body);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      getUserDatafromLocal();
      setState(() {
        print(myUserData);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 50.0,
            ),
            Align(
                alignment: Alignment.bottomLeft,
                child: Center(
                    child: Text(
                  "Get contact details ",
                  style: GoogleFonts.poppins(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.red),
                ))),
            Align(
                alignment: Alignment.bottomLeft,
                child: Center(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "We'll send Business information to your mobile & email ",
                    style: GoogleFonts.poppins(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ))),
            //We'll send Business information to your mobile & email
            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                controller: nameTextController,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                    hintText: "Name*",
                    hintStyle: GoogleFonts.poppins(
                        fontSize: 14.0,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey),
                    border: const OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(color: Colors.black))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                controller: numberTextController,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                    hintText: "MobileNumber*",
                    hintStyle: GoogleFonts.poppins(
                        fontSize: 14.0,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey),
                    border: const OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(color: Colors.black))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                controller: emailTextController,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                    hintText: "Email*",
                    hintStyle: GoogleFonts.poppins(
                        fontSize: 14.0,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey),
                    border: const OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(color: Colors.black))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                controller: messageTextController,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                maxLines: 5,
                decoration: InputDecoration(
                    hintText: "Your Message",
                    hintStyle: GoogleFonts.poppins(
                        fontSize: 14.0,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey),
                    border: const OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(color: Colors.black))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 20.0,
                left: 24.0,
                right: 24.0,
              ),
              child: Center(
                child: Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 325.0,
                      height: 52.0,
                      child: RaisedButton(
                        onPressed: () {
                          String name;
                          String mobile;
                          String email;
                          ReviewRequest reviewRequest = new ReviewRequest();
                          RequestItemModel requestModel =
                              new RequestItemModel();

//                          nameTextController.text = myUserData.customer_name;
//                          numberTextController.text =
//                              myUserData.customer_mobile;
//                          emailTextController.text = myUserData.customer_email;

                          if (nameTextController.text == null ||
                              nameTextController.text == "") {
                            Toast.show("please enter the Name", context,
                                gravity: 1, duration: Toast.LENGTH_SHORT);
                            return;
                          }
                          if (numberTextController.text == null ||
                              numberTextController.text == "") {
                            Toast.show("please enter the mobile", context,
                                gravity: 1, duration: Toast.LENGTH_SHORT);
                            return;
                          }

                          if (emailTextController.text == null ||
                              emailTextController.text == "") {
                            Toast.show("please enter the email", context,
                                gravity: 1, duration: Toast.LENGTH_SHORT);
                            return;
                          }

                          if (checkbox_policy != true) {
                            Toast.show(
                                "Please Accept the T & C of company policy",
                                context,
                                gravity: 1,
                                duration: Toast.LENGTH_SHORT);
                            return;
                          }

                          if (nameTextController.text != null &&
                              nameTextController.text != "" &&
                              numberTextController.text != null &&
                              numberTextController.text != "" &&
                              emailTextController.text != null &&
                              emailTextController.text != "") {
                            print(
                                "${nameTextController.text}\n${emailTextController.text}\n${numberTextController.text}\n${widget.seoUrl}");
                            requestModel.name = nameTextController.text;
                            requestModel.seoUrl = widget.seoUrl;
                            requestModel.email = emailTextController.text;
                            requestModel.mobileNumber =
                                numberTextController.text;
                            requestModel.message = messageTextController.text;
                            requestModel.termsAndPolicy = "1";

                            Provider.of<ProviderModel>(context, listen: false)
                                .otpRequstItemApiCall(context, requestModel);
//                            Navigator.of(context).pop();
                          }
                        },
                        child: Text(
                          'Submit',
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 16.0),
                        ),
                        color: checkbox_policy == true
                            ? new CommonData().colorFromHex("#e95d5d")
                            : Colors.grey,
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            side: BorderSide(
                              color: checkbox_policy == true
                                  ? new CommonData().colorFromHex("#e95d5d")
                                  : Colors.grey,
                            )),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: <Widget>[
                  Checkbox(
                      value: checkbox_policy,
                      checkColor: Colors.redAccent, // color of tick Mark
                      activeColor: Colors.white70,
                      onChanged: (bool value) {
                        setState(() {
                          checkbox_policy = value;
                          if (value == true) {
                            setState(() {
                              tc = "1";
                            });
//                            checkboxFemale = false;
//                            checkboxOthers = false;
                          }
                        });
                      }),
                  Expanded(
                    child: Text(
                      "I agree to the terms and conditions and privacy policy",
                      style: GoogleFonts.poppins(
                          color: Colors.grey,
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 80.0,
            )
          ],
        ),
      ),
    );
  }

  getUserDatafromLocal() async {
    Future<String> userData = commonData.getUser();
    String myUserString = await userData;
    Map jsonData = new Map();
    jsonData = jsonDecode(myUserString);
    setState(() {
      myUserData = Data.fromJson(jsonData);
      nameTextController.text = myUserData.customer_name;
      numberTextController.text = myUserData.customer_mobile;
      emailTextController.text = myUserData.customer_email;
      print(myUserData);
    });
  }
}
