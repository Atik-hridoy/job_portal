import '../../../core/utils/app_assets.dart';

class OnboardingModel {
  final String title;
  final String description;
  final String imagePath;

  OnboardingModel({
    required this.title,
    required this.description,
    required this.imagePath,
  });

  static List<OnboardingModel> getOnboardingPages() {
    return [
      OnboardingModel(
        title: "Find Your Dream Job",
        description: "Discover thousands of job opportunities that match your skills and interests.",
        imagePath: AppAssets.onboardingImage1,
      ),
      OnboardingModel(
        title: "Easy Application Process",
        description: "Apply to jobs with just a few taps. Track your applications in real-time.",
        imagePath: AppAssets.onboardingImage2,
      ),
      OnboardingModel(
        title: "Get Hired Faster",
        description: "Connect directly with employers and get hired for your perfect job.",
        imagePath: AppAssets.onboardingImage3,
      ),
    ];
  }
}
