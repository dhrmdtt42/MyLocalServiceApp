import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haarway_app/providers/provider_model.dart';
import 'package:haarway_app/utils/common_data.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController mobileTextController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController customerNameTextController =
      new TextEditingController();
  String tc;
  bool isNum = true;
  bool checkbox_policy = false;
  bool passwordInvisible = false;
  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.parse(s, (e) => null) != null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
//        title: Text(
//          "Sign Up",
//          style: GoogleFonts.poppins(
//              fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black),
//        ),
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
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
                  padding: const EdgeInsets.fromLTRB(36.0, 40.0, 36.0, 40.0),
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
                              " Create Account ",
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
                              if (value != " ") isNum = isNumeric(value);
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
                            hintText: 'Customer Name',
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
                        SizedBox(height: 20.0),
                        TextFormField(
                          controller: mobileTextController,
                          textAlign: TextAlign.left,
//                      maxLength: 10,
                          textInputAction: TextInputAction.next,
                          onChanged: (value) {
                            setState(() {
                              if (value != " ")
                                isNum = isNumeric(value);
                              else
                                value = "";
                            });
                          },
//                      onFieldSubmitted: (value) {
//
//                      },
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xfff6f7f9),
                            errorText: new CommonData().validateEmail(
                                        mobileTextController.text.trim(),
                                        isNum) ==
                                    false
                                ? getErrorMessage(
                                    isNum, mobileTextController.text.trim())
                                : null,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 0.0, style: BorderStyle.none),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            contentPadding: EdgeInsets.only(left: 15.0),
                            hintText: 'Moblie No/Email',
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
                        /*TextFormField(
                          controller: mobileTextController,
                          keyboardType: TextInputType.number,
                          maxLength: 10,
                          textInputAction: TextInputAction.next,
                          onChanged: (value) {
                            setState(() {
//                              mobileTextController.text = value;
                            });
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xfff6f7f9),
                            errorText:
                                getPasswordError(mobileTextController.text),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 0.0, style: BorderStyle.none),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            contentPadding: EdgeInsets.only(left: 15.0),
                            hintText: 'Mobile Number',
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
                        ),*/
                        SizedBox(height: 20.0),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: const Color(0xfff6f7f9)),
                          child: TextFormField(
                            controller: passwordController,
                            obscureText: passwordInvisible,
                            textAlignVertical: TextAlignVertical.center,
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
//                              border: InputBorder.none,
                              filled: true,
                              fillColor: const Color(0xfff6f7f9),
                              contentPadding: EdgeInsets.only(left: 15.0),
                              hintText: '**********',
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
//                              errorText:

                              suffixIcon: IconButton(
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
                              ),
                            ),
                            autovalidate: true,
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: <Widget>[
                              Checkbox(
                                  value: checkbox_policy,
                                  checkColor:
                                      Colors.white, // color of tick Mark
                                  activeColor: Colors.redAccent,
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
                                      String cust_name;
                                      String pass;

                                      if (checkbox_policy == true) {
                                        username =
                                            mobileTextController.text.trim();
                                        cust_name = customerNameTextController
                                            .text
                                            .trim();
                                        pass = passwordController.text.trim();

                                        if (cust_name == null ||
                                            cust_name == "") {
                                          Toast.show(
                                              "please enter the customer name",
                                              context,
                                              gravity: 1,
                                              duration: Toast.LENGTH_LONG);
                                          return;
                                        }

                                        if (username == null ||
                                            username == "") {
                                          Toast.show(
                                              "please enter the correct mobile number",
                                              context,
                                              gravity: 1,
                                              duration: Toast.LENGTH_LONG);
                                          return;
                                        }

                                        if (pass == null || pass == "") {
                                          Toast.show(
                                              "please enter the password",
                                              context,
                                              gravity: 1,
                                              duration: Toast.LENGTH_LONG);
                                          return;
                                        }
                                        if (tc == null || tc == "") {
                                          Toast.show(
                                              "please agree company policy",
                                              context,
                                              gravity: 1,
                                              duration: Toast.LENGTH_LONG);
                                          return;
                                        }

                                        if (cust_name != null &&
                                            cust_name != "" &&
                                            username != null &&
                                            username != "" &&
                                            pass != null &&
                                            pass != "" &&
                                            tc != null &&
                                            tc != "") {
                                          Provider.of<ProviderModel>(context,
                                                  listen: false)
                                              .registerRequest(
                                                  cust_name,
                                                  username,
                                                  pass,
                                                  tc,
                                                  isNum,
                                                  context);
                                        }
                                      }
                                    },
                                    child: Text(
                                      'Sign Up',
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 16.0),
                                    ),
                                    color: checkbox_policy == true
                                        ? new CommonData()
                                            .colorFromHex("#e95d5d")
                                        : Colors.grey,
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
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            margin: const EdgeInsets.all(25.0),
                            padding: const EdgeInsets.all(3.0),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                shape: BoxShape.circle),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "OR",
                                style: GoogleFonts.poppins(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(25.0),
                          child: Text(
                            'Sign Up with Social Media',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 16.0),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                height: 52.0,
                                width: 52.0,
                                child: InkWell(
                                    onTap: () {
//                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => SocialLoginPage()));
                                    },
                                    child: Image.asset(
                                      "assets/google_login.png",
                                    )),
                              ),
                              SizedBox(
                                width: 50.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 10.0, bottom: 18.0, right: 10.0),
                                child: Container(
                                    height: 42.0,
                                    width: 42.0,
                                    child: InkWell(
                                        onTap: () {
//                              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => SocialLoginPage()));
                                        },
                                        child:
                                            Image.asset("assets/fb_logo.png"))),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getPasswordError(String mobileNumber) {
    if (mobileNumber.isEmpty) {
      return "";
    } else if (mobileNumber.length < 10) {
      return 'please enter the valid Mobile Number';
    } else if (mobileNumber.length > 10) {
      return 'please enter the valid Mobile Number';
    } else
      return '';
  }

  String getErrorMessage(bool isNum, String mobile) {
    if (isNum == true && mobile.length != 10) {
      return "Please Enter valid Mobile Number";
    } else if (isNum == false)
      return "Please enter the valid email";
    else
      return "";
  }
}
