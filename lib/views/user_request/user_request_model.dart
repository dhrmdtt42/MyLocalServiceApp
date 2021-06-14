class UserRequestModel {
  String status;
  List<RequestData> requestData;

  UserRequestModel({this.status, this.requestData});

  UserRequestModel.fromJson(Map<dynamic, dynamic> json) {
    status = json['status'];
    if (json['request_data'] != null) {
      requestData = new List<RequestData>();
      json['request_data'].forEach((v) {
        requestData.add(new RequestData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.requestData != null) {
      data['request_data'] = this.requestData.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RequestData {
  String contactID;
  String quoteID;
  String mainCat;
  String categoryID;
  String itemName;
  String keywordName;
  String categoryTitle;
  String totalItems;
  String createDate;
  String status;
  RequestDetails requestDetails;
  ProgressBar progressBar;

  RequestData(
      {this.contactID,
      this.quoteID,
      this.mainCat,
      this.categoryID,
      this.itemName,
      this.keywordName,
      this.categoryTitle,
      this.totalItems,
      this.createDate,
      this.status,
      this.requestDetails,
      this.progressBar});

  RequestData.fromJson(Map<String, dynamic> json) {
    contactID = json['contactID'];
    quoteID = json['quoteID'];
    mainCat = json['main_cat'];
    categoryID = json['categoryID'];
    itemName = json['item_name'];
    keywordName = json['keyword_name'];
    categoryTitle = json['category_title'];
    totalItems = json['total_items'];
    createDate = json['create_date'];
    status = json['status'];
    requestDetails = json['request_details'] != null
        ? new RequestDetails.fromJson(json['request_details'])
        : null;
//    progressBar = json['progress_bar'] != null
//        ? new ProgressBar.fromJson(json['progress_bar'])
//        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['contactID'] = this.contactID;
    data['quoteID'] = this.quoteID;
    data['main_cat'] = this.mainCat;
    data['categoryID'] = this.categoryID;
    data['item_name'] = this.itemName;
    data['keyword_name'] = this.keywordName;
    data['category_title'] = this.categoryTitle;
    data['total_items'] = this.totalItems;
    data['create_date'] = this.createDate;
    data['status'] = this.status;
    if (this.requestDetails != null) {
      data['request_details'] = this.requestDetails.toJson();
    }
    if (this.progressBar != null) {
      data['progress_bar'] = this.progressBar.toJson();
    }
    return data;
  }
}

class RequestDetails {
  String name;
  String mobileNumber;
  String email;
  String city;
  String message;
  String callTime;
  var quotes;
  String createDate;

  RequestDetails(
      {this.name,
      this.mobileNumber,
      this.email,
      this.city,
      this.message,
      this.callTime,
      this.quotes,
      this.createDate});

  RequestDetails.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    mobileNumber = json['mobile_number'];
    email = json['email'];
    city = json['city'];
    message = json['message'];
    callTime = json['call_time'];
    quotes = json['quotes'];
    createDate = json['create_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['mobile_number'] = this.mobileNumber;
    data['email'] = this.email;
    data['city'] = this.city;
    data['message'] = this.message;
    data['call_time'] = this.callTime;
    data['quotes'] = this.quotes;
    data['create_date'] = this.createDate;
    return data;
  }
}

class ProgressBar {
  String step1Text;
  String step2Text;
  String step2SubText;
  String step3Text;

  ProgressBar(
      {this.step1Text, this.step2Text, this.step2SubText, this.step3Text});

  ProgressBar.fromJson(Map<dynamic, dynamic> json) {
    step1Text = json['step_1_text'];
    step2Text = json['step_2_text'];
    step2SubText = json['step_2_sub_text'];
    step3Text = json['step_3_text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['step_1_text'] = this.step1Text;
    data['step_2_text'] = this.step2Text;
    data['step_2_sub_text'] = this.step2SubText;
    data['step_3_text'] = this.step3Text;
    return data;
  }
}
