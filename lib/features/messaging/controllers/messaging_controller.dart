import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/chat_message_model.dart';
import '../model/message_model.dart';

class MessagingController extends GetxController {
  final RxList<Message> messages = <Message>[
    Message(
      id: '1',
      senderName: 'Google Inc.',
      senderImage: 'https://i.pravatar.cc/150?img=1',
      lastMessage: 'Thank you for applying! We\'d like to schedule an interview.',
      time: '2m ago',
      unreadCount: 3,
      isOnline: true,
      isRead: false,
      company: 'Google',
      companyLogo: 'G',
      logoColor: const Color(0xFF5E7CE2),
    ),
    Message(
      id: '2',
      senderName: 'Meta Recruiting',
      senderImage: 'https://i.pravatar.cc/150?img=2',
      lastMessage: 'Your profile looks great! When can we connect?',
      time: '1h ago',
      unreadCount: 1,
      isOnline: true,
      isRead: false,
      company: 'Meta',
      companyLogo: '∞',
      logoColor: const Color(0xFFE25E7C),
    ),
    Message(
      id: '3',
      senderName: 'Apple Careers',
      senderImage: 'https://i.pravatar.cc/150?img=3',
      lastMessage: 'We received your application for Senior Designer position.',
      time: '3h ago',
      unreadCount: 0,
      isOnline: false,
      isRead: true,
      company: 'Apple',
      companyLogo: '',
      logoColor: const Color(0xFF4DB8AC),
    ),
    Message(
      id: '4',
      senderName: 'Microsoft HR',
      senderImage: 'https://i.pravatar.cc/150?img=4',
      lastMessage: 'Congratulations! You\'ve been shortlisted for the next round.',
      time: '5h ago',
      unreadCount: 2,
      isOnline: true,
      isRead: false,
      company: 'Microsoft',
      companyLogo: 'M',
      logoColor: const Color(0xFFC77DD1),
    ),
    Message(
      id: '5',
      senderName: 'Amazon Talent',
      senderImage: 'https://i.pravatar.cc/150?img=5',
      lastMessage: 'Thank you for your interest in working at Amazon.',
      time: '1d ago',
      unreadCount: 0,
      isOnline: false,
      isRead: true,
      company: 'Amazon',
      companyLogo: 'A',
      logoColor: const Color(0xFFE89C5E),
    ),
    Message(
      id: '6',
      senderName: 'Netflix Jobs',
      senderImage: 'https://i.pravatar.cc/150?img=6',
      lastMessage: 'We\'d love to learn more about your experience.',
      time: '2d ago',
      unreadCount: 0,
      isOnline: true,
      isRead: true,
      company: 'Netflix',
      companyLogo: 'N',
      logoColor: const Color(0xFFE25E7C),
    ),
  ].obs;

  final RxList<ChatMessage> conversationMessages = <ChatMessage>[
    const ChatMessage(
      message: 'Hey! How are you doing today?',
      time: '10:30 AM',
      isMe: false,
      senderName: 'John Doe',
      isRead: true,
    ),
    const ChatMessage(
      message:
          'Hi John! I\'m doing great, thanks for asking! Just working on some new designs.',
      time: '10:32 AM',
      isMe: true,
      isRead: true,
    ),
    const ChatMessage(
      message: 'That sounds awesome! I\'d love to see what you\'re working on.',
      time: '10:35 AM',
      isMe: false,
      senderName: 'John Doe',
      isRead: true,
    ),
    const ChatMessage(
      message: 'Sure! I can share some screenshots later today. Are you free for a quick call?',
      time: '10:38 AM',
      isMe: true,
      isRead: true,
    ),
    const ChatMessage(
      message: 'Yes, definitely! How about 2 PM?',
      time: '10:40 AM',
      isMe: false,
      senderName: 'John Doe',
      isRead: true,
    ),
    const ChatMessage(
      message: 'Perfect! Talk to you then 🎉',
      time: '10:42 AM',
      isMe: true,
      isRead: true,
    ),
  ].obs;

  final RxBool isTyping = false.obs;

  List<Message> getMessages({String query = ''}) {
    final trimmedQuery = query.trim().toLowerCase();
    if (trimmedQuery.isEmpty) {
      return messages.toList();
    }

    return messages.where((message) {
      return message.senderName.toLowerCase().contains(trimmedQuery) ||
          message.lastMessage.toLowerCase().contains(trimmedQuery) ||
          message.company.toLowerCase().contains(trimmedQuery);
    }).toList();
  }

  List<Message> getUnreadMessages({String query = ''}) {
    return getMessages(query: query).where((message) => !message.isRead).toList();
  }

  void sendMessage(String message) {
    if (message.trim().isEmpty) {
      return;
    }

    conversationMessages.add(
      ChatMessage(
        message: message,
        time: _formattedCurrentTime(),
        isMe: true,
        isRead: false,
      ),
    );
  }

  String _formattedCurrentTime() {
    final now = DateTime.now();
    final hour = now.hour;
    final minute = now.minute.toString().padLeft(2, '0');
    final suffix = hour >= 12 ? 'PM' : 'AM';
    final normalizedHour = hour % 12 == 0 ? 12 : hour % 12;
    return '$normalizedHour:$minute $suffix';
  }
}
