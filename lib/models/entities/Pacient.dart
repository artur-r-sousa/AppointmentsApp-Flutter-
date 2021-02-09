class Pacient {
  String id;
  String name;
  String email;

  Pacient({
    this.id,
    this.name,
    this.email
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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Pacient && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

}