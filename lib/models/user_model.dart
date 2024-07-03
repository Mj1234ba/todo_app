class UserModel {
  final String id;
  final String name;
  final String email;
  UserModel({required this.name, required this.email, required this.id});

  UserModel.formjson(Map<String, dynamic> json)
      : this(
          id: json['id'],
          email: json['email'],
          name: json['name'],
        );

  Map<String, dynamic> tojson() => {'id': id, 'name': name, 'email': email};
}
