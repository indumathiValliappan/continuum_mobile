class PendingActivity {
  final String id;
  final String name;
  final String phase_name;
  final String full_version;
  final String package_id;
  final String revision_id;
  final int revision;
  final String team_id;
  final String catergory;
  final Details details;
  final Status status;

  PendingActivity({this.id, this.name, this.phase_name, this.full_version, this.package_id,
   this.revision_id, this.revision, this.team_id, this.catergory, this.details, this.status});

  factory PendingActivity.fromJson(Map<String, dynamic> json) {
    return PendingActivity(
      id: json['_id'],
      name: json['name'],
      phase_name: json['phase_name'],
      full_version: json['full_version'],
      package_id: json['package_id'],
      revision_id: json['revision_id'],
      revision: json['revision'],
      team_id: json['team_id'],
      catergory: json['catergory'],
      details: Details.fromJson(json['details']),
      status: Status.fromJson(json['status']),
    );
  }
}

class Details {
  final List assignto;
  final String text;
  final String title;
  final bool reason_required;

  Details({this.assignto, this.text, this.title, this.reason_required});

  factory Details.fromJson(Map<String, dynamic> json) {
    return Details(
      assignto: json['assignto'],
      text: json['text'],
      title: json['title'],
      reason_required: json['reason_required'],
    );
  }

}


class Status {
  final String start_dt;
  final String start_dt2;
  final String status;

  Status({ this.start_dt, this.start_dt2, this.status});

  factory Status.fromJson(Map<String, dynamic> json) {
    return Status(
      start_dt: json['start_dt'],
      start_dt2: json['start_dt2'],
      status: json['status']
    );
  }
}
