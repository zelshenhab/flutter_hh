class UserModel {
  final String uid;
  final String name;
  final String gender;
  final String orientation;
  final int age;
  final List<String> interests;
  final String instagram;
  final String? imagePath; // ✅ مسار محلي بدل imageUrl

  UserModel({
    required this.uid,
    required this.name,
    required this.gender,
    required this.orientation,
    required this.age,
    required this.interests,
    required this.instagram,
    this.imagePath,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'gender': gender,
      'orientation': orientation,
      'age': age,
      'interests': interests,
      'instagram': instagram,
      'imagePath': imagePath,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'],
      name: map['name'],
      gender: map['gender'],
      orientation: map['orientation'],
      age: map['age'],
      interests: List<String>.from(map['interests']),
      instagram: map['instagram'],
      imagePath: map['imagePath'],
    );
  }
}
