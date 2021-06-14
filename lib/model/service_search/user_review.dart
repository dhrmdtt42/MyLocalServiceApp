class UserReview {
  String reviewID;
  String homeimprovementID;
  String customerID;
  String reviewTitle;
  String reviewRating;
  String reviewDesc;
  String reviewStatus;
  String createDate;
  String modifiedDate;
  String totalLikes;
  String customerName;
  String customerProfilePhoto;

  UserReview(
      {this.reviewID,
      this.homeimprovementID,
      this.customerID,
      this.reviewTitle,
      this.reviewRating,
      this.reviewDesc,
      this.reviewStatus,
      this.createDate,
      this.modifiedDate,
      this.totalLikes,
      this.customerName,
      this.customerProfilePhoto});

  UserReview.fromJson(Map<String, dynamic> json) {
    reviewID = json['reviewID'];
    homeimprovementID = json['homeimprovementID'];
    customerID = json['customerID'];
    reviewTitle = json['review_title'];
    reviewRating = json['review_rating'];
    reviewDesc = json['review_desc'];
    reviewStatus = json['review_status'];
    createDate = json['create_date'];
    modifiedDate = json['modified_date'];
    totalLikes = json['total_likes'];
    customerName = json['customer_name'];
    customerProfilePhoto = json['customer_profile_photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['reviewID'] = this.reviewID;
    data['homeimprovementID'] = this.homeimprovementID;
    data['customerID'] = this.customerID;
    data['review_title'] = this.reviewTitle;
    data['review_rating'] = this.reviewRating;
    data['review_desc'] = this.reviewDesc;
    data['review_status'] = this.reviewStatus;
    data['create_date'] = this.createDate;
    data['modified_date'] = this.modifiedDate;
    data['total_likes'] = this.totalLikes;
    data['customer_name'] = this.customerName;
    data['customer_profile_photo'] = this.customerProfilePhoto;
    return data;
  }
}
