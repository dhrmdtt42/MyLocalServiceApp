import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haarway_app/providers/provider_model.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:haarway_app/global_variables.dart' as global;

class RegisterVerifyOTP extends StatefulWidget {
  final String mobileNumber;
  RegisterVerifyOTP({@required this.mobileNumber});
  @override
  _RegisterVerifyOTPState createState() => _RegisterVerifyOTPState();
}

class _RegisterVerifyOTPState extends State<RegisterVerifyOTP> {
  TextEditingController otpTextController = new TextEditingController();
  String phoneNumber;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    phoneNumber = widget.mobileNumber.replaceRange(2, 8, "*******");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "OTP",
          style: GoogleFonts.poppins(
              fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
//                .push(context, MaterialPageRoute(builder: (BuildContext context)=> OTPScreen()));
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
            SizedBox(
              height: 50.0,
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: Center(
                    child: Text(
                  "Verify Number ",
                  style: GoogleFonts.poppins(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ))),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Please enter OTP sent to your mobile number $phoneNumber",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 12.0,
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 200.0,
                    child: TextField(
                      controller: otpTextController,
                      maxLength: 5,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration.collapsed(
                          hintText: "_ _ _ _ _",
                          hintStyle: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          )),
                      autofocus: false,
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          fontSize: 32.0,
                          letterSpacing: 5),
                      onChanged: (value) {
                        if (value.length == 5) {
                          String otpTextValue = value;
                          Provider.of<ProviderModel>(context, listen: false)
                              .registerOtpVerify(
                                  otpTextValue, global.reg_otp_id, context);
                        }
                      },
                    ),
                  ),
                )),
            SizedBox(
              height: 100.0,
            ),
            Container(
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
            SizedBox(
              height: 50.0,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Give a missed call at",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    color: Colors.red),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.call,
                    color: Colors.red,
                    size: 32.0,
                  ),
                ),
                Text(
                  "1800-120-457-896 ",
                  style: GoogleFonts.poppins(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                )
              ],
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
                      width: 250.0,
                      height: 52.0,
                      child: RaisedButton(
                        onPressed: () {
                          Toast.show("I'm not functioning yet", context,
                              gravity: 1, duration: Toast.LENGTH_LONG);
//                          Navigator.push(
//                              context,
//                              MaterialPageRoute(
//                                  builder: (BuildContext context) =>
//                                      OTPScreen()));
                        },
                        child: Text(
                          ' Click after miss call ',
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                              fontSize: 16.0),
                        ),
                        color: Colors.white,
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            side: BorderSide(color: Colors.red)),
                      ),
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
}
