import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'edit_profile_view.dart';
import '../controllers/profile_controller.dart';
import '../widgets/project_card.dart';
import '../widgets/add_project_dialog.dart';
import '../widgets/certificate_card.dart';
import '../widgets/add_certificate_dialog.dart';
import '../widgets/cv_upload_widget.dart';
import '../../posts/controllers/post_controller.dart';
import '../../posts/widgets/post_card.dart';
import '../../posts/widgets/post_empty_state.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  late final ProfileController _profileController;
  late final PostController _postController;

  static const String _profileName = 'Louise Hedin';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _profileController = ProfileController();
    _postController = Get.isRegistered<PostController>()
        ? Get.find<PostController>()
        : Get.put(PostController());
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1C1E),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            expandedHeight: 320,
            floating: false,
            pinned: true,
            backgroundColor: const Color(0xFF2C2C2E),
            automaticallyImplyLeading: false,
            centerTitle: false,
            title: AnimatedOpacity(
              duration: const Duration(milliseconds: 220),
              opacity: innerBoxIsScrolled ? 1 : 0,
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 16,
                    backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=5'),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Text(
                        _profileName,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'New York, USA',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.share, color: Colors.white),
                onPressed: () => _profileController.shareProfile(),
              ),
              IconButton(
                icon: const Icon(Icons.more_vert, color: Colors.white),
                onPressed: () => _profileController.showMoreOptions(context),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              titlePadding: const EdgeInsets.only(bottom: 16),
              title: AnimatedOpacity(
                duration: const Duration(milliseconds: 220),
                opacity: innerBoxIsScrolled ? 0 : 1,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text(
                      _profileName,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'New York, USA',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF5E7CE2),
                      Color(0xFF4DB8AC),
                    ],
                  ),
                ),
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 3),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 15,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: const CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(
                            'https://i.pravatar.cc/300?img=5',
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        _profileName,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Senior Product Designer',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.location_on,
                            color: Colors.white.withOpacity(0.8),
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'New York, USA',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.8),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(78),
              child: Container(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
                decoration: const BoxDecoration(
                  color: Color(0xFF2C2C2E),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF3A3A3C),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: TabBar(
                    controller: _tabController,
                    indicator: BoxDecoration(
                      color: const Color(0xFF5E7CE2),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.white.withOpacity(0.6),
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelStyle: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                    tabs: const [
                      Tab(text: 'Personalize'),
                      Tab(text: 'Timeline'),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
        body: Container(
          color: const Color(0xFF1C1C1E),
          child: TabBarView(
            controller: _tabController,
            children: [
              _PersonalizeTab(
                onAddProject: () => _showAddProjectDialog(context),
                onAddCertificate: () => _showAddCertificateDialog(context),
              ),
              _TimelineTab(
                postController: _postController,
                profileName: _profileName,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAddProjectDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const AddProjectDialog(),
    );
  }

  void _showAddCertificateDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const AddCertificateDialog(),
    );
  }
}

class _PersonalizeTab extends StatelessWidget {
  const _PersonalizeTab({
    required this.onAddProject,
    required this.onAddCertificate,
  });

  final VoidCallback onAddProject;
  final VoidCallback onAddCertificate;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 120),
      physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Expanded(
                child: _StatCard(
                  icon: Icons.work_outline,
                  value: '12',
                  label: 'Applications',
                  color: Color(0xFF5E7CE2),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _StatCard(
                  icon: Icons.bookmark_outline,
                  value: '28',
                  label: 'Saved Jobs',
                  color: Color(0xFFE25E7C),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _StatCard(
                  icon: Icons.visibility_outlined,
                  value: '156',
                  label: 'Profile Views',
                  color: Color(0xFF4DB8AC),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EditProfileView(),
                  ),
                );
              },
              icon: const Icon(Icons.edit),
              label: const Text(
                'Edit Profile',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF5E7CE2),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ),
          const SizedBox(height: 32),
          const _SectionHeader(
            icon: Icons.person_outline,
            title: 'About Me',
          ),
          const SizedBox(height: 12),
          _ContentCard(
            child: Text(
              'Passionate product designer with 8+ years of experience creating user-centered designs. Specialized in mobile app design and design systems. Love to create beautiful and functional interfaces that solve real problems.',
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: 15,
                height: 1.6,
              ),
            ),
          ),
          const SizedBox(height: 24),
          const CVUploadWidget(
            cvFilePath: 'mock_cv_path.pdf',
            onUploadCV: null,
          ),
          const SizedBox(height: 24),
          const _SectionHeader(
            icon: Icons.work_history_outlined,
            title: 'Experience',
          ),
          const SizedBox(height: 12),
          const _ExperienceCard(
            company: 'Google Inc.',
            position: 'Senior Product Designer',
            duration: '2020 - Present',
            logo: 'G',
            logoColor: Color(0xFF5E7CE2),
          ),
          const SizedBox(height: 12),
          const _ExperienceCard(
            company: 'Meta',
            position: 'Product Designer',
            duration: '2018 - 2020',
            logo: '∞',
            logoColor: Color(0xFFE25E7C),
          ),
          const SizedBox(height: 12),
          const _ExperienceCard(
            company: 'Apple Inc.',
            position: 'UI/UX Designer',
            duration: '2016 - 2018',
            logo: '',
            logoColor: Color(0xFF4DB8AC),
          ),
          const SizedBox(height: 24),
          const _SectionHeader(
            icon: Icons.stars_outlined,
            title: 'Skills',
          ),
          const SizedBox(height: 12),
          const _ContentCard(
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _SkillChip('UI/UX Design', Color(0xFF5E7CE2)),
                _SkillChip('Figma', Color(0xFFE25E7C)),
                _SkillChip('Prototyping', Color(0xFF4DB8AC)),
                _SkillChip('Design Systems', Color(0xFFC77DD1)),
                _SkillChip('User Research', Color(0xFF8B9A7C)),
                _SkillChip('Wireframing', Color(0xFFE89C5E)),
                _SkillChip('Adobe XD', Color(0xFF5E7CE2)),
                _SkillChip('Sketch', Color(0xFFE25E7C)),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const _SectionHeader(
            icon: Icons.school_outlined,
            title: 'Education',
          ),
          const SizedBox(height: 12),
          const _EducationCard(
            degree: 'Bachelor of Fine Arts',
            institution: 'Rhode Island School of Design',
            year: '2012 - 2016',
          ),
          const SizedBox(height: 24),
          const _SectionHeader(
            icon: Icons.folder_outlined,
            title: 'Portfolio',
          ),
          const SizedBox(height: 12),
          const _ContentCard(
            child: Column(
              children: [
                _PortfolioItem(
                  icon: Icons.language,
                  title: 'Website',
                  subtitle: 'www.louisehedin.com',
                ),
                Divider(color: Colors.white24),
                _PortfolioItem(
                  icon: Icons.work_outline,
                  title: 'LinkedIn',
                  subtitle: 'linkedin.com/in/louisehedin',
                ),
                Divider(color: Colors.white24),
                _PortfolioItem(
                  icon: Icons.code,
                  title: 'GitHub',
                  subtitle: 'github.com/louisehedin',
                ),
                Divider(color: Colors.white24),
                _PortfolioItem(
                  icon: Icons.design_services,
                  title: 'Behance',
                  subtitle: 'behance.net/louisehedin',
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const _SectionHeader(
            icon: Icons.translate,
            title: 'Languages',
          ),
          const SizedBox(height: 12),
          const _ContentCard(
            child: Column(
              children: [
                _LanguageItem('English', 0.95),
                SizedBox(height: 16),
                _LanguageItem('Spanish', 0.75),
                SizedBox(height: 16),
                _LanguageItem('French', 0.60),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const _SectionHeader(
                icon: Icons.work_outline,
                title: 'Projects',
              ),
              GestureDetector(
                onTap: onAddProject,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF5E7CE2).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.add,
                    color: Color(0xFF5E7CE2),
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const _ContentCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Swipe to see more projects',
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: 12,
                  ),
                ),
                SizedBox(height: 12),
                SizedBox(
                  height: 200,
                  child: _ProjectsScroller(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const _SectionHeader(
                icon: Icons.verified,
                title: 'Certificates',
              ),
              GestureDetector(
                onTap: onAddCertificate,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF4DB8AC).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.add,
                    color: Color(0xFF4DB8AC),
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const _ContentCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Swipe to see more certificates',
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: 12,
                  ),
                ),
                SizedBox(height: 12),
                SizedBox(
                  height: 200,
                  child: _CertificatesScroller(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}

class _TimelineTab extends StatelessWidget {
  const _TimelineTab({
    required this.postController,
    required this.profileName,
  });

  final PostController postController;
  final String profileName;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final userPosts = postController.posts
          .where((post) => post.authorName == profileName || post.authorName == 'You')
          .toList();

      if (userPosts.isEmpty) {
        return const Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 32),
            child: PostEmptyState(),
          ),
        );
      }

      return ListView.builder(
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 120),
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        itemCount: userPosts.length,
        itemBuilder: (context, index) {
          final post = userPosts[index];
          return PostCard(post: post);
        },
      );
    });
  }
}

class _ProjectsScroller extends StatelessWidget {
  const _ProjectsScroller();

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.zero,
      physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      children: const [
        ProjectCard(
          title: 'E-commerce Mobile App',
          description:
              'Designed and developed a complete e-commerce solution with modern UI/UX patterns and seamless user experience.',
          technologies: ['Flutter', 'Firebase', 'Stripe'],
          status: 'Completed',
          color: Color(0xFF5E7CE2),
        ),
        ProjectCard(
          title: 'Task Management System',
          description:
              'Built a comprehensive task management application with real-time collaboration features and team analytics.',
          technologies: ['React', 'Node.js', 'MongoDB'],
          status: 'In Progress',
          color: Color(0xFF4DB8AC),
        ),
        ProjectCard(
          title: 'Social Media Dashboard',
          description:
              'Created an analytics dashboard for social media management with advanced data visualization and reporting.',
          technologies: ['Python', 'Django', 'PostgreSQL'],
          status: 'Completed',
          color: Color(0xFFE25E7C),
        ),
        ProjectCard(
          title: 'AI Chat Application',
          description:
              'Developed an intelligent chat application with natural language processing and machine learning capabilities.',
          technologies: ['TensorFlow', 'Flutter', 'WebSocket'],
          status: 'In Progress',
          color: Color(0xFFC77DD1),
        ),
        ProjectCard(
          title: 'Fitness Tracker App',
          description:
              'Created a comprehensive fitness tracking application with health monitoring and workout planning features.',
          technologies: ['React Native', 'Firebase', 'HealthKit'],
          status: 'Completed',
          color: Color(0xFF8B9A7C),
        ),
      ],
    );
  }
}

class _CertificatesScroller extends StatelessWidget {
  const _CertificatesScroller();

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.zero,
      physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      children: const [
        CertificateCard(
          title: 'Flutter Development',
          issuer: 'Google',
          date: 'March 2024',
          credentialId: 'GCP-FLUTTER-2024',
          color: Color(0xFF4DB8AC),
        ),
        CertificateCard(
          title: 'React Native Specialist',
          issuer: 'Meta',
          date: 'February 2024',
          credentialId: 'META-RN-2024',
          color: Color(0xFF5E7CE2),
        ),
        CertificateCard(
          title: 'UI/UX Design',
          issuer: 'Adobe',
          date: 'January 2024',
          credentialId: 'ADOBE-UIUX-2024',
          color: Color(0xFFE25E7C),
        ),
      ],
    );
  }
}

// Stat Card Widget
class _StatCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color color;

  const _StatCard({
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color.withOpacity(0.3), color.withOpacity(0.1)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// Section Header Widget
class _SectionHeader extends StatelessWidget {
  final IconData icon;
  final String title;

  const _SectionHeader({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFF5E7CE2).withOpacity(0.2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: const Color(0xFF5E7CE2), size: 20),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

// Content Card Widget
class _ContentCard extends StatelessWidget {
  final Widget child;

  const _ContentCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF2C2C2E),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: child,
    );
  }
}

// Experience Card Widget
class _ExperienceCard extends StatelessWidget {
  final String company;
  final String position;
  final String duration;
  final String logo;
  final Color logoColor;

  const _ExperienceCard({
    required this.company,
    required this.position,
    required this.duration,
    required this.logo,
    required this.logoColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF2C2C2E),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: logoColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                logo,
                style: TextStyle(
                  color: logoColor,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  position,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  company,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: 12,
                      color: Colors.white.withOpacity(0.5),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      duration,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.5),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Skill Chip Widget
class _SkillChip extends StatelessWidget {
  final String label;
  final Color color;

  const _SkillChip(this.label, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color.withOpacity(0.3), color.withOpacity(0.1)],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

// Education Card Widget
class _EducationCard extends StatelessWidget {
  final String degree;
  final String institution;
  final String year;

  const _EducationCard({
    required this.degree,
    required this.institution,
    required this.year,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF2C2C2E),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF5E7CE2).withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.school,
              color: Color(0xFF5E7CE2),
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  degree,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  institution,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  year,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Portfolio Item Widget
class _PortfolioItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _PortfolioItem({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF5E7CE2), size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.6),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.arrow_forward_ios,
            color: Colors.white.withOpacity(0.3),
            size: 16,
          ),
        ],
      ),
    );
  }
}

// Language Item Widget
class _LanguageItem extends StatelessWidget {
  final String language;
  final double progress;

  const _LanguageItem(this.language, this.progress);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              language,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              '${(progress * 100).toInt()}%',
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 14,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.white.withOpacity(0.1),
            valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF5E7CE2)),
            minHeight: 8,
          ),
        ),
      ],
    );
  }
}
