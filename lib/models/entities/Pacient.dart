
class Pacient {
  int id;
  String name;
  String email;
  String phoneNumber;
  String extra;

  Pacient({
    this.id,
    this.name,
    this.email,
    this.phoneNumber,
    this.extra
});



  String getName() {
    return this.name;
  }

  String getEmail() {
    return this.email;
  }

  void setEmail(String email) {
    this.email = email;
  }

  void setName(String name) {
    this.name = name;
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'extra': extra,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Pacient && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'Pacient: $name, $email, $phoneNumber, $extra';
  }
}