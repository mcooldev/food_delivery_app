class MessageModel {
  String? id;
  String content, date;
  bool isSentByMe;

  MessageModel({
    this.id,
    required this.content,
    required this.date,
    required this.isSentByMe,
  });

  ///
  static String _formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, "0")}/${date.month.toString().padLeft(2, "0")}/${date.year.toString().padLeft(2, "0")}";
  }

  ///
  static List<MessageModel> messages = [
    MessageModel(
      content: "Salut",
      date: _formatDate(DateTime.now()),
      isSentByMe: true,
    ),
    MessageModel(
      content: "Salut, comment vas-tu ?",
      date: _formatDate(DateTime.now()),
      isSentByMe: false,
    ),
    MessageModel(
      content: "Je vais bien et toi ?",
      date: _formatDate(DateTime.now()),
      isSentByMe: true,
    ),
    MessageModel(
      content: "Je vais bien aussi merci.",
      date: _formatDate(DateTime.now()),
      isSentByMe: false,
    ),
    MessageModel(
      content: "Super alors !",
      date: _formatDate(DateTime.now()),
      isSentByMe: true,
    ),
  ];
}
