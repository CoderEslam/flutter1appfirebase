class UserModel {
  late final String uid;

  UserModel(this.uid);

  @override
  String toString() {
    return 'UserModel{uid: $uid}';
  }
}

class UserData {
  final String uid;
  final String name;
  final String sugars;
  final String strength;

  UserData(
      {required this.uid,
      required this.name,
      required this.sugars,
      required this.strength});
}
