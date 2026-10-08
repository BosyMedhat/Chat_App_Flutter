class messageModel {
  final String message;
  final String id;

  messageModel(this.message, this.id);

  factory messageModel.fromJson(jsonData) {
    return messageModel(
      jsonData['message'] ?? '',
      jsonData['id'] ?? '',
    );
  }
}

// class messageModel {
//   final String message;
//   final String id;

//   messageModel(this.message, this.id);

//   factory messageModel.fromJson(jsonData) {
//     final Map<String, dynamic>? data = jsonData.data() as Map<String, dynamic>?;

//     return messageModel(
//       (data != null && data.containsKey('message')) ? data['message'] : '',
//       (data != null && data.containsKey('id')) ? data['id'] : '',
//     );
//   }
// }
