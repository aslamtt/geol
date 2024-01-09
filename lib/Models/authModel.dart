class AuthModel{

 final String email;
 final String password;
 final String id;

//<editor-fold desc="Data Methods">
  const AuthModel({
    required this.email,
    required this.password,
    required this.id,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AuthModel &&
          runtimeType == other.runtimeType &&
          email == other.email &&
          password == other.password &&
          id == other.id);

  @override
  int get hashCode => email.hashCode ^ password.hashCode ^ id.hashCode;

  @override
  String toString() {
    return 'AuthModel{' +
        ' email: $email,' +
        ' password: $password,' +
        ' id: $id,' +
        '}';
  }

  AuthModel copyWith({
    String? email,
    String? password,
    String? id,
  }) {
    return AuthModel(
      email: email ?? this.email,
      password: password ?? this.password,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': this.email,
      'password': this.password,
      'id': this.id,
    };
  }

  factory AuthModel.fromMap(Map<String, dynamic> map) {
    return AuthModel(
      email: map['email'] as String,
      password: map['password'] as String,
      id: map['id'] as String,
    );
  }

//</editor-fold>
}