class EditProfileModel {
  String customerID;
  String customerProfilePhoto;
  String customerName;
  String customerShortBio;
  String website;
  String customerEmail;
  String countriesId;
  String zoneId;
  String cityId;
  String customerLocality;
  String customerZipcode;
  List<SocialData> socialData;

  EditProfileModel(
      {this.customerID,
      this.customerProfilePhoto,
      this.customerName,
      this.customerShortBio,
      this.website,
      this.customerEmail,
      this.countriesId,
      this.zoneId,
      this.cityId,
      this.customerLocality,
      this.customerZipcode,
      this.socialData});

  EditProfileModel.fromJson(Map<String, dynamic> json) {
    customerID = json['customerID'];
    customerProfilePhoto = json['customer_profile_photo'];
    customerName = json['customer_name'];
    customerShortBio = json['customer_short_bio'];
    website = json['website'];
    customerEmail = json['customer_email'];
    countriesId = json['countries_id'];
    zoneId = json['zone_id'];
    cityId = json['city_id'];
    customerLocality = json['customer_locality'];
    customerZipcode = json['customer_zipcode'];
    if (json['social_data'] != null) {
      socialData = new List<SocialData>();
      json['social_data'].forEach((v) {
        socialData.add(new SocialData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customerID'] = this.customerID;
    data['customer_profile_photo'] = this.customerProfilePhoto;
    data['customer_name'] = this.customerName;
    data['customer_short_bio'] = this.customerShortBio;
    data['website'] = this.website;
    data['customer_email'] = this.customerEmail;
    data['countries_id'] = this.countriesId;
    data['zone_id'] = this.zoneId;
    data['city_id'] = this.cityId;
    data['customer_locality'] = this.customerLocality;
    data['customer_zipcode'] = this.customerZipcode;
    if (this.socialData != null) {
      data['social_data'] = this.socialData.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SocialData {
  String socialID;
  String socialUrl;

  SocialData({this.socialID, this.socialUrl});

  SocialData.fromJson(Map<String, dynamic> json) {
    socialID = json['socialID'];
    socialUrl = json['social_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['socialID'] = this.socialID;
    data['social_url'] = this.socialUrl;
    return data;
  }
}
