class Customer {
  String id = '';
  String name = '';
  int age = 0;

  Customer({this.id = '', this.name = '', this.age = 0});

  Customer.fromJson(Map<String, dynamic>? json, String _id) {
    id = _id;
    name = json?['name'] ?? '';
    age = json?['age'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'age': age,
    };
  }
}
