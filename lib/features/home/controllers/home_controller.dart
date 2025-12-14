import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  // User information
  final String userName = 'John Doe';
  final String userAvatar = 'https://picsum.photos/seed/user123/200/200.jpg';
  
  // Categories for job filtering
  final List<Map<String, dynamic>> categories = [
    {'name': 'Remote', 'color': const Color(0xFF4CAF50), 'outlined': false},
    {'name': 'Full Time', 'color': const Color(0xFF2196F3), 'outlined': false},
    {'name': 'Part Time', 'color': const Color(0xFFFF9800), 'outlined': true},
    {'name': 'Freelance', 'color': const Color(0xFF9C27B0), 'outlined': true},
    {'name': 'Internship', 'color': const Color(0xFFF44336), 'outlined': true},
  ];
  
  // Job listings
  final List<Map<String, dynamic>> jobList = [
    {
      'title': 'Senior Flutter Developer',
      'company': 'Tech Corp',
      'logo': 'TC',
      'logoColor': const Color(0xFF2196F3),
      'location': 'San Francisco, CA',
      'experience': '5+ years',
      'type': 'Full Time',
      'description': 'We are looking for an experienced Flutter developer to join our team...',
      'salary': '\$120k - \$180k',
      'postedTime': '2 days ago',
      'backgroundColor': const Color(0xFF2C2C2E),
    },
    {
      'title': 'UI/UX Designer',
      'company': 'Design Studio',
      'logo': 'DS',
      'logoColor': const Color(0xFF9C27B0),
      'location': 'New York, NY',
      'experience': '3+ years',
      'type': 'Full Time',
      'description': 'Creative UI/UX designer needed for innovative projects...',
      'salary': '\$80k - \$120k',
      'postedTime': '1 week ago',
      'backgroundColor': const Color(0xFF2C2C2E),
    },
    {
      'title': 'Backend Developer',
      'company': 'StartupXYZ',
      'logo': 'SX',
      'logoColor': const Color(0xFFFF9800),
      'location': 'Remote',
      'experience': '4+ years',
      'type': 'Remote',
      'description': 'Looking for a skilled backend developer to build scalable systems...',
      'salary': '\$100k - \$150k',
      'postedTime': '3 days ago',
      'backgroundColor': const Color(0xFF2C2C2E),
    },
    {
      'title': 'Product Manager',
      'company': 'Innovation Labs',
      'logo': 'IL',
      'logoColor': const Color(0xFF4CAF50),
      'location': 'Boston, MA',
      'experience': '5+ years',
      'type': 'Full Time',
      'description': 'Experienced product manager to lead product development...',
      'salary': '\$130k - \$170k',
      'postedTime': '5 days ago',
      'backgroundColor': const Color(0xFF2C2C2E),
    },
  ];
  
  // Search functionality
  final RxString searchQuery = ''.obs;
  
  void updateSearchQuery(String query) {
    searchQuery.value = query;
  }
  
  // Category selection
  final RxString selectedCategory = ''.obs;
  
  void selectCategory(String category) {
    selectedCategory.value = category;
  }
  
  @override
  void onInit() {
    super.onInit();
    // Initialize any data fetching here
  }
}