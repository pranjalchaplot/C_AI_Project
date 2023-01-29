class OperatorModel {
  //data Type
  int? id;
  String? name;
  Map<String, dynamic>? meetings;
// constructor
  OperatorModel({
    this.id,
    this.name,
    this.meetings,
  });

  //method that assign values to respective datatype vairables
  OperatorModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    meetings = json['meetings'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['hobby'] = this.meetings;

    return data;
  }
}
