import 'package:flutter/material.dart';
import '../widgets/job_card_widget.dart';
import '../widgets/navigation/floating_bottom_nav_bar.dart';
import '../widgets/category_chip_widget.dart';
import 'location/location_view.dart';
import '../../profile/views/profile_view.dart';
import '../../messaging/views/chat_list_view.dart';
import '../../errors/views/error_gallery_view.dart';
import '../../posts/views/post_feed_view.dart';
import '../../search/views/job_search_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _currentIndex = 0;
  int _selectedCategory = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1C1E),
      body: _buildCurrentView(),
      bottomNavigationBar: FloatingBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      floatingActionButton: _currentIndex == 0
          ? FloatingActionButton.extended(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const ErrorGalleryView(),
                  ),
                );
              },
              backgroundColor: const Color(0xFF5E7CE2),
              icon: const Icon(Icons.error_outline_rounded),
              label: const Text('Error screens'),
            )
          : null,
    );
  }

  Widget _buildCurrentView() {
    switch (_currentIndex) {
      case 0:
        return _buildHomeView();
      case 1:
        return _buildSearchView();
      case 2:
        return _buildPostView();
      case 3:
        return _buildMessageView();
      case 4:
        return _buildProfileView();
      default:
        return _buildHomeView();
    }
  }

  Widget _buildHomeView() {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isTablet = screenWidth > 600;

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 110), // Space for floating nav bar
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(
                screenWidth * 0.05, 
                screenHeight * 0.02, 
                screenWidth * 0.05, 
                0
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hi, User',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: isTablet ? 22 : 18,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(height: 4),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LocationViewPage(),
                                ),
                              );
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.location_on_rounded,
                                  color: const Color(0xFF5E7CE2),
                                  size: 16,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  'Dhaka, Bangladesh',
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.7),
                                    fontSize: isTablet ? 14 : 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      CircleAvatar(
                        radius: isTablet ? 28 : 22,
                        backgroundImage: const NetworkImage(
                          'https://picsum.photos/seed/user/100/100.jpg',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  Text(
                    'Create A Better Future\nFor Yourself Here.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: isTablet ? 36 : 32,
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                      letterSpacing: -0.5,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  Container(
                    height: 70,
                    margin: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2C2C2E),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search for company or roles...',
                        hintStyle: TextStyle(
                          color: Colors.white.withOpacity(0.5),
                          fontSize: 16,
                        ),
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.white.withOpacity(0.5),
                          size: 24,
                        ),
                        suffixIcon: Icon(
                          Icons.tune,
                          color: Colors.white.withOpacity(0.5),
                          size: 24,
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 16,
                        ),
                      ),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      CategoryChipWidget(
                        'Remote',
                        const Color(0xFF5E7CE2),
                        isSelected: _selectedCategory == 0,
                        onTap: () => setState(() => _selectedCategory = 0),
                      ),
                      CategoryChipWidget(
                        'Full-time',
                        const Color(0xFF4DB8AC),
                        isSelected: _selectedCategory == 1,
                        onTap: () => setState(() => _selectedCategory = 1),
                      ),
                      CategoryChipWidget(
                        'Part-time',
                        const Color(0xFFFF6B6B),
                        isSelected: _selectedCategory == 2,
                        onTap: () => setState(() => _selectedCategory = 2),
                      ),
                      CategoryChipWidget(
                        'Contract',
                        const Color(0xFF9B59B6),
                        isSelected: _selectedCategory == 3,
                        onTap: () => setState(() => _selectedCategory = 3),
                      ),
                      CategoryChipWidget(
                        'Internship',
                        const Color(0xFFF39C12),
                        isSelected: _selectedCategory == 4,
                        onTap: () => setState(() => _selectedCategory = 4),
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),
                  const Text(
                    'Jobs lists',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  JobCardWidget(
                    title: 'Senior Flutter Developer',
                    company: 'Tech Corp',
                    logo: 'TC',
                    logoColor: const Color(0xFF5E7CE2),
                    location: 'San Francisco, CA',
                    experience: '5+ years',
                    type: 'Full-time',
                    description: 'We are looking for an experienced Flutter developer...',
                    salary: '\$120k - \$180k',
                    postedTime: '2 days ago',
                    backgroundColor: const Color(0xFF1A1A2E),
                    onTap: () {
                      // Navigate to job details
                    },
                  ),
                  const SizedBox(height: 16),
                  JobCardWidget(
                    title: 'Product Designer',
                    company: 'Design Studio',
                    logo: 'DS',
                    logoColor: const Color(0xFF4DB8AC),
                    location: 'New York, NY',
                    experience: '3+ years',
                    type: 'Full-time',
                    description: 'Join our creative team as a Product Designer...',
                    salary: '\$90k - \$130k',
                    postedTime: '1 week ago',
                    backgroundColor: const Color(0xFF1A1A2E),
                    onTap: () {
                      // Navigate to job details
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchView() {
    return const JobSearchView();
  }

  Widget _buildMessageView() {
    return const SafeArea(
      child: MessageListView(),
    );
  }

  Widget _buildPostView() {
    return SafeArea(
      child: PostFeedView(),
    );
  }

  Widget _buildProfileView() {
    return const ProfileView();
  }
}