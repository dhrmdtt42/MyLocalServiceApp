class EducationJobsData {

  String educationandjob_categoryID;
  String parentID;
  String category_title;
  String keyword_name;
  String amenities_label_text;
  String seo_url;
  String category_description;
  String category_image;
  String category_banner_image;
  String seo_title;
  String seo_keyword;
  String seo_description;
  String sort_order;
  String deletable;
  String create_date;
  String modified_date;
  String status;
  String total_items;

  EducationJobsData({
      this.educationandjob_categoryID,
      this.parentID,
      this.category_title,
      this.keyword_name,
      this.amenities_label_text,
      this.seo_url,
      this.category_description,
      this.category_image,
      this.category_banner_image,
      this.seo_title,
      this.seo_keyword,
      this.seo_description,
      this.sort_order,
      this.deletable,
      this.create_date,
      this.modified_date,
      this.status,
      this.total_items});

  factory EducationJobsData.fromJson(Map<String , dynamic> educationJson){

    return EducationJobsData(
        educationandjob_categoryID: educationJson['educationandjob_categoryID'],
        parentID: educationJson['parentID'],
        category_title: educationJson['category_title'],
        keyword_name: educationJson['keyword_name'],
        amenities_label_text: educationJson['amenities_label_text'],
        seo_url: educationJson['seo_url'],
        category_description: educationJson['category_description'],
        category_image: educationJson['category_image'],
        category_banner_image: educationJson['category_banner_image'],
        seo_title: educationJson['seo_title'],
        seo_keyword: educationJson['seo_keyword'],
        seo_description: educationJson['seo_description'],
        sort_order: educationJson['sort_order'],
        deletable: educationJson['deletable'],
        create_date: educationJson['create_date'],
        modified_date: educationJson['modified_date'],
        status: educationJson['status'],
        total_items: educationJson['total_items']
    );
  }
}
