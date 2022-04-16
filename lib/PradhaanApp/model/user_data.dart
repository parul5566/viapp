class UserData {
  UserData({
    required this.id,
    required this.name,
    required this.status,
  });

  String id;
  String name;
  String status;

  Map<String, Object> toMap() {
    return {
      'id': id,
      'name': name,
      'status': status,
    };
  }

  static UserData? fromMap(Map value) {
    if (value == null) {
      return null;
    }

    return UserData(
      id: value['id'],
      name: value['name'],
      status: value['status'],
    );
  }

  @override
  String toString() {
    return ('{id: $id, name: $name, status: $status}');
  }
}
