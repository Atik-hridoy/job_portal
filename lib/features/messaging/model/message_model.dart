import 'dart:ui';

class Message {
  final String id;
  final String senderName;
  final String senderImage;
  final String lastMessage;
  final String time;
  final int unreadCount;
  final bool isOnline;
  final bool isRead;
  final String company;
  final String companyLogo;
  final Color logoColor;



  Message({
    required this.id,
    required this.senderName,
    required this.senderImage,
    required this.lastMessage,
    required this.time,
    required this.unreadCount,
    required this.isOnline,
    required this.isRead,
    required this.company,
    required this.companyLogo,
    required this.logoColor,

  });

  factory Message.fromJson(Map<String, dynamic> json){
    return Message(
      id: json['id'],
      senderName: json['senderName'],
      senderImage: json['senderImage'], 
      lastMessage: json['lastMessage'], 
      time: json['time'], 
      unreadCount: json['unreadCount'], 
      isOnline: json['isOnline'], 
      isRead: json['isRead'], 
      company: json['company'], 
      companyLogo: json['companyLogo'], 
      logoColor: json['logoColor'],
      );
  }
  Map<String, dynamic> toJson(){
    return{
      'id' : id,
      'senderName': senderName,
      'senderImage': senderImage,
      'lastMessage': lastMessage,
      'time': time,
      'unreadCount': unreadCount,
      'isOnline': isOnline,
      'isRead': isRead,
      'company': company,
      'companyLogo': companyLogo,
      'logoColor': logoColor.value,
    };
  }
}