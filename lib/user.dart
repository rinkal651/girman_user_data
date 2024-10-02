class User {
  late String first_name;
  late String last_name;
  late String city;
  late String contact_number;
  User(this.first_name, this.last_name, this.city, this.contact_number);

  factory User.fromJson(Map<String, dynamic> json) {
    return User(json['first_name'],
    json['last_name'],
     json['city'],
      json['contact_number']
    );
  }
}