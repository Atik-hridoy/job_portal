import 'package:flutter/material.dart';

class ChatListItem extends StatelessWidget {
  final String name;
  final String lastMessage;
  final String time;
  final String avatar;
  final bool isOnline;
  final bool isTyping;
  final int unreadCount;
  final VoidCallback onTap;

  const ChatListItem({
    super.key,
    required this.name,
    required this.lastMessage,
    required this.time,
    required this.avatar,
    this.isOnline = false,
    this.isTyping = false,
    this.unreadCount = 0,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      onTap: onTap,
      leading: Stack(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundImage: NetworkImage(avatar),
          ),
          if (isOnline)
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
              ),
            ),
        ],
      ),
      title: Row(
        children: [
          Expanded(
            child: Text(
              name,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Colors.black87,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (isTyping)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFE4E6EB),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildTypingDot(0),
                  const SizedBox(width: 3),
                  _buildTypingDot(1),
                  const SizedBox(width: 3),
                  _buildTypingDot(2),
                ],
              ),
            ),
        ],
      ),
      subtitle: Row(
        children: [
          Expanded(
            child: Text(
              lastMessage,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
                fontWeight: unreadCount > 0 ? FontWeight.w600 : FontWeight.normal,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            time,
            style: TextStyle(
              color: Colors.grey[500],
              fontSize: 12,
              fontWeight: unreadCount > 0 ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
      trailing: unreadCount > 0
          ? Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: const Color(0xFF0084FF),
                shape: BoxShape.circle,
              ),
              child: Text(
                unreadCount > 99 ? '99+' : unreadCount.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
          : const SizedBox.shrink(),
    );
  }

  Widget _buildTypingDot(int index) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 600 + (index * 100)),
      child: Container(
        width: 4,
        height: 4,
        decoration: BoxDecoration(
          color: Colors.grey[600],
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

class AnimatedContainer extends StatefulWidget {
  final Widget child;
  final Duration duration;

  const AnimatedContainer({
    super.key,
    required this.child,
    required this.duration,
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
