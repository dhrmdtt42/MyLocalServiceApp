import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:haarway_app/model/base_response.dart';
import 'package:haarway_app/model/data.dart';
import 'package:haarway_app/model/drawer_items/get_page_model.dart';
import 'package:haarway_app/model/filters/amenities_request.dart';
import 'package:haarway_app/model/home/city_search/city_base_response.dart';
import 'package:haarway_app/model/home/city_search/city_data_model.dart';
import 'package:haarway_app/model/home/education_jobs/education_job_data_model.dart';
import 'package:haarway_app/model/home/education_jobs/education_jobs_base_response.dart';
import 'package:haarway_app/model/home/events_party/event_party_base_response.dart';
import 'package:haarway_app/model/home/events_party/event_party_data_model.dart';
import 'package:haarway_app/model/home/health_care/health_care_base_response.dart';
import 'package:haarway_app/model/home/health_care/health_care_data_model.dart';
import 'package:haarway_app/model/home/home_improvement/home_improvement_base_response.dart';
import 'package:haarway_app/model/home/home_improvement/home_improvement_data_model.dart';
import 'package:haarway_app/model/home/home_offices/home_office_base_response.dart';
import 'package:haarway_app/model/home/home_offices/home_office_data_model.dart';
import 'package:haarway_app/model/home/main_categories.dart';
import 'package:haarway_app/model/home/popular_services_category.dart';
import 'package:haarway_app/model/home/service_search/service_search_base_response.dart';
import 'package:haarway_app/model/home/service_search/api_parameter_data.dart';
import 'package:haarway_app/model/home/service_search/single_service_base_response.dart';
import 'package:haarway_app/model/home/trending_services/trending_services_base_response.dart';
import 'package:haarway_app/model/home/trending_services/trending_servies_data_model.dart';
import 'package:haarway_app/model/login_data.dart';
import 'package:haarway_app/model/my_request/request_item_model.dart';
import 'package:haarway_app/model/responses/main_category_response.dart';
import 'package:haarway_app/model/responses/popular_service_category_base_response.dart';
import 'package:haarway_app/model/review/review_request.dart';
import 'package:haarway_app/model/service_search/ServiceCatSearchWithNoFilterBaseResponse.dart';
import 'package:haarway_app/model/service_search/service_search_base_response.dart';
import 'package:haarway_app/model/sub_categories/subcat__request_data_model.dart';
import 'package:haarway_app/model/sub_categories/subchild_cat_request_data_model.dart';
import 'package:haarway_app/model/verify_otp_model.dart';
import 'package:haarway_app/utils/constant.dart';
import 'package:haarway_app/utils/common_data.dart';
import 'package:haarway_app/views/auto_fill_page.dart';
import 'package:haarway_app/views/details_page/request_item_page.dart';
import 'package:haarway_app/views/details_page/service_details_page.dart';
import 'package:haarway_app/views/edit_profile/social_data_model.dart';
import 'package:haarway_app/views/filter_dialog/filter_request_data/amen_request.dart';
import 'package:haarway_app/views/filter_dialog/filter_request_data/attribute_request.dart';
import 'package:haarway_app/views/filter_dialog/filter_request_data/bathroom_type_request.dart';
import 'package:haarway_app/views/filter_dialog/filter_request_data/bedroom_type_request.dart';
import 'package:haarway_app/views/filter_dialog/filter_request_data/cat_reqst.dart';
import 'package:haarway_app/views/filter_dialog/filter_request_data/furnish_type_request.dart';
import 'package:haarway_app/views/filter_dialog/filter_request_data/loc_request.dart';
import 'package:haarway_app/views/filter_dialog/filter_request_data/price_range_request.dart';
import 'package:haarway_app/views/filter_dialog/filter_request_data/property_type_request.dart';
import 'package:haarway_app/views/filter_dialog/filter_request_data/services_request.dart';
import 'package:haarway_app/views/home/home_page.dart';
import 'package:haarway_app/views/home/home_screen.dart';
import 'package:haarway_app/views/login_page.dart';
import 'package:haarway_app/views/nav_drawer_items/privacy_policy_screen.dart';
import 'package:haarway_app/views/otp_screen/otp_page.dart';
import 'package:haarway_app/views/otp_screen/otp_write_comment.dart';
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

//import 'package:haarway_app/views/otp_page.dart';
//import 'package:haarway_app/views/otp_screen.dart';
import 'package:haarway_app/views/sign_up_otp_verify.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:haarway_app/global_variables.dart' as global;

class ProviderModel extends ChangeNotifier {
  BaseResponse baseResponse = new BaseResponse();
  List<MainCategoryData> mainCategoryList = new List<MainCategoryData>();
  MainCategoryResponse mainCategoryResponse;
  ServiceCatSearchBaseResponse catServiceSearchBaseResponse =
      new ServiceCatSearchBaseResponse();
  SeriviceCatSearchWithNoFilterBaseResponse
      serviceCatSearchWithNoFilterBaseResponse =
      new SeriviceCatSearchWithNoFilterBaseResponse();
  List<PopularCategories> popluarCAtegoryList = new List<PopularCategories>();
  PopularServiceCategoryResponse popularServiceCategoryResponse;
  List<EventsPartyData> eventPartyDataList = new List<EventsPartyData>();
  EventsPartyBaseResponse eventsPartyBaseResponse;
  List<HomeImprovementData> homeImprovement = new List<HomeImprovementData>();
  HomeImprovementBaseResponse homeImprovementBaseResponse;
  List<EducationJobsData> educationJobsDataList = new List<EducationJobsData>();
  EducationJobsBaseResponse educationJobsBaseResponse;
  List<TrendingServicesData> trendingServicesDataList =
      new List<TrendingServicesData>();
  TrendingServicesBaseResponse trendingServicesBaseResponse;
  List<HomeOfficeDataModel> homeOfficeDataList =
      new List<HomeOfficeDataModel>();
  HomeOfficeBaseResponse homeOfficeBaseResponse;
  List<HealthCareDataModel> HealthCareDataList =
      new List<HealthCareDataModel>();
  HealthCareBaseResponse healthCareBaseResponse;

  List<CityDataModel> cityList = new List<CityDataModel>();
  CityBaseResponse cityBaseResponse;
  SingleServiceSearchBaseResponse serviceSearchBaseResponse;
  Map serviceResultData = new Map();

  ///     ===============o================= login with email and password api completed   ===============o=================

  Future<BaseResponse> postRequest(LoginData loginData, String username,
      String pass, BuildContext context) async {
    HttpClient client = new HttpClient();
    client.badCertificateCallback =
        ((X509Certificate cert, String host, int port) => true);

    var url = 'https://www.haarway.com/api/customer/login';
    //    Map data = {
    //      "username": "$username",
    //      "customer_Password": "$pass"};
    //    ajay.indom@gmail.com
    //encode Map to JSON

    var body = jsonEncode(loginData.toJson());
    print(body);
    var response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "ee4454DSFDSDSF556566"
        },
        body: body);
    print("${response.statusCode}");
    Map jsonResponse = new Map();
//    jsonResponse = jsonDecode(response.body);
//    baseResponse = BaseResponse.fromJson(jsonResponse);
//    Data userData = baseResponse.data;
    Map responseData = new Map();
    responseData = jsonDecode(response.body);
    String status = responseData['status'];
    if (status == 'success') {
      CommonData commonData = new CommonData();
      String mUserData = jsonEncode(responseData['data']);
      commonData.saveLoginUser(mUserData);
      notifyListeners();
      Toast.show("Success", context, gravity: 1, duration: Toast.LENGTH_LONG);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (BuildContext context) => HomePage()),
          (route) => false);
    }
    if (status == 'error') {
      String errormsg;
      List<dynamic> messges = responseData['message'];
      if (messges[0]['username_error'] != null)
        errormsg = messges[0]['username_error'];
      if (messges[0]['customer_Password_error'] != null)
        errormsg = messges[0]['customer_Password_error'];
      CommonData().showAlert(context, errormsg);

//      print("${messges[0]['customer_Password_error']}");
//      Toast.show("$errormsg", context, gravity: 1, duration: Toast.LENGTH_LONG);
    }
    print("${response.body}");
    return baseResponse;
  }

  /// =======================================forgot password api Call below here =================0===============
  Future<BaseResponse> forgotPasswordRequest(
      String username, BuildContext context) async {
    var url = 'https://www.haarway.com/api/customer/forgot_password';
    Map data = {"customer_email": "$username"};

    //encode Map to JSON

    var body = jsonEncode(data);
    print(body);
    var response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "ee4454DSFDSDSF556566"
        },
        body: body);
    print("${response.statusCode}");

    Map responseData = new Map();
    responseData = jsonDecode(response.body);
    String status = responseData['status'];
    if (status == 'success') {
      notifyListeners();
      Toast.show("Your Password sent to your email", context,
          gravity: 1, duration: Toast.LENGTH_LONG);
      Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) => SignInPage()));
    }
    if (status == 'error') {
      String errormsg;
      List<dynamic> messges = responseData['message'];
//      if (messges[0]['username_error'] != null)
//        errormsg = messges[0]['username_error'];
      if (messges[0]['customer_email_error'] != null)
        errormsg = messges[0]['customer_email_error'];
      print("${messges[0]['customer_email_error']}");
      CommonData().showAlert(context, messges[0]['customer_email_error']);

//      Toast.show("$errormsg", context, gravity: 1, duration: Toast.LENGTH_LONG);
    }
    print("${response.body}");
    return baseResponse;
  }

  ///     ===============o================= OTP request for login api call Done ===============o=================

  Future<http.Response> otpRequst(LoginData userLogin, String mobileNumber,
      BuildContext context, bool otpFlag) async {
//    HttpClient client = new HttpClient();
//    client.badCertificateCallback =
//        ((X509Certificate cert, String host, int port) => true);

    var url = 'https://www.haarway.com/api/customer/login';
    //encode Map to JSON
    var body = json.encode(userLogin.toJson());
    print(body);

    var response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "ee4454DSFDSDSF556566"
        },
        body: body);

    print("${response.statusCode}");
    //    BaseResponse baseResponse = new BaseResponse();
    final Map jsonUser = jsonDecode(response.body);
    Map baseResp = new Map();
    baseResp = jsonDecode(response.body);
    String status = baseResp['status'];
    var mssgArr = baseResp['message'];

    if (status == 'success') {
      global.otp_id = jsonUser['otp_id'];
      global.isLoggedIn = false;
      Toast.show("Success", context, gravity: 1, duration: Toast.LENGTH_LONG);
      if (otpFlag == true)
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => Otp(
                      mobileNumber: mobileNumber,
                    )));
      else
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) => Otp()));
    }
    if (status == 'error') {
      String errormessage = mssgArr[0]['username_error'];
      CommonData().showAlert(context, mssgArr[0]['username_error']);

//      Toast.show("$errormessage", context,
//          gravity: 1, duration: Toast.LENGTH_LONG);
    }

    print("${response.body}");
    return response;
  }

  ///     ===============o================= OTP Verification for login api call Done ===============o=================

  Future<http.Response> loginOtpVerify(
      String otpText, BuildContext context, String id) async {
    var url = 'https://www.haarway.com/api/customer/verify_login_otp';
    VerifyLoginOTPModel verifyLoginOTPModel = new VerifyLoginOTPModel();
    int otp_data = int.parse(otpText);
//    verifyLoginOTPModel.otp = otp_data;
    Map data = {"otp": otpText, "otp_id": id};

    //encode Map to JSON
    var body = json.encode(data);
//    json.encode(verifyLoginOTPModel.toJSon());
    print(body);
    var response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "ee4454DSFDSDSF556566"
        },
        body: body);
    print("${response.statusCode}");
    Map responseData = new Map();
    responseData = jsonDecode(response.body);
    String saveUser = jsonEncode(responseData['data']);

    String status = responseData['status'];
    if (status == "success") {
      CommonData commonData = new CommonData();
      commonData.saveLoginUser(saveUser);
      Toast.show("OTP Verified", context,
          gravity: 1, duration: Toast.LENGTH_LONG);
//      Navigator.push(context,
//          MaterialPageRoute(builder: (BuildContext context) => HomePage()));
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (BuildContext context) => HomePage()),
          (route) => false);
    }

    if (status == "error") {
      var messges = responseData['message'];
      CommonData().showAlert(context, messges[0]['otp_error']);
//      Toast.show("${messges[0]['username_error']}", context,
//          gravity: 1, duration: Toast.LENGTH_LONG);
    }
    print("${response.body}");
    return response;
  }

  ///     ===============o================= Registration OTP Request for Registration api call Done ===============o=================

  Future<http.Response> registerRequest(String customer_name, String username,
      String pass, String tc, bool isNum, BuildContext context) async {
    var url = 'https://www.haarway.com/api/customer/register';
    Map data = {
      "customer_name": "$customer_name",
      "username": "$username",
      "customer_Password": "$pass",
      "terms_and_policy": "$tc"
    };
    //    ajay.indom@gmail.com
    //encode Map to JSON
    var body = json.encode(data);
    print(body);
    var response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "ee4454DSFDSDSF556566"
        },
        body: body);
    print("${response.statusCode}");

    Map baseResp = new Map();
    baseResp = jsonDecode(response.body);
    String status = baseResp['status'];
    var mssgArr = baseResp['message'];

    if (isNum == true) {
      if (status == 'success') {
        global.reg_otp_id = baseResp['otp_id'];
        Toast.show("$status", context, gravity: 1, duration: Toast.LENGTH_LONG);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) =>
                    RegisterVerifyOTP(mobileNumber: username)));
      }
      if (status == 'error') {
        String errormessage = mssgArr[0]['username_error'];
        CommonData().showAlert(context, errormessage);

//      Toast.show("$errormessage", context,
//          gravity: 1, duration: Toast.LENGTH_LONG);
      }
    }

    if (isNum == false) {
      if (status == 'success') {
        CommonData commonData = new CommonData();
        String mUserData = jsonEncode(baseResp['data']);
        commonData.saveLoginUser(mUserData);
        notifyListeners();
        Toast.show("Success", context, gravity: 1, duration: Toast.LENGTH_LONG);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (BuildContext context) => HomePage()),
            (route) => false);
      }
      if (status == 'error') {
        String errormsg;
        List<dynamic> messges = baseResp['message'];
        if (messges[0]['username_error'] != null)
          errormsg = messges[0]['username_error'];
        if (messges[0]['customer_Password_error'] != null)
          errormsg = messges[0]['customer_Password_error'];
        CommonData().showAlert(context, errormsg);

//      print("${messges[0]['customer_Password_error']}");
//      Toast.show("$errormsg", context, gravity: 1, duration: Toast.LENGTH_LONG);
      }
    }
    print("${response.body}");
    return response;
  }

  ///     ===============o================= OTP Verification for Registration api call Done ===============o=================

  Future<http.Response> registerOtpVerify(
      String otpText, String id, BuildContext context) async {
    var url = 'https://www.haarway.com/api/customer/verify_register_otp';
    Map data = {"otp": "$otpText", "otp_id": "$id"};

    //encode Map to JSON
    var body = json.encode(data);
    var response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "ee4454DSFDSDSF556566"
        },
        body: body);
    print("${response.statusCode}");
    Map responseData = new Map();
    responseData = jsonDecode(response.body);
    String saveUser = jsonEncode(responseData['data']);
    CommonData commonData = new CommonData();
    commonData.saveLoginUser(saveUser);
    String status = responseData['status'];
    if (status == "success") {
      Toast.show("OTP Verified", context,
          gravity: 1, duration: Toast.LENGTH_LONG);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (BuildContext context) => HomePage()),
          (route) => false);
    }
    if (status == "error") {
      var message = responseData['message'];
      String errorMessage = message[0]['otp_error'];
      CommonData().showAlert(context, errorMessage);

//      Toast.show(errorMessage, context,
//          duration: Toast.LENGTH_LONG,
//          gravity: 1,
//          backgroundColor: Colors.redAccent,
//          textColor: Colors.white);
    }
    print("${response.body}");
    return response;
  }

  ///     ===============o================= get Main Category api call Done ===============o=================

  Future<MainCategoryResponse> getMainCategoryApiCall(
      BuildContext context) async {
    var url = 'https://www.haarway.com/api/home/get_main_categories';
    //    Map data = {
    //      "otp": "$otpText",
    //    };

    //encode Map to JSON
    //    var body = json.encode(data);
    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "ee4454DSFDSDSF556566"
      },
    );
    print("${response.statusCode}");

    if (response.statusCode == 200) {
      Toast.show("Success", context, gravity: 1, duration: Toast.LENGTH_LONG);
      Map responseData = new Map();
      responseData = jsonDecode(response.body);
      mainCategoryResponse = MainCategoryResponse.fromJson(responseData);
    }
    print("${response.body}");
    return mainCategoryResponse;
  }

  ///     ===============o================= get popular services api call Done ===============o=================

  Future<PopularServiceCategoryResponse> getPopularServiceApiCall(
      BuildContext context) async {
    var url = 'https://www.haarway.com/api/home/get_popular_service';
    //    Map data = {
    //      "otp": "$otpText",
    //    };

    //encode Map to JSON
    //    var body = json.encode(data);
    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "ee4454DSFDSDSF556566"
      },
    );
    print("${response.statusCode}");

    if (response.statusCode == 200) {
      Toast.show("Success", context, gravity: 1, duration: Toast.LENGTH_LONG);
      Map responseData = new Map();
      responseData = jsonDecode(response.body);
      popularServiceCategoryResponse =
          PopularServiceCategoryResponse.fromJson(responseData);
    }
    print("${response.body}");
    return popularServiceCategoryResponse;
  }

  ///     ===============o================= get trending services api call Done ===============o=================

  Future<TrendingServicesBaseResponse> getTrendingServiceApiCall(
      BuildContext context) async {
    var url = 'https://www.haarway.com/api/home/get_trending';
    //    Map data = {
    //      "otp": "$otpText",
    //    };

    //encode Map to JSON
    //    var body = json.encode(data);
    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "ee4454DSFDSDSF556566"
      },
    );
    print("${response.statusCode}");

    if (response.statusCode == 200) {
      Toast.show("Success", context, gravity: 1, duration: Toast.LENGTH_LONG);
      Map responseData = new Map();
      responseData = jsonDecode(response.body);
      trendingServicesBaseResponse =
          TrendingServicesBaseResponse.fromJson(responseData);
    }
    print("${response.body}");
    return trendingServicesBaseResponse;
  }

  ///     ===============o================= get Education & Jobs  api call Done ===============o=================

  Future<EducationJobsBaseResponse> getEducationJobApiCall(
      BuildContext context) async {
    var url = 'https://www.haarway.com/api/home/get_education_job';

    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "ee4454DSFDSDSF556566"
      },
    );
    print("${response.statusCode}");

    if (response.statusCode == 200) {
      Toast.show("Success", context, gravity: 1, duration: Toast.LENGTH_LONG);
      Map responseData = new Map();
      responseData = jsonDecode(response.body);
      educationJobsBaseResponse =
          EducationJobsBaseResponse.fromJson(responseData);
    }
    print("${response.body}");
    return educationJobsBaseResponse;
  }

  ///     ===============o================= get Events & Party  api call Done ===============o=================

  Future<EventsPartyBaseResponse> getEventsAndPartyApiCall(
      BuildContext context) async {
    var url = 'https://www.haarway.com/api/home/get_events';
    //    Map data = {
    //      "otp": "$otpText",
    //    };

    //encode Map to JSON
    //    var body = json.encode(data);
    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "ee4454DSFDSDSF556566"
      },
    );
    print("${response.statusCode}");

    if (response.statusCode == 200) {
      //      Toast.show("Success", context, gravity: 1, duration: Toast.LENGTH_LONG);
      Map responseData = new Map();
      responseData = jsonDecode(response.body);
      eventsPartyBaseResponse = EventsPartyBaseResponse.fromJson(responseData);
    }
    print("${response.body}");
    return eventsPartyBaseResponse;
  }

  ///     ===============o================= get Home Improvements  api call Done ===============o=================

  Future<HomeImprovementBaseResponse> getHomeImprovementApiCall(
      BuildContext context) async {
    var url = 'https://www.haarway.com/api/home/get_home_improvements';
    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "ee4454DSFDSDSF556566"
      },
    );
    print("${response.statusCode}");
    if (response.statusCode == 200) {
      Toast.show("Success", context, gravity: 1, duration: Toast.LENGTH_LONG);
      Map responseData = new Map();
      responseData = jsonDecode(response.body);
      homeImprovementBaseResponse =
          HomeImprovementBaseResponse.fromJson(responseData);
    }
    print("${response.body}");
    return homeImprovementBaseResponse;
  }

  ///     ===============o================= get Home & Office  api call Done ===============o=================

  Future<HomeOfficeBaseResponse> gteHomeAndOfficeApiCall(
      BuildContext context) async {
    var url = 'https://www.haarway.com/api/home/get_home_office';
    //    Map data = {
    //      "otp": "$otpText",
    //    };

    //encode Map to JSON
    //    var body = json.encode(data);
    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "ee4454DSFDSDSF556566"
      },
    );
    print("${response.statusCode}");

    if (response.statusCode == 200) {
      Toast.show("Success", context, gravity: 1, duration: Toast.LENGTH_LONG);
      Map responseData = new Map();
      responseData = jsonDecode(response.body);
      homeOfficeBaseResponse = HomeOfficeBaseResponse.fromJson(responseData);
    }
    print("${response.body}");
    return homeOfficeBaseResponse;
  }

  ///     ===============o================= get Health & Care  api call Done ===============o=================

  Future<HealthCareBaseResponse> getHealthAndCareApiCall(
      BuildContext context) async {
    var url = 'https://www.haarway.com/api/home/get_health_care';
    //    Map data = {
    //      "otp": "$otpText",
    //    };

    //encode Map to JSON
    //    var body = json.encode(data);
    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "ee4454DSFDSDSF556566"
      },
    );
    print("${response.statusCode}");

    if (response.statusCode == 200) {
      Toast.show("Success", context, gravity: 1, duration: Toast.LENGTH_LONG);
      Map responseData = new Map();
      responseData = jsonDecode(response.body);
      healthCareBaseResponse = HealthCareBaseResponse.fromJson(responseData);
    }
    print("${response.body}");
    return healthCareBaseResponse;
  }

  ///     ===============o================= get Recent Search History api call Done ===============o=================

  Future<MainCategoryResponse> getRecentSearchApiCall(
      BuildContext context) async {
    var url = 'https://www.haarway.com/api/home/get_recent_search';
    //    Map data = {
    //      "otp": "$otpText",
    //    };
    //encode Map to JSON
    //    var body = json.encode(data);
    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "ee4454DSFDSDSF556566"
      },
    );
    print("${response.statusCode}");

    if (response.statusCode == 200) {
      Toast.show("Success", context, gravity: 1, duration: Toast.LENGTH_LONG);
      Map responseData = new Map();
      responseData = jsonDecode(response.body);
      mainCategoryResponse = MainCategoryResponse.fromJson(responseData);
    }
    print("${response.body}");
    return mainCategoryResponse;
  }

  Future<CityBaseResponse> getCityDataApiCall(
      BuildContext context, String searchText) async {
    var url = 'https://www.haarway.com/api/location/search_cities';
    Map data = {
      "srchtext": "$searchText",
    };

    //encode Map to JSON
    var body = json.encode(data);
    print(body);
    var response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "ee4454DSFDSDSF556566"
        },
        body: body);
    print("${response.statusCode}");

    if (response.statusCode == 200) {
      Toast.show("Success", context, gravity: 1, duration: Toast.LENGTH_LONG);
      Map responseData = new Map();
      responseData = jsonDecode(response.body);
      cityBaseResponse = CityBaseResponse.fromJson(responseData);
    }

    print("${response.body}");
    return cityBaseResponse;
  }

  Future<SingleServiceSearchBaseResponse> getSearchServiceDataApiCall(
      BuildContext context, String searchText) async {
    var url = 'https://www.haarway.com/api/home/search_service';
    Map data = {"srchtext": "$searchText", "city": "Kolkata"};

//    encode Map to JSON
    var body = json.encode(data);
    var response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "ee4454DSFDSDSF556566"
        },
        body: body);
    print("${response.statusCode}");

    if (response.statusCode == 200) {
      Toast.show(
        "Success",
        context,
        gravity: 1,
        duration: Toast.LENGTH_LONG,
      );
      Map responseData = new Map();
      responseData = jsonDecode(response.body);
      serviceSearchBaseResponse =
          SingleServiceSearchBaseResponse.fromJson(responseData);
    }
    print("${response.body}");
    return serviceSearchBaseResponse;
  }

  ///     ===============o================= get SubCategory api call Done ===============o=================

  Future<http.Response> getSubCategoryApiCall(
      SubCatDataRequestModel subCatDataModel, BuildContext context) async {
    var url = 'https://www.haarway.com/api/home/get_sub_categories';
    //    Map data = {
    //      "otp": "$otpText",
    //    };

    //encode Map to JSON
    var body = json.encode(subCatDataModel.toJson());
    print(body);
    var response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "ee4454DSFDSDSF556566"
        },
        body: body);
    print("${response.statusCode}");

    if (response.statusCode == 200) {
      Toast.show("Success", context, gravity: 1, duration: Toast.LENGTH_SHORT);
    }
    print("${response.body}");
    return response;
  }

  ///     ===============o================= get SubCategory api call Done ===============o=================

  Future<http.Response> getSubChildCategoryApiCall(
      SubChildCatDataModelRequest subCatDataModel, BuildContext context) async {
    var url = 'https://www.haarway.com/api/home/get_cat_keywords';
    //    Map data = {
    //      "otp": "$otpText",
    //    };

    //encode Map to JSON
    var body = json.encode(subCatDataModel.toJson());
    print(body);
    var response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "ee4454DSFDSDSF556566"
        },
        body: body);
    print("${response.statusCode}");

    if (response.statusCode == 200) {
      Toast.show("Success", context, gravity: 1, duration: Toast.LENGTH_LONG);
    }
    print("${response.body}");
    return response;
  }

  ///     ===============o================= get Search Result api call Done ===============o=================

  Future<http.Response> getSearchResultListDataApiCall(
      {BuildContext context,
      String seo_url,
      String city,
      String sortByTxt,
      String radius,
      List<ReqCategories> categories,
      List<Services> services,
      List<Amenities> amenities,
      List<Localities> localities,
      List<Attributes> attributes,
      PriceRange priceRange,
      List<Propertytypes> propertytypes,
      List<Furnishingtypes> furnishingtypes,
      List<Bedrooms> bedrooms,
      List<Bathrooms> bathrooms}) async {
    var url = 'https://www.haarway.com/api/search_result/index';
    Map data = {
      "seo_url": seo_url,
      "city": "Kolkata",
      "sortby": "${sortByTxt ?? ""}",
      "radius": "${radius ?? ""}",
      "categories": categories ?? "",
      "services": services ?? "",
      "amenities": amenities ?? "",
      "localities": localities ?? "",
      "attributes": attributes ?? "",
      "price_range": priceRange ?? "",
      "propertytypes": propertytypes ?? "",
      "furnishingtypes": furnishingtypes ?? "",
      "bedrooms": bedrooms ?? "",
      "bathrooms": bathrooms ?? ""
    };

    //encode Map to JSON
    var body = json.encode(data);
    print(body);
    var response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "ee4454DSFDSDSF556566"
        },
        body: body);
    print("${response.statusCode}");

    if (response.statusCode == 200) {
      Toast.show("Success", context, gravity: 1, duration: Toast.LENGTH_LONG);
      Map responseData = new Map();
//      responseData = jsonDecode(response.body);
//      if (responseData.containsKey("filterData"))
//        catServiceSearchBaseResponse =
//            ServiceCatSearchBaseResponse.fromJson(responseData);
//      else {
//        serviceCatSearchWithNoFilterBaseResponse =
//            SeriviceCatSearchWithNoFilterBaseResponse.fromJson(responseData);
//      }
    }

    print("${response.body}");
    return response;

//      responseData.containsKey("filterData") ??
//        catServiceSearchBaseResponse;
  }

//add review api call============================>>>>>>>>>>>>>>>>>>>>
  Future<http.Response> addReviewApiCall(
      BuildContext context, ReviewRequest addRequest) async {
    var url = 'https://www.haarway.com/api/service_review/add_review';
//    Map data = {
//      "srchtext": "$searchText",
//    };  N
    var body = json.encode(addRequest.toJson());
    print(body);
    var response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "ee4454DSFDSDSF556566"
        },
        body: body);
    print("${response.statusCode}");

//    if (response. == 200) {
//      Toast.show("Success", context, gravity: 1, duration: Toast.LENGTH_LONG);
    Map responseData = new Map();
    responseData = jsonDecode(response.body);
    if (responseData['status'] == "success") {}
    String messg = responseData['message'];
    Toast.show("$messg", context, duration: Toast.LENGTH_SHORT, gravity: 1);
//      cityBaseResponse = CityBaseResponse.fromJson(responseData);
//    }

    print("${response.body}");
    return response;
  }

  // request item Api Call=========================>>>>>>>>>>>>>>>>>>>>
  Future<http.Response> otpRequstItemApiCall(
      BuildContext context, RequestItemModel requestItemModel) async {
    var url = 'https://www.haarway.com/api/service_contact/request_item';
    //encode Map to JSON
    var body = json.encode(requestItemModel.toJson());
    print(body);

    var response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "ee4454DSFDSDSF556566"
        },
        body: body);

    print("${response.statusCode}");
    //    BaseResponse baseResponse = new BaseResponse();
    final Map jsonUser = jsonDecode(response.body);
    //    baseResponse = BaseResponse.fromJson(jsonUser);
    //    Data userData = baseResponse.data;

    if (response.statusCode == 200) {
      global.requestItem_otp_id = jsonUser['otp_id'];
//      global.isLoggedIn = false;
      Toast.show("Success", context, gravity: 1, duration: Toast.LENGTH_LONG);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) =>
                  //              OTPScreen()
                  RequestItemOtp()));
    }

    print("${response.body}");
    return response;
  }

  //RequestItemOtp verify===================================>>>>>>>>>>

  Future<http.Response> requestItemOtpVerify(
      String otpText, BuildContext context, String id) async {
    var url =
        'https://www.haarway.com/api/service_contact/verify_request_item_otp';
    VerifyLoginOTPModel verifyLoginOTPModel = new VerifyLoginOTPModel();
    int otp_data = int.parse(otpText);
//    verifyLoginOTPModel.otp = otp_data;
    Map data = {"otp": otpText, "otp_id": id};

    //encode Map to JSON
    var body = json.encode(data);
//    json.encode(verifyLoginOTPModel.toJSon());
    print(body);
    var response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "ee4454DSFDSDSF556566"
        },
        body: body);
    print("${response.statusCode}");
    Map responseData = new Map();
    responseData = jsonDecode(response.body);

//    String saveUser = jsonEncode(responseData['data']);
//    CommonData commonData = new CommonData();
//    commonData.saveLoginUser(saveUser);
    String status = responseData['status'];

    if (status == "success") {
      Toast.show("OTP Verified", context,
          gravity: 1, duration: Toast.LENGTH_LONG);
//      Navigator.push(context,
//          MaterialPageRoute(builder: (BuildContext context) => HomePage()));
      Navigator.push(
        context,
        MaterialPageRoute(builder: (BuildContext context) => HomeScreen()),
//          (route) => false
      );
    }
    print("${response.body}");
    return response;
  }

  Future<http.Response> getRequestApiCall(
      String customerID, BuildContext context) async {
    var url = 'https://www.haarway.com/api/customer_dashboard/get_request';

    Map data = {"customerID": customerID};

    //encode Map to JSON
    var body = json.encode(data);
    print(body);
    var response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "ee4454DSFDSDSF556566"
        },
        body: body);
    print("${response.statusCode}");
    Map responseData = new Map();
    responseData = jsonDecode(response.body);
//    String saveUser = jsonEncode(responseData['data']);
//    CommonData commonData = new CommonData();
//    commonData.saveLoginUser(saveUser);
    String status = responseData['status'];
    if (status == "success") {}
    print("${response.body}");
    return response;
  }

  Future<http.Response> editProfileApiCall(
      List<SocialDataModel> socialDataList,
      String customerID,
      String customerName,
      String sort_bio,
      String email,
      String website,
      String locality,
      String zipcode,
      String customer_profile_photo,
      BuildContext context,
      GlobalKey<State<StatefulWidget>> editProfileKey) async {
    var url = 'https://www.haarway.com/api/customer/edit';
//fghgj
    Map data = {
      "customerID": "$customerID",
      "customer_profile_photo": "$customer_profile_photo",
      "customer_name": "$customerName",
      "customer_short_bio": "$sort_bio",
      "website": "$website",
      "customer_email": "$email",
      "countries_id": "99",
      "zone_id": "235",
      "city_id": "145",
      "customer_locality": "$locality",
      "customer_zipcode": "$zipcode",
      "social_data":
//      socialDataList
          [
        {"socialID": "1", "social_url": "http://facebook.com"},
        {"socialID": "2", "social_url": "http://twitter2.com"},
        {"socialID": "3", "social_url": "http://google.com"},
        {"socialID": "4", "social_url": "http://instagram.com"},
        {"socialID": "5", "social_url": "http://skype.com"},
        {"socialID": "6", "social_url": "http://www.google.com"},
        {"socialID": "7", "social_url": "http://linkedin.com66"}
      ]
    };

    //encode Map to JSON
    var body = json.encode(data);
    print(body);
    var response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "ee4454DSFDSDSF556566"
        },
        body: body);
    print("${response.statusCode}");
    Map responseData = new Map();
    responseData = jsonDecode(response.body);
    String saveUser = jsonEncode(responseData['data']);
    CommonData commonData = new CommonData();
    commonData.saveLoginUser(saveUser);
    String status = responseData['status'];
    if (status == "success") {
      Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) => HomePage()));
    }
    if (status == 'error') {
      var message = responseData['message'];
      String errorMessage = message[0]['customer_locality_error'];
      CommonData().showAlert(context, errorMessage);
    }
    print("${response.body}");
    return response;
  }

//  ======================================<<<<<<<<<<Navigation Drawer Items Api Call>>>>>>>>>>>>>>==============================

  Future<GetPageModel> getPageApiCall(BuildContext context) async {
    var url = 'https://www.haarway.com/api/cms/get_page?seo_url=privacy-policy';

    var response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "ee4454DSFDSDSF556566"
      },
//        body: body
    );
    print("${response.statusCode}");
    Map responseData = new Map();
    responseData = jsonDecode(response.body);
//    String saveUser = jsonEncode(responseData['data']);
//    CommonData commonData = new CommonData();
//    commonData.saveLoginUser(saveUser);
    String status = responseData['status'];
    GetPageModel getPage = new GetPageModel();
    if (status == "success") {
      getPage = GetPageModel.fromJson(jsonDecode(response.body));
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => PrivacyPolicyScreen(
                    privacyPolicy: getPage,
                  )));
    }
    print("${response.body}");
    return getPage;
  }

  Future<GetPageModel> aboutUsApiCall(BuildContext context) async {
    var url = 'https://www.haarway.com/api/cms/get_page?seo_url=about-us';

    //encode Map to JSON
//    var body = json.encode(data);
//    print(body);
    var response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "ee4454DSFDSDSF556566"
      },
//        body: body
    );
    print("${response.statusCode}");
    Map responseData = new Map();
    responseData = jsonDecode(response.body);
//    String saveUser = jsonEncode(responseData['data']);
//    CommonData commonData = new CommonData();
//    commonData.saveLoginUser(saveUser);
    String status = responseData['status'];
    GetPageModel getPage = new GetPageModel();
    if (status == "success") {
      getPage = GetPageModel.fromJson(jsonDecode(response.body));
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => PrivacyPolicyScreen(
                    privacyPolicy: getPage,
                  )));
    }
    print("${response.body}");
    return getPage;
  }

  Future<http.Response> helpAndSupportApiCall(String name, String email,
      String subject, String message, BuildContext context) async {
    var url = 'https://www.haarway.com/api/contact/contact_us';
    VerifyLoginOTPModel verifyLoginOTPModel = new VerifyLoginOTPModel();

    Map data = {
      "name": "${name ?? ""}",
      "email": "${email ?? ""}",
      "subject": "${subject ?? ""}",
      "message": "${message ?? ""}"
    };

    //encode Map to JSON
    var body = json.encode(data);
//    json.encode(verifyLoginOTPModel.toJSon());
    print(body);
    var response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "ee4454DSFDSDSF556566"
        },
        body: body);
    print("${response.statusCode}");
    Map responseData = new Map();
    responseData = jsonDecode(response.body);
//    String saveUser = jsonEncode(responseData['data']);
//    CommonData commonData = new CommonData();
//    commonData.saveLoginUser(saveUser);
    String status = responseData['status'];
    if (status == "success") {
//      Navigator.push(context,
//          MaterialPageRoute(builder: (BuildContext context) => HomePage()));
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (BuildContext context) => HomePage()),
          (route) => false);
    }

    if (status == 'error') {
      var message = responseData['message'];
      print(message);
    }
    print("${response.body}");
    return response;
  }

/***
 * Upload Image Api call Start Here

  uploadFile(File image, BuildContext context) async {
    var postUri = Uri.parse("https://www.haarway.com/api/upload/upload_image");
    var request = new http.MultipartRequest("POST", postUri);
    request.fields['upload_folder_name'] = 'customer';
    request.fields['resize_width'] = '600 ';
    request.fields['resize_height'] = '500';
    request.fields['watremark'] = '';
    request.fields['file_name'] = 'customer_profile_photo';
    request.files.add(new http.MultipartFile.
//    fromString('customer_profile_photo',"$image",)
        fromBytes('customer_profile_photo',
        await File.fromUri(Uri.file(image.path)).readAsBytes(),
        filename: image.path, contentType: MediaType('image', 'png')));
//        );

    request.send().then((response) {
      print(response);
      if (response.statusCode == 200) print("Uploaded!");
    });
  }*/

  Future<dynamic> uploadFile(File imageFile, BuildContext context) async {
    var stream =
        new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();

    var uri = Uri.parse("https://www.haarway.com/api/upload/upload_image");
    var request = new http.MultipartRequest("POST", uri);
    var multipartFile = new http.MultipartFile(
        'customer_profile_photo', stream, length,
        filename: basename(imageFile.path),
        contentType: new MediaType('image', 'png'));
    //contentType: new MediaType('image', 'png'));

    request.fields['upload_folder_name'] = 'customer';
    request.fields['resize_width'] = '600 ';
    request.fields['resize_height'] = '500';
    request.fields['watremark'] = '';
    request.fields['file_name'] = 'customer_profile_photo';
    request.headers.addAll({
      "Content-Type": "application/json",
      "Authorization": "ee4454DSFDSDSF556566"
    });
    request.files.add(multipartFile);
    var response = await request.send();
    print(response.statusCode);
    String fileName;
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
      Map responseData = new Map();
      responseData = jsonDecode(value);
      if (responseData['status'] == 'success') {
        fileName = responseData['file_value'];
        global.imageFileName = fileName;
      }
    });
    return fileName;
  }
}
