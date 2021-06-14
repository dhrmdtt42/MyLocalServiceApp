import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haarway_app/providers/provider_model.dart';
import 'package:haarway_app/utils/common_data.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class HelpAndSupportScreen extends StatefulWidget {
  @override
  _HelpAndSupportScreenState createState() => _HelpAndSupportScreenState();
}

class _HelpAndSupportScreenState extends State<HelpAndSupportScreen> {
  TextEditingController messageTextController = new TextEditingController();
  TextEditingController subjectTextController = new TextEditingController();
  TextEditingController emailTextController = new TextEditingController();
  TextEditingController customerNameTextController =
      new TextEditingController();
  bool isNum = true;
  bool isEmailValid = true;

  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.parse(s, (e) => null) != null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        boxShadow: [
                          BoxShadow(
                              color: const Color(0x0d000000),
                              offset: Offset(0, 0),
                              blurRadius: 20,
                              spreadRadius: 0)
                        ],
                        color: const Color(0xffffffff)),
                    child: Padding(
                      padding:
                          const EdgeInsets.fromLTRB(36.0, 40.0, 36.0, 40.0),
                      child: Form(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(height: 10.0),
                            Align(
                                alignment: Alignment.bottomCenter,
                                child: Center(
                                    child: Image.asset(
                                  "assets/haarway.png",
                                  height: 30.0,
                                  width: 150.0,
                                ))),
                            SizedBox(height: 30.0),
                            Align(
                                alignment: Alignment.bottomCenter,
                                child: Center(
                                    child: Text(
                                  " Help & Support ",
                                  style: GoogleFonts.poppins(
                                      fontSize: 24.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red),
                                ))),
                            SizedBox(
                              height: 50.0,
                            ),
                            SizedBox(height: 10.0),
                            TextFormField(
                              controller: customerNameTextController,
                              textAlign: TextAlign.left,
                              keyboardType: TextInputType.name,
                              textInputAction: TextInputAction.next,
                              onChanged: (value) {
                                setState(() {
                                  isNum = isNumeric(value);
                                });
                              },
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: const Color(0xfff6f7f9),
                                errorText: isNum == true
                                    ? "Name should contain alphabets only"
                                    : null,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 0.0, style: BorderStyle.none),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                contentPadding: EdgeInsets.only(left: 15.0),
                                hintText: ' Customer Name ',
                                focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(
                                        color: const Color(0xffa8abc1),
                                        width: 1)),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(
                                      color: const Color(0x80eb5b77),
                                      width: 1,
                                    )),
                                errorBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(
                                      color: const Color(0x80eb5b77),
                                      width: 1,
                                    )),
                              ),
                            ),
                            SizedBox(height: 20.0),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  color: const Color(0xfff6f7f9)),
                              child: TextFormField(
                                controller: emailTextController,
                                textAlignVertical: TextAlignVertical.center,
                                textInputAction: TextInputAction.done,
                                onChanged: (value) {
                                  setState(() {
                                    isEmailValid = new CommonData()
                                        .validateEmail(value, false);
                                  });
                                },
                                decoration: InputDecoration(
//                              border: InputBorder.none,
                                  filled: true,
                                  fillColor: const Color(0xfff6f7f9),
                                  contentPadding: EdgeInsets.only(left: 15.0),
                                  hintText: ' Email ',

                                  errorText: isEmailValid == false
                                      ? 'Please Enter Valid Email'
                                      : null,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 0.0, style: BorderStyle.none),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      borderSide: BorderSide(
                                          color: const Color(0xffa8abc1),
                                          width: 1)),
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                    color: const Color(0x80eb5b77),
                                    width: 1,
                                  )),
                                  errorBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      borderSide: BorderSide(
                                        color: const Color(0x80eb5b77),
                                        width: 1,
                                      )),
//                              errorText:

                                  /* suffixIcon: IconButton(
                                    icon: Icon(
                                      passwordInvisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Theme.of(context).primaryColorDark,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        passwordInvisible = !passwordInvisible;
                                      });
                                    },
                                  ),*/
                                ),
                                autovalidate: true,
                              ),
                            ),
                            SizedBox(height: 20.0),
                            TextFormField(
                              controller: subjectTextController,
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              onChanged: (value) {
                                setState(() {
//                              mobileTextController.text = value;
                                });
                              },
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: const Color(0xfff6f7f9),
//                          errorText:
//                          getPasswordError(subjectTextController.text),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 0.0, style: BorderStyle.none),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                contentPadding: EdgeInsets.only(left: 15.0),
                                hintText: ' Subject ',
                                focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(
                                        color: const Color(0xffa8abc1),
                                        width: 1)),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(
                                      color: const Color(0x80eb5b77),
                                      width: 1,
                                    )),
                                errorBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(
                                      color: const Color(0x80eb5b77),
                                      width: 1,
                                    )),
                              ),
                            ),
                            SizedBox(height: 20.0),
                            TextFormField(
                              controller: messageTextController,
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              maxLines: 5,
                              onChanged: (value) {
                                setState(() {
//                              mobileTextController.text = value;
                                });
                              },
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: const Color(0xfff6f7f9),
//                          errorText:
//                          getPasswordError(subjectTextController.text),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 0.0, style: BorderStyle.none),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                contentPadding:
                                    EdgeInsets.only(left: 15.0, top: 12),
                                hintText: ' Message... ',
                                focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(
                                        color: const Color(0xffa8abc1),
                                        width: 1)),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(
                                      color: const Color(0x80eb5b77),
                                      width: 1,
                                    )),
                                errorBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(
                                      color: const Color(0x80eb5b77),
                                      width: 1,
                                    )),
                              ),
                            ),
                            SizedBox(height: 10.0),
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
                                          String username;
                                          String emailText;
                                          String subjectText;
                                          String messageText;

//                                    if (checkbox_policy == true) {
                                          username = customerNameTextController
                                              .text
                                              .trim();
                                          emailText =
                                              emailTextController.text.trim();
                                          subjectText =
                                              subjectTextController.text.trim();
                                          messageText =
                                              messageTextController.text.trim();

                                          if (username == null ||
                                              username == "") {
                                            Toast.show("please enter the  name",
                                                context,
                                                gravity: 0,
                                                duration: Toast.LENGTH_LONG);
                                            return;
                                          }

                                          if (emailText == null ||
                                              emailText == "") {
                                            Toast.show(
                                                "please enter the correct mobile number",
                                                context,
                                                gravity: 0,
                                                duration: Toast.LENGTH_LONG);
                                            return;
                                          }

                                          if (subjectText == null ||
                                              subjectText == "") {
                                            Toast.show(
                                                "please enter the subject",
                                                context,
                                                gravity: 0,
                                                duration: Toast.LENGTH_LONG);
                                            return;
                                          }
                                          if (emailText == null ||
                                              emailText == "") {
                                            Toast.show("please enter the email",
                                                context,
                                                gravity: 0,
                                                duration: Toast.LENGTH_LONG);
                                            return;
                                          }

                                          if (username != null &&
                                              username != "" &&
                                              emailText != null &&
                                              emailText != "" &&
                                              subjectText != null &&
                                              subjectText != "" &&
                                              messageText != null &&
                                              messageText != "") {
                                            Provider.of<ProviderModel>(context,
                                                    listen: false)
                                                .helpAndSupportApiCall(
                                                    username,
                                                    emailText,
                                                    subjectText,
                                                    messageText,
                                                    context);
                                          }
//                                    }
                                        },
                                        child: Text(
                                          'Submit',
                                          style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontSize: 16.0),
                                        ),
                                        color: new CommonData()
                                            .colorFromHex("#e95d5d"),
                                        elevation: 8,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(25.0),
                                            side: BorderSide(
                                              color: new CommonData()
                                                  .colorFromHex("#e95d5d"),
                                            )),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
