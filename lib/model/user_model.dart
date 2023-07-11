class UserModel {
  static const String id = '1';
  static const String firstName = 'FirstName';
  static const String lastName = 'LastName';
  static const String address = 'Address';
  static const String area = 'Area';
  static const String landline = 'Landline';
  static const String mobile = 'Mobile';
  static const String nationalId = 'NationalId';
  static List<String> getFeilds() =>
      [firstName, lastName, address, area, landline, mobile, nationalId];
}

class User {
  final int id;
  final String fristName;
  final String lastName;
  final String address;
  final String area;
  final String landline;
  final String mobile;
  final String nationalId;
  User(
      {required this.id,
      required this.fristName,
      required this.lastName,
      required this.address,
      required this.area,
      required this.landline,
      required this.mobile,
      required this.nationalId});

  Map<String, dynamic> toJson() => {
        UserModel.id: id,
        UserModel.firstName: fristName,
        UserModel.lastName: lastName,
        UserModel.address: address,
        UserModel.landline: landline,
        UserModel.area:area,
        UserModel.mobile: mobile,
        UserModel.nationalId: nationalId,
      };
}
