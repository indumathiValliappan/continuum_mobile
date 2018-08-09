class PendingActivity {
  final String id;
  final String name;
  final String phase_name;
  final String full_version;
  final String package_id;

  PendingActivity({this.id, this.name, this.phase_name, this.full_version, this.package_id});

  factory PendingActivity.fromJson(Map<String, dynamic> json) {
    return PendingActivity(
      id: json['_id'],
      name: json['name'],
      phase_name: json['phase_name'],
      full_version: json['full_version'],
      package_id: json['package_id'],
    );
  }
}