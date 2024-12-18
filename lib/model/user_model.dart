class UserModel {
  String? name;
  String? id;
  String? phone;
  String? userEmail;
  String? AdminEmail;
  String? type;
  String? profilePic;

  UserModel(
      {this.name,
        this.userEmail,
        this.id,
        this.AdminEmail,
        this.phone,
        this.profilePic,
        this.type});

  Map<String, dynamic> toJson() => {
    'name': name,
    'phone': phone,
    'id': id,
    'userEmail': userEmail,
    'AdminEmail': AdminEmail,
    'type': type,
    'profilePic': profilePic
  };
}