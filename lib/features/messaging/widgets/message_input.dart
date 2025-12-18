import 'package:flutter/material.dart';

class MessageInput extends StatefulWidget {
  final Function(String) onSendMessage;
  final VoidCallback? onAttachFile;
  final VoidCallback? onAttachImage;

  const MessageInput({
    super.key,
    required this.onSendMessage,
    this.onAttachFile,
    this.onAttachImage,
  });

  @override
  State<MessageInput> createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput> {
  final TextEditingController _controller = TextEditingController();
  bool _isTyping = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (_controller.text.trim().isNotEmpty) {
      widget.onSendMessage(_controller.text.trim());
      _controller.clear();
      setState(() {
        _isTyping = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Colors.grey[300]!,
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        child: Row(
          children: [
            // Left side actions
            Row(
              children: [
                IconButton(
                  onPressed: widget.onAttachImage,
                  icon: Icon(
                    Icons.image,
                    color: Colors.grey[600],
                    size: 24,
                  ),
                ),
                IconButton(
                  onPressed: widget.onAttachFile,
                  icon: Icon(
                    Icons.attach_file,
                    color: Colors.grey[600],
                    size: 24,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    // TODO: Voice message functionality
                  },
                  icon: Icon(
                    Icons.mic,
                    color: Colors.grey[600],
                    size: 24,
                  ),
                ),
              ],
            ),
            // Text input
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(25),
                ),
                child: TextField(
                  controller: _controller,
                  onChanged: (value) {
                    setState(() {
                      _isTyping = value.isNotEmpty;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Type a message...',
                    hintStyle: TextStyle(color: Colors.grey[500]),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                  ),
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                  maxLines: null,
                  textCapitalization: TextCapitalization.sentences,
                ),
              ),
            ),
            // Send button or typing indicator
            _isTyping
                ? Container(
                    margin: const EdgeInsets.only(left: 8),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                    child: const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                  )
                : IconButton(
                    onPressed: _sendMessage,
                    icon: const Icon(
                      Icons.send,
                      color: Colors.blue,
                      size: 24,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
