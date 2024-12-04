class MessageModel {
  MessageModel({
    this.name,
    required this.email,
    required this.message,
  });
  final String? name;
  final String email;
  final String message;

  Map<String, String?> messageToMap() {
    return {
      "name": name,
      "email": email,
      "message": message,
    };
  }
}
