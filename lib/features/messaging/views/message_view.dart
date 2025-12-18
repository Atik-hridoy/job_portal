import 'package:flutter/material.dart';
import '../widgets/message_bubble.dart';
import '../widgets/message_input.dart';

class MessageView extends StatefulWidget {
  const MessageView({super.key});

  @override
  State<MessageView> createState() => _MessageViewState();
}

class _MessageViewState extends State<MessageView> {
  final ScrollController _scrollController = ScrollController();
  final List<Map<String, dynamic>> _messages = [
    {
      'message': 'Hey! How are you doing today?',
      'time': '10:30 AM',
      'isMe': false,
      'senderName': 'John Doe',
      'isRead': true,
    },
    {
      'message': 'Hi John! I\'m doing great, thanks for asking! Just working on some new designs.',
      'time': '10:32 AM',
      'isMe': true,
      'isRead': true,
    },
    {
      'message': 'That sounds awesome! I\'d love to see what you\'re working on.',
      'time': '10:35 AM',
      'isMe': false,
      'senderName': 'John Doe',
      'isRead': true,
    },
    {
      'message': 'Sure! I can share some screenshots later today. Are you free for a quick call?',
      'time': '10:38 AM',
      'isMe': true,
      'isRead': true,
    },
    {
      'message': 'Yes, definitely! How about 2 PM?',
      'time': '10:40 AM',
      'isMe': false,
      'senderName': 'John Doe',
      'isRead': true,
    },
    {
      'message': 'Perfect! Talk to you then 🎉',
      'time': '10:42 AM',
      'isMe': true,
      'isRead': true,
    },
  ];

  bool _isTyping = false;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage(String message) {
    setState(() {
      _messages.add({
        'message': message,
        'time': DateTime.now().toString().substring(11, 16),
        'isMe': true,
        'isRead': false,
      });
    });
    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F2F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0084FF),
        elevation: 0,
        title: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(
                Icons.person,
                color: Color(0xFF0084FF),
                size: 18,
              ),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'John Doe',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  
                ],
              ),
            ),
            IconButton(
              onPressed: () {
                // TODO: Video call functionality
              },
              icon: const Icon(Icons.videocam, color: Colors.white),
            ),
            IconButton(
              onPressed: () {
                // TODO: Voice call functionality
              },
              icon: const Icon(Icons.call, color: Colors.white),
            ),
            PopupMenuButton<String>(
              icon: const Icon(Icons.more_vert, color: Colors.white),
              color: Colors.transparent,
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'view_profile',
                  child: Row(
                    children: [
                      Icon(Icons.person, color: Colors.black87),
                      const SizedBox(width: 12),
                      Text('View Profile'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'search',
                  child: Row(
                    children: [
                      Icon(Icons.search, color: Colors.black87),
                      const SizedBox(width: 12),
                      Text('Search in Conversation'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'mute',
                  child: Row(
                    children: [
                      Icon(Icons.volume_off, color: Colors.black87),
                      const SizedBox(width: 12),
                      Text('Mute Notifications'),
                    ],
                  ),
                ),
              ],
              onSelected: (value) {
                // TODO: Handle menu actions
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Date separator
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: const Color(0xFFE4E6EB),
            child: const Text(
              'Today',
              style: TextStyle(
                color: Colors.black54,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          // Messages list
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return MessageBubble(
                  message: message['message'],
                  time: message['time'],
                  isMe: message['isMe'],
                  isRead: message['isRead'],
                  senderName: message['senderName'],
                );
              },
            ),
          ),
          // Typing indicator
          if (_isTyping)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
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
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildTypingDot(0),
                        const SizedBox(width: 4),
                        _buildTypingDot(1),
                        const SizedBox(width: 4),
                        _buildTypingDot(2),
                      ],
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
      bottomNavigationBar: MessageInput(
        onSendMessage: _sendMessage,
        onAttachImage: () {
          // TODO: Image attachment functionality
        },
        onAttachFile: () {
          // TODO: File attachment functionality
        },
      ),
    );
  }

  Widget _buildTypingDot(int index) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 600 + (index * 100)),
      curve: Curves.easeInOut,
      child: Container(
        width: 8,
        height: 8,
        decoration: BoxDecoration(
          color: Colors.black54,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

// Animated container for typing dots
class AnimatedContainer extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Curve curve;

  const AnimatedContainer({
    super.key,
    required this.child,
    required this.duration,
    required this.curve,
  });

  @override
  State<AnimatedContainer> createState() => _AnimatedContainerState();
}

class _AnimatedContainerState extends State<AnimatedContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: 0.5 + (_controller.value * 0.5),
          child: widget.child,
        );
      },
    );
  }
}