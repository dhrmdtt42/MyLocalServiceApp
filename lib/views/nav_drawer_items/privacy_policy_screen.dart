import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haarway_app/model/drawer_items/get_page_model.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  final GetPageModel privacyPolicy;
  PrivacyPolicyScreen({@required this.privacyPolicy});

  @override
  _PrivacyPolicyScreenState createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  String pageContent;
  String page_heading;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    pageContent = widget.privacyPolicy.data.pageContent;
    page_heading = widget.privacyPolicy.data.pageHeading;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${page_heading ?? ""}",
          style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.redAccent),
        ),
        backgroundColor: Colors.white,
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
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  "${pageContent ?? "Content Not Available"}",
                  style: GoogleFonts.poppins(
                      fontSize: 15, fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
