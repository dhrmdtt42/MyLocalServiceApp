class ReviewRequest {
  String seoUrl;
  String customerID;
  String reviewTitle;
  String reviewRating;
  String reviewDesc;

  ReviewRequest(
      {this.seoUrl,
      this.customerID,
      this.reviewTitle,
      this.reviewRating,
      this.reviewDesc});

  ReviewRequest.fromJson(Map<String, dynamic> json) {
    seoUrl = json['seo_url'];
    customerID = json['customerID'];
    reviewTitle = json['review_title'];
    reviewRating = json['review_rating'];
    reviewDesc = json['review_desc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['seo_url'] = this.seoUrl;
    data['customerID'] = this.customerID;
    data['review_title'] = this.reviewTitle;
    data['review_rating'] = this.reviewRating;
    data['review_desc'] = this.reviewDesc;
    return data;
  }
}
