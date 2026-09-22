class Employee {
  final String id;
  final String name;
  final String employeeId;
  final String email;
  final String? profileImageUrl;
  final String joinedDate;

  Employee({
    required this.id,
    required this.name,
    required this.employeeId,
    required this.email,
    this.profileImageUrl,
    required this.joinedDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'employeeId': employeeId,
      'email': email,
      'profileImageUrl': profileImageUrl,
      'joinedDate': joinedDate,
    };
  }
//----------------convert firestore map  -> employee object
  factory Employee.fromMap(Map<String, dynamic>map) {
    return Employee(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      employeeId: map['employeeId'] ?? '',
      email: map['email'] ?? '',
      profileImageUrl: map['profileImageUrl'],
      joinedDate: map['joinedDate'] ?? '',
    );
  }
//---------employee obj  -> json
  Map<String, dynamic> toJson() {
    return toMap();
  }
  // ----------json  ->emp obj
  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee.fromMap(json);
  }
}

