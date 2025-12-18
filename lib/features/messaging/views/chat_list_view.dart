import 'package:flutter/material.dart';
import 'package:job_portal/features/messaging/views/message_view.dart';
import '../widgets/chat_list_item.dart';

class ChatListView extends StatefulWidget {
  const ChatListView({super.key});

  @override
  State<ChatListView> createState() => _ChatListViewState();
}

class _ChatListViewState extends State<ChatListView> {
  final List<Map<String, dynamic>> _chats = [
    {
      'name': 'John Doe',
      'lastMessage': 'Hey! How are you doing today?',
      'time': '10:30 AM',
      'avatar': 'https://picsum.photos/seed/john/100/100.jpg',
      'isOnline': true,
      'isTyping': false,
      'unreadCount': 2,
    },
    {
      'name': 'Sarah Johnson',
      'lastMessage': 'Thanks for the interview opportunity!',
      'time': 'Yesterday',
      'avatar': 'https://picsum.photos/seed/sarah/100/100.jpg',
      'isOnline': false,
      'isTyping': false,
      'unreadCount': 0,
    },
    {
      'name': 'Tech Corp HR',
      'lastMessage': 'Your application has been received',
      'time': '2 days ago',
      'avatar': 'https://picsum.photos/seed/techcorp/100/100.jpg',
      'isOnline': true,
      'isTyping': false,
      'unreadCount': 1,
    },
    {
      'name': 'Mike Wilson',
      'lastMessage': 'Can we schedule a call tomorrow?',
      'time': '3 days ago',
      'avatar': 'https://picsum.photos/seed/mike/100/100.jpg',
      'isOnline': false,
      'isTyping': true,
      'unreadCount': 0,
    },
    {
      'name': 'Design Studio',
      'lastMessage': 'We loved your portfolio!',
      'time': '1 week ago',
      'avatar': 'https://picsum.photos/seed/design/100/100.jpg',
      'isOnline': false,
      'isTyping': false,
      'unreadCount': 0,
    },
    {
      'name': 'Emily Chen',
      'lastMessage': 'Looking forward to working together',
      'time': '1 week ago',
      'avatar': 'https://picsum.photos/seed/emily/100/100.jpg',
      'isOnline': true,
      'isTyping': false,
      'unreadCount': 5,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F2F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0084FF),
        elevation: 0,
        title: const Text(
          'Messages',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              // TODO: Search functionality
            },
            icon: const Icon(Icons.search, color: Colors.white),
          ),
          IconButton(
            onPressed: () {
              // TODO: New message functionality
            },
            icon: const Icon(Icons.edit, color: Colors.white),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: _chats.length,
        itemBuilder: (context, index) {
          final chat = _chats[index];
          return ChatListItem(
            name: chat['name'],
            lastMessage: chat['lastMessage'],
            time: chat['time'],
            avatar: chat['avatar'],
            isOnline: chat['isOnline'],
            isTyping: chat['isTyping'],
            unreadCount: chat['unreadCount'],
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MessageView(),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
