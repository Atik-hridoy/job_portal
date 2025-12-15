class ProfileModel {
  final String name;
  final String jobTitle;
  final String location;
  final String about;
  final String phone;
  final String email;
  final String website;
  final String linkedin;
  final String github;
  final List<String> skills;
  final String? profileImagePath;

  ProfileModel({
    required this.name,
    required this.jobTitle,
    required this.location,
    required this.about,
    required this.phone,
    required this.email,
    required this.website,
    required this.linkedin,
    required this.github,
    required this.skills,
    this.profileImagePath,
  });

  // Default profile data
  factory ProfileModel.defaultProfile() {
    return ProfileModel(
      name: 'Louise Hedin',
      jobTitle: 'Senior Product Designer',
      location: 'New York, USA',
      about: 'Passionate product designer with 8+ years of experience creating user-centered designs.',
      phone: '+1 234 567 8900',
      email: 'louise.hedin@email.com',
      website: 'www.louisehedin.com',
      linkedin: 'linkedin.com/in/louisehedin',
      github: 'github.com/louisehedin',
      skills: [
        'UI/UX Design',
        'Figma',
        'Prototyping',
        'Design Systems',
        'User Research',
      ],
    );
  }

  ProfileModel copyWith({
    String? name,
    String? jobTitle,
    String? location,
    String? about,
    String? phone,
    String? email,
    String? website,
    String? linkedin,
    String? github,
    List<String>? skills,
    String? profileImagePath,
  }) {
    return ProfileModel(
      name: name ?? this.name,
      jobTitle: jobTitle ?? this.jobTitle,
      location: location ?? this.location,
      about: about ?? this.about,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      website: website ?? this.website,
      linkedin: linkedin ?? this.linkedin,
      github: github ?? this.github,
      skills: skills ?? this.skills,
      profileImagePath: profileImagePath ?? this.profileImagePath,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProfileModel &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          jobTitle == other.jobTitle &&
          location == other.location &&
          about == other.about &&
          phone == other.phone &&
          email == other.email &&
          website == other.website &&
          linkedin == other.linkedin &&
          github == other.github &&
          profileImagePath == other.profileImagePath;

  @override
  int get hashCode =>
      name.hashCode ^
      jobTitle.hashCode ^
      location.hashCode ^
      about.hashCode ^
      phone.hashCode ^
      email.hashCode ^
      website.hashCode ^
      linkedin.hashCode ^
      github.hashCode ^
      profileImagePath.hashCode;
}
