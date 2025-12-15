import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../models/profile_model.dart';

class EditProfileController extends ChangeNotifier {
  final ImagePicker _picker = ImagePicker();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  
  // Controllers
  late TextEditingController nameController;
  late TextEditingController jobTitleController;
  late TextEditingController locationController;
  late TextEditingController aboutController;
  late TextEditingController phoneController;
  late TextEditingController emailController;
  late TextEditingController websiteController;
  late TextEditingController linkedinController;
  late TextEditingController githubController;

  // State
  ProfileModel _profile;
  File? _profileImage;
  bool _isLoading = false;
  String? _errorMessage;

  // Getters
  ProfileModel get profile => _profile;
  File? get profileImage => _profileImage;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<String> get skills => _profile.skills;

  EditProfileController() : _profile = ProfileModel.defaultProfile() {
    _initializeControllers();
  }

  EditProfileController.withProfile(ProfileModel profile) : _profile = profile {
    _initializeControllers();
  }

  void _initializeControllers() {
    nameController = TextEditingController(text: _profile.name);
    jobTitleController = TextEditingController(text: _profile.jobTitle);
    locationController = TextEditingController(text: _profile.location);
    aboutController = TextEditingController(text: _profile.about);
    phoneController = TextEditingController(text: _profile.phone);
    emailController = TextEditingController(text: _profile.email);
    websiteController = TextEditingController(text: _profile.website);
    linkedinController = TextEditingController(text: _profile.linkedin);
    githubController = TextEditingController(text: _profile.github);
  }

  // Image picker methods
  Future<void> pickImageFromCamera() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1000,
        maxHeight: 1000,
        imageQuality: 85,
      );
      
      if (image != null) {
        _profileImage = File(image.path);
        notifyListeners();
      }
    } catch (e) {
      _setError('Error picking image from camera: $e');
    }
  }

  Future<void> pickImageFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1000,
        maxHeight: 1000,
        imageQuality: 85,
      );
      
      if (image != null) {
        _profileImage = File(image.path);
        notifyListeners();
      }
    } catch (e) {
      _setError('Error picking image from gallery: $e');
    }
  }

  void removeProfileImage() {
    _profileImage = null;
    notifyListeners();
  }

  // Skills management
  void addSkill(String skill) {
    if (skill.trim().isNotEmpty && !_profile.skills.contains(skill.trim())) {
      _profile = _profile.copyWith(
        skills: [..._profile.skills, skill.trim()]
      );
      notifyListeners();
    }
  }

  void removeSkill(int index) {
    if (index >= 0 && index < _profile.skills.length) {
      final updatedSkills = List<String>.from(_profile.skills);
      updatedSkills.removeAt(index);
      _profile = _profile.copyWith(skills: updatedSkills);
      notifyListeners();
    }
  }

  // Validation
  String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your name';
    }
    if (value.trim().length < 2) {
      return 'Name must be at least 2 characters';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter email';
    }
    if (!value.contains('@') || !value.contains('.')) {
      return 'Please enter valid email';
    }
    return null;
  }

  String? validateAbout(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter about yourself';
    }
    if (value.trim().length < 10) {
      return 'About must be at least 10 characters';
    }
    return null;
  }

  // Save profile
  Future<bool> saveProfile() async {
    if (!formKey.currentState!.validate()) {
      return false;
    }

    _setLoading(true);
    _clearError();

    try {
      // Update profile data from controllers
      _profile = _profile.copyWith(
        name: nameController.text.trim(),
        jobTitle: jobTitleController.text.trim(),
        location: locationController.text.trim(),
        about: aboutController.text.trim(),
        phone: phoneController.text.trim(),
        email: emailController.text.trim(),
        website: websiteController.text.trim(),
        linkedin: linkedinController.text.trim(),
        github: githubController.text.trim(),
        profileImagePath: _profileImage?.path,
      );

      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      // Here you would normally make an API call to save the profile
      // await _profileRepository.updateProfile(_profile);

      _setLoading(false);
      return true;
    } catch (e) {
      _setError('Error saving profile: $e');
      _setLoading(false);
      return false;
    }
  }

  // Helper methods
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String error) {
    _errorMessage = error;
    notifyListeners();
  }

  void _clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  // Dispose controllers
  @override
  void dispose() {
    nameController.dispose();
    jobTitleController.dispose();
    locationController.dispose();
    aboutController.dispose();
    phoneController.dispose();
    emailController.dispose();
    websiteController.dispose();
    linkedinController.dispose();
    githubController.dispose();
    super.dispose();
  }
}
