import 'package:custom_dropdown/column_builder.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haarway_app/providers/provider_model.dart';
import 'package:haarway_app/utils/common_data.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  TextEditingController emailTextController = new TextEditingController();
  TextEditingController passTextController = new TextEditingController();
  bool isValid = true;
  bool passwordInvisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 100.0),
            Container(
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
              child: Form(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        "Forgot Password",
                        style: GoogleFonts.poppins(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xffa8abc1)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextFormField(
                        controller: emailTextController,
                        textAlign: TextAlign.left,
//                      maxLength: 10,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (value) {
                          setState(() {
                            isValid = CommonData().validateEmail(value, false);
                          });
                        },
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xfff6f7f9),
                          errorText: new CommonData().validateEmail(
                                      emailTextController.text, false) ==
                                  false
                              ? "Please enter the valid email"
                              : null,
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 0.0, style: BorderStyle.none),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          contentPadding: EdgeInsets.only(left: 15.0),
                          hintText: 'abc@mail.com',
                          labelText: 'email',
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                  color: const Color(0xffa8abc1), width: 1)),
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
                    ),
                    SizedBox(height: 20.0),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 20.0, left: 24.0, right: 24.0, bottom: 24.0),
                      child: Center(
                        child: Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: 325.0,
                              height: 52.0,
                              child: RaisedButton(
                                onPressed: () async {
                                  String username;
                                  String pass;
                                  if (isValid == true) {
                                    username = emailTextController.text;

                                    if (username == null || username == "") {
                                      Toast.show(
                                          "please enter the email ", context,
                                          gravity: 0,
                                          duration: Toast.LENGTH_LONG);
                                    }

                                    if (username != null && username != "") {
                                      Provider.of<ProviderModel>(context,
                                              listen: false)
                                          .forgotPasswordRequest(
                                              username, context);
                                    }
                                  }
                                },
                                child: Text(
                                  'Submit',
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 16.0),
                                ),
                                color: new CommonData().colorFromHex("#e95d5d"),
                                elevation: 8,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25.0),
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
          ],
        ),
      ),
    );
  }
}
