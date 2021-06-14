import 'package:haarway_app/model/home/education_jobs/education_job_data_model.dart';

class EducationJobsBaseResponse {
  String status;
  List<EducationJobsData> educationJobsDataList;

  EducationJobsBaseResponse({this.status, this.educationJobsDataList});

  factory EducationJobsBaseResponse.fromJson(Map<String, dynamic> eduBaseJson) {
    var list = eduBaseJson['educationJobData'] as List;
    print(list.runtimeType);
    List<EducationJobsData> educationJobsList =
        list.map((e) => EducationJobsData.fromJson(e)).toList();
    return EducationJobsBaseResponse(
        status: eduBaseJson['status'],
        educationJobsDataList: educationJobsList);
  }
}
