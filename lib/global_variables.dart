// TODO Implement this library.
import 'package:haarway_app/model/filters/amenities_request.dart';
import 'package:haarway_app/views/filter_dialog/filter_request_data/loc_request.dart';

String sortByTitle;
String cityText;
String seo_url;
String otp_id;
String reg_otp_id;
String requestItem_otp_id;
int sortByCount;
int amenitiesCount;
int catCount;
int locCount;
int radCount;
List<LocalityRequest> locality = new List<LocalityRequest>();
List<int> locIndex = new List<int>();
List<AmenitiesRequest> amenReq = new List<AmenitiesRequest>();
String selectedCity;
String radius;
String amenities;
String local;
bool isLoggedIn = false;
String imageFileName;
