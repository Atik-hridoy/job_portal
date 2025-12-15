import 'package:flutter/material.dart';
import 'profile_setup_view.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1C1E),
      body: CustomScrollView(
        slivers: [
          // Custom App Bar with Profile Header
          SliverAppBar(
            expandedHeight: 280,
            floating: false,
            pinned: true,
            backgroundColor: const Color(0xFF2C2C2E),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.share, color: Colors.white),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.more_vert, color: Colors.white),
                onPressed: () {},
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      const Color(0xFF5E7CE2),
                      const Color(0xFF4DB8AC),
                    ],
                  ),
                ),
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // Profile Picture
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
                      // Name
                      const Text(
                        'Louise Hedin',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      // Job Title
                      Text(
                        'Senior Product Designer',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 12),
                      // Location
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
          ),

          // Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Stats Cards
                  Row(
                    children: [
                      Expanded(
                        child: _StatCard(
                          icon: Icons.work_outline,
                          value: '12',
                          label: 'Applications',
                          color: const Color(0xFF5E7CE2),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _StatCard(
                          icon: Icons.bookmark_outline,
                          value: '28',
                          label: 'Saved Jobs',
                          color: const Color(0xFFE25E7C),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _StatCard(
                          icon: Icons.visibility_outlined,
                          value: '156',
                          label: 'Profile Views',
                          color: const Color(0xFF4DB8AC),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Edit Profile Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ProfileSetupView(),
                          ),
                        );
                        
                        if (result == true) {
                          // Profile was completed successfully
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Profile completed successfully!'),
                              backgroundColor: Color(0xFF4DB8AC),
                            ),
                          );
                        }
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

                  // About Section
                  _SectionHeader(
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

                  // Experience Section
                  _SectionHeader(
                    icon: Icons.work_history_outlined,
                    title: 'Experience',
                  ),
                  const SizedBox(height: 12),
                  _ExperienceCard(
                    company: 'Google Inc.',
                    position: 'Senior Product Designer',
                    duration: '2020 - Present',
                    logo: 'G',
                    logoColor: const Color(0xFF5E7CE2),
                  ),
                  const SizedBox(height: 12),
                  _ExperienceCard(
                    company: 'Meta',
                    position: 'Product Designer',
                    duration: '2018 - 2020',
                    logo: '∞',
                    logoColor: const Color(0xFFE25E7C),
                  ),
                  const SizedBox(height: 12),
                  _ExperienceCard(
                    company: 'Apple Inc.',
                    position: 'UI/UX Designer',
                    duration: '2016 - 2018',
                    logo: '',
                    logoColor: const Color(0xFF4DB8AC),
                  ),

                  const SizedBox(height: 24),

                  // Skills Section
                  _SectionHeader(
                    icon: Icons.stars_outlined,
                    title: 'Skills',
                  ),
                  const SizedBox(height: 12),
                  _ContentCard(
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        _SkillChip('UI/UX Design', const Color(0xFF5E7CE2)),
                        _SkillChip('Figma', const Color(0xFFE25E7C)),
                        _SkillChip('Prototyping', const Color(0xFF4DB8AC)),
                        _SkillChip('Design Systems', const Color(0xFFC77DD1)),
                        _SkillChip('User Research', const Color(0xFF8B9A7C)),
                        _SkillChip('Wireframing', const Color(0xFFE89C5E)),
                        _SkillChip('Adobe XD', const Color(0xFF5E7CE2)),
                        _SkillChip('Sketch', const Color(0xFFE25E7C)),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Education Section
                  _SectionHeader(
                    icon: Icons.school_outlined,
                    title: 'Education',
                  ),
                  const SizedBox(height: 12),
                  _EducationCard(
                    degree: 'Bachelor of Fine Arts',
                    institution: 'Rhode Island School of Design',
                    year: '2012 - 2016',
                  ),

                  const SizedBox(height: 24),

                  // Portfolio Section
                  _SectionHeader(
                    icon: Icons.folder_outlined,
                    title: 'Portfolio',
                  ),
                  const SizedBox(height: 12),
                  _ContentCard(
                    child: Column(
                      children: [
                        _PortfolioItem(
                          icon: Icons.language,
                          title: 'Website',
                          subtitle: 'www.louisehedin.com',
                        ),
                        Divider(color: Colors.white.withOpacity(0.1)),
                        _PortfolioItem(
                          icon: Icons.work_outline,
                          title: 'LinkedIn',
                          subtitle: 'linkedin.com/in/louisehedin',
                        ),
                        Divider(color: Colors.white.withOpacity(0.1)),
                        _PortfolioItem(
                          icon: Icons.code,
                          title: 'GitHub',
                          subtitle: 'github.com/louisehedin',
                        ),
                        Divider(color: Colors.white.withOpacity(0.1)),
                        _PortfolioItem(
                          icon: Icons.design_services,
                          title: 'Behance',
                          subtitle: 'behance.net/louisehedin',
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Languages Section
                  _SectionHeader(
                    icon: Icons.translate,
                    title: 'Languages',
                  ),
                  const SizedBox(height: 12),
                  _ContentCard(
                    child: Column(
                      children: [
                        _LanguageItem('English', 0.95),
                        const SizedBox(height: 16),
                        _LanguageItem('Spanish', 0.75),
                        const SizedBox(height: 16),
                        _LanguageItem('French', 0.60),
                      ],
                    ),
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
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