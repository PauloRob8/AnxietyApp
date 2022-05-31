class UserModel {
  UserModel({
    required this.id,
    required this.xp,
  });

  final String id;
  final int xp;

  factory UserModel.fromHasura(value) {
    return UserModel(
      id: value['user_id'] as String,
      xp: value['xp'] as int,
    );
  }
}
