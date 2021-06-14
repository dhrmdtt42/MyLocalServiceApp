class ModeOfPayments {
  String mopID;
  String name;
  String sort_order;
  String status;

  ModeOfPayments({this.mopID, this.name, this.sort_order, this.status});

  factory ModeOfPayments.fromJson(Map<String, dynamic> payJson) {
    return ModeOfPayments(
        mopID: payJson['mopID'],
        name: payJson['name'],
        sort_order: payJson['sort_order'],
        status: payJson['status']);
  }
}
