import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final String time;
  final bool isMe;
  final bool isRead;
  final String? senderName;

  const MessageBubble({
    super.key,
    required this.message,
    required this.time,
    required this.isMe,
    this.isRead = true,
    this.senderName,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isMe) ...[
            // Sender avatar
            Container(
              width: 32,
              height: 32,
              margin: const EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(
                Icons.person,
                color: Colors.white,
                size: 18,
              ),
            ),
          ],
          Flexible(
            child: Column(
              crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                if (!isMe && senderName != null)
                  Padding(
                    padding: const EdgeInsets.only(left: 8, bottom: 2),
                    child: Text(
                      senderName!,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.75,
                  ),
                  margin: EdgeInsets.only(
                    left: isMe ? 0 : 8,
                    right: isMe ? 8 : 0,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: isMe ? const Color(0xFF0084FF) : const Color(0xFFE4E6EB),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        message,
                        style: TextStyle(
                          color: isMe ? Colors.white : Colors.black87,
                          fontSize: 16,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            time,
                            style: TextStyle(
                              color: isMe 
                                  ? Colors.white.withOpacity(0.7)
                                  : Colors.grey[500],
                              fontSize: 11,
                            ),
                          ),
                          if (isMe) ...[
                            const SizedBox(width: 4),
                            Icon(
                              isRead ? Icons.done_all : Icons.done,
                              color: isRead ? Colors.white70 : Colors.white38,
                              size: 16,
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (isMe) ...[
            // Read receipt indicator
            Container(
              width: 32,
              height: 32,
              margin: const EdgeInsets.only(left: 8),
              decoration: BoxDecoration(
                color: isRead ? Colors.blue : Colors.grey,
                borderRadius: BorderRadius.circular(16),
              ),
              child: isRead 
                  ? const Icon(Icons.done_all, color: Colors.white, size: 18)
                  : const Icon(Icons.done, color: Colors.white, size: 18),
            ),
          ],
        ],
      ),
    );
  }
}
