class SocialData {
  List<SocialDataModel> socialData;

  SocialData({this.socialData});

  SocialData.fromJson(Map<String, dynamic> json) {
    if (json['social_data'] != null) {
      socialData = new List<SocialDataModel>();
      json['social_data'].forEach((v) {
        socialData.add(new SocialDataModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.socialData != null) {
      data['social_data'] = this.socialData.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SocialDataModel {
  String socialID;
  String socialUrl;

  SocialDataModel({this.socialID, this.socialUrl});

  SocialDataModel.fromJson(Map<String, dynamic> json) {
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
