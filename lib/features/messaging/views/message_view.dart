import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/messaging_controller.dart';
import '../model/chat_message_model.dart';
import '../widgets/message_bubble.dart';
import '../widgets/message_input.dart';

class MessageView extends StatefulWidget {
  const MessageView({super.key});

  @override
  State<MessageView> createState() => _MessageViewState();
}

class _MessageViewState extends State<MessageView> {
  final ScrollController _scrollController = ScrollController();
  late final MessagingController _messagingController;
  late final Worker _conversationListener;

  @override
  void initState() {
    super.initState();
    _messagingController = Get.isRegistered<MessagingController>()
        ? Get.find<MessagingController>()
        : Get.put(MessagingController());

    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());

    _conversationListener = ever<List<ChatMessage>>(
      _messagingController.conversationMessages,
      (_) => _scrollToBottom(),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _conversationListener.dispose();
    super.dispose();
  }

  void _sendMessage(String message) {
    _messagingController.sendMessage(message);
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
                  Text(
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
                      SizedBox(width: 12),
                      Text('View Profile'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'search',
                  child: Row(
                    children: [
                      Icon(Icons.search, color: Colors.black87),
                      SizedBox(width: 12),
                      Text('Search in Conversation'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'mute',
                  child: Row(
                    children: [
                      Icon(Icons.volume_off, color: Colors.black87),
                      SizedBox(width: 12),
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
            child: Obx(() {
              final RxList<ChatMessage> messages =
                  _messagingController.conversationMessages;
              return ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final ChatMessage message = messages[index];
                  return MessageBubble(
                    message: message.message,
                    time: message.time,
                    isMe: message.isMe,
                    isRead: message.isRead,
                    senderName: message.senderName,
                  );
                },
              );
            }),
          ),
          // Typing indicator
          Obx(() {
            if (!_messagingController.isTyping.value) {
              return const SizedBox.shrink();
            }

            return Container(
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
            );
          }),
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
