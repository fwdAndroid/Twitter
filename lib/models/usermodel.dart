class UserModel {
  final String id;
  String? bannerImageURL = "";
  String? profileImageURL = "";
  String? email = "";
  String? name = "";
  UserModel(
      {required this.id,
      this.bannerImageURL,
      this.profileImageURL,
      this.email,
      this.name});
}
