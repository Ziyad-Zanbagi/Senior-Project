class getResult {
  String? id;
  List<String>? allergies;
  bool? allergic;

  getResult({this.id, this.allergies, this.allergic});

  getResult.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    allergies = json['allergies'].cast<String>();
    allergic = json['allergic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['allergies'] = this.allergies;
    data['allergic'] = this.allergic;
    return data;
  }
}
