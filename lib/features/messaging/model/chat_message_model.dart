class ChatMessage {
  final String message;
  final String time;
  final bool isMe;
  final String? senderName;
  final bool isRead;

  const ChatMessage({
    required this.message,
    required this.time,
    required this.isMe,
    this.senderName,
    required this.isRead,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      message: json['message'] as String,
      time: json['time'] as String,
      isMe: json['isMe'] as bool,
      senderName: json['senderName'] as String?,
      isRead: json['isRead'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'time': time,
      'isMe': isMe,
      'senderName': senderName,
      'isRead': isRead,
    };
  }
}
