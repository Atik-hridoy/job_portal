import 'package:flutter/material.dart';
import '../controllers/edit_profile_controller.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/skill_chip.dart';
import '../widgets/image_picker_option.dart';
import '../widgets/section_title.dart';
import '../widgets/cv_upload_widget.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  final EditProfileController _controller = EditProfileController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _showCVUploadOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF2C2C2E),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Upload CV/Resume',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: const Icon(Icons.file_upload, color: Color(0xFFE25E7C)),
                title: const Text('Choose from Files', style: TextStyle(color: Colors.white)),
                subtitle: const Text('Select PDF, DOC, or DOCX file', style: TextStyle(color: Colors.white54)),
                onTap: () {
                  Navigator.pop(context);
                  // TODO: File picker functionality
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt, color: Color(0xFFE25E7C)),
                title: const Text('Scan Document', style: TextStyle(color: Colors.white)),
                subtitle: const Text('Take a photo of your CV', style: TextStyle(color: Colors.white54)),
                onTap: () {
                  Navigator.pop(context);
                  // TODO: Camera functionality
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  void _showImagePickerOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF2C2C2E),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Change Profile Picture',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              ImagePickerOption(
                icon: Icons.camera_alt,
                title: 'Take Photo',
                onTap: () {
                  Navigator.pop(context);
                  _controller.pickImageFromCamera();
                },
              ),
              const SizedBox(height: 12),
              ImagePickerOption(
                icon: Icons.photo_library,
                title: 'Choose from Gallery',
                onTap: () {
                  Navigator.pop(context);
                  _controller.pickImageFromGallery();
                },
              ),
              if (_controller.profileImage != null) ...[
                const SizedBox(height: 12),
                ImagePickerOption(
                  icon: Icons.delete,
                  title: 'Remove Photo',
                  color: Colors.red,
                  onTap: () {
                    Navigator.pop(context);
                    _controller.removeProfileImage();
                  },
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  void _addSkill() {
    showDialog(
      context: context,
      builder: (context) {
        final skillController = TextEditingController();
        return AlertDialog(
          backgroundColor: const Color(0xFF2C2C2E),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text(
            'Add Skill',
            style: TextStyle(color: Colors.white),
          ),
          content: TextField(
            controller: skillController,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Enter skill name',
              hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.5)),
              filled: true,
              fillColor: const Color(0xFF1C1C1E),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (skillController.text.isNotEmpty) {
                  _controller.addSkill(skillController.text);
                  Navigator.pop(context);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF5E7CE2),
              ),
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _saveProfile() async {
    final success = await _controller.saveProfile();
    
    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Profile updated successfully!'),
          backgroundColor: Color(0xFF4DB8AC),
        ),
      );
      Navigator.pop(context);
    } else if (_controller.errorMessage != null && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_controller.errorMessage!),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1C1E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2C2C2E),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Edit Profile',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return TextButton(
                onPressed: _controller.isLoading ? null : _saveProfile,
                child: _controller.isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : const Text(
                        'Save',
                        style: TextStyle(
                          color: Color(0xFF5E7CE2),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
              );
            },
          ),
        ],
      ),
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Form(
            key: _controller.formKey,
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                Center(
                  child: Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: const LinearGradient(
                            colors: [Color(0xFF5E7CE2), Color(0xFF4DB8AC)],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF5E7CE2).withValues(alpha: 0.4),
                              blurRadius: 20,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: CircleAvatar(
                          radius: 60,
                          backgroundColor: const Color(0xFF2C2C2E),
                          backgroundImage: _controller.profileImage != null
                              ? FileImage(_controller.profileImage!)
                              : const NetworkImage('https://i.pravatar.cc/300?img=5')
                                  as ImageProvider,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: _showImagePickerOptions,
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFF5E7CE2), Color(0xFF4DB8AC)],
                              ),
                              shape: BoxShape.circle,
                              border: Border.all(color: const Color(0xFF1C1C1E), width: 3),
                            ),
                            child: const Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                const SectionTitle('Basic Information'),
                const SizedBox(height: 16),

                CustomTextField(
                  controller: _controller.nameController,
                  label: 'Full Name',
                  icon: Icons.person_outline,
                  validator: _controller.validateName,
                ),
                const SizedBox(height: 16),

                CustomTextField(
                  controller: _controller.jobTitleController,
                  label: 'Job Title',
                  icon: Icons.work_outline,
                ),
                const SizedBox(height: 16),

                CustomTextField(
                  controller: _controller.locationController,
                  label: 'Location',
                  icon: Icons.location_on_outlined,
                ),

                const SizedBox(height: 32),

                const SectionTitle('Contact Information'),
                const SizedBox(height: 16),

                CustomTextField(
                  controller: _controller.emailController,
                  label: 'Email',
                  icon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  validator: _controller.validateEmail,
                ),
                const SizedBox(height: 16),

                CustomTextField(
                  controller: _controller.phoneController,
                  label: 'Phone Number',
                  icon: Icons.phone_outlined,
                  keyboardType: TextInputType.phone,
                ),

                const SizedBox(height: 32),

                const SectionTitle('About'),
                const SizedBox(height: 16),

                CustomTextField(
                  controller: _controller.aboutController,
                  label: 'About Me',
                  icon: Icons.description_outlined,
                  maxLines: 5,
                  validator: _controller.validateAbout,
                ),

                const SizedBox(height: 32),

                const SectionTitle('Resume/CV'),
                const SizedBox(height: 16),

                CVUploadWidget(
                  cvFilePath: null, // TODO: Get actual CV file path from controller
                  onUploadCV: () => _showCVUploadOptions(context),
                ),

                const SizedBox(height: 32),

                const SectionTitle('Skills'),
                const SizedBox(height: 16),

                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2C2C2E),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
                  ),
                  child: AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          ..._controller.skills.asMap().entries.map((entry) {
                            return EditableSkillChip(
                              label: entry.value,
                              onDelete: () => _controller.removeSkill(entry.key),
                            );
                          }),
                          AddSkillButton(onTap: _addSkill),
                        ],
                      );
                    },
                  ),
                ),

                const SizedBox(height: 32),

                const SectionTitle('Social Links'),
                const SizedBox(height: 16),

                CustomTextField(
                  controller: _controller.websiteController,
                  label: 'Website',
                  icon: Icons.language,
                ),
                const SizedBox(height: 16),

                CustomTextField(
                  controller: _controller.linkedinController,
                  label: 'LinkedIn',
                  icon: Icons.work_outline,
                ),
                const SizedBox(height: 16),

                CustomTextField(
                  controller: _controller.githubController,
                  label: 'GitHub',
                  icon: Icons.code,
                ),

                const SizedBox(height: 40),

                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return Container(
                      height: 56,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF5E7CE2), Color(0xFF4DB8AC)],
                        ),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF5E7CE2).withValues(alpha: 0.4),
                            blurRadius: 15,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: _controller.isLoading ? null : _saveProfile,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: _controller.isLoading
                            ? const CircularProgressIndicator(color: Colors.white)
                            : const Text(
                                'Save Changes',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }
}
