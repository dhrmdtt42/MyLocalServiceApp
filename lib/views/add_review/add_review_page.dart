import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haarway_app/model/review/review_request.dart';
import 'package:haarway_app/providers/provider_model.dart';
import 'package:haarway_app/utils/common_data.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class AddReviewPage extends StatefulWidget {
  final String seoUrl;
  final String customerID;
  final String rating;

  AddReviewPage(
      {@required this.seoUrl,
      @required this.customerID,
      @required this.rating});

  @override
  _AddReviewPageState createState() => _AddReviewPageState();
}

class _AddReviewPageState extends State<AddReviewPage> {
  TextEditingController reviewTitleTextController = new TextEditingController();
  TextEditingController reviewDescTextController = new TextEditingController();
  TextEditingController ratingTextController = new TextEditingController();

  void addReview(BuildContext context, ReviewRequest reviewRequest) async {
    var response = await Provider.of<ProviderModel>(context, listen: false)
        .addReviewApiCall(context, reviewRequest);
    Map responseData = new Map();
    responseData = jsonDecode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 50.0,
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: Center(
                    child: Text(
                  "Add Your Review ",
                  style: GoogleFonts.poppins(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.red),
                ))),
            SizedBox(
              height: 50.0,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                controller: reviewTitleTextController,
                decoration: InputDecoration(
                    hintText: "Enter Review title",
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
            SizedBox(
              height: 50.0,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                controller: ratingTextController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText: "Enter Rating",
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
            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                controller: reviewDescTextController,
                keyboardType: TextInputType.text,
                maxLines: 10,
                decoration: InputDecoration(
                    hintText: "Enter Review Description",
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
            SizedBox(
              height: 20.0,
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
                          String rTitle;
                          String rDesc;
                          ReviewRequest reviewRequest = new ReviewRequest();

                          rTitle = reviewTitleTextController.text;
                          rDesc = reviewDescTextController.text;
                          int rating = int.parse(ratingTextController.text);

                          if (rTitle == null || rTitle == "") {
                            Toast.show(
                                "please enter the review  title", context,
                                gravity: 0, duration: Toast.LENGTH_SHORT);
                          }
                          if (rDesc == null || rDesc == "") {
                            Toast.show(
                                "please enter the review  Description", context,
                                gravity: 0, duration: Toast.LENGTH_SHORT);
                          }

                          if (rating == null || rating == "" || rating > 5) {
                            Toast.show(
                                "please enter the review  Description", context,
                                gravity: 0, duration: Toast.LENGTH_SHORT);
                          }

                          if (rTitle != null &&
                              rTitle != "" &&
                              rDesc != null &&
                              rDesc != "" &&
                              rating <= 5) {
                            reviewRequest.reviewTitle = rTitle;
                            reviewRequest.reviewDesc = rDesc;
                            reviewRequest.customerID = widget.customerID;
                            reviewRequest.seoUrl = widget.seoUrl;
                            reviewRequest.reviewRating = '$rating';
                            Provider.of<ProviderModel>(context, listen: false)
                                .addReviewApiCall(context, reviewRequest);
                            Navigator.of(context).pop();
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
                              color: new CommonData().colorFromHex("#e95d5d"),
                            )),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            )
          ],
        ),
      ),
    );
  }
}
