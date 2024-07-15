class AddEmployeeModel {
  int? id;
  String firstName;
  String midName;
  String lastName;
  String position;
  String qualifications;
  String department;
  String city;
  String experienceInPosition;
  double salary;

  AddEmployeeModel({
    this.id,
    required this.firstName,
    required this.midName,
    required this.lastName,
    required this.position,
    required this.qualifications,
    required this.department,
    required this.city,
    required this.experienceInPosition,
    required this.salary,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstName': firstName,
      'midName': midName,
      'lastName': lastName,
      'position': position,
      'qualifications': qualifications,
      'department': department,
      'city': city,
      'experienceInPosition': experienceInPosition,
      'salary': salary,
    };
  }
}
