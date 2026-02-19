class CreateProfileModel {
  final String? id;
  final String? fullName;
  final String? nickName;
  final String? dateOfBirth;
  final String? phoneNumber;
  final String? gender;
  final String? profileImage;

  CreateProfileModel({
    required this.id,
    required this.fullName,
    required this.nickName,
    required this.dateOfBirth,
    required this.phoneNumber,
    required this.gender,
    required this.profileImage,
  });

  @override
  String toString() {
    return '''CreateProfileModel{
    id: $id,
      fullName: $fullName, 
      nickName: $nickName, 
      dateOfBirth: $dateOfBirth, 
      phoneNumber: $phoneNumber, 
      gender: $gender, 
    }''';
  }
}
