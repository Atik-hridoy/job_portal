import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/get_started_controller.dart';
import '../widgets/company_chip_widget.dart';
import '../widgets/animated_shine_button.dart';
import '../../profile/views/profile_setup_view.dart';

class GetStartView extends GetView<GetStartedController> {
  const GetStartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF1A1A2E),
              Color(0xFF16213E),
              Color(0xFF0F3460),
              Color(0xFF533483),
            ],
            stops: [0.0, 0.3, 0.7, 1.0],
          ),
        ),
        child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: const TextSpan(
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    height: 1.2,
                  ),
                  children: [
                    TextSpan(text: 'Your search for\nthe next '),
                    TextSpan(
                      text: 'Dream',
                      style: TextStyle(
                        backgroundColor: Colors.white,
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(text: '\njob is over'),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              // Company logos section
              Expanded(
                flex: 2,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Wrap(
                        spacing: 20,
                        runSpacing: 25,
                        alignment: WrapAlignment.spaceEvenly,
                        children: [
                          CompanyChipWidget(
                            name: 'Netflix', 
                            color: Colors.red,
                            logoUrl: 'https://picsum.photos/seed/netflix/40/40.jpg',
                          ),
                          CompanyChipWidget(
                            name: 'Google', 
                            color: Colors.white,
                            logoUrl: 'https://picsum.photos/seed/google/40/40.jpg',
                          ),
                          CompanyChipWidget(
                            name: 'Tesla', 
                            color: Colors.red,
                            logoUrl: 'https://picsum.photos/seed/tesla/40/40.jpg',
                          ),
                          CompanyChipWidget(
                            name: 'Microsoft', 
                            color: Colors.grey,
                            logoUrl: 'https://picsum.photos/seed/microsoft/40/40.jpg',
                          ),
                          CompanyChipWidget(
                            name: 'Uber', 
                            color: Colors.black87,
                            logoUrl: 'https://picsum.photos/seed/uber/40/40.jpg',
                          ),
                          CompanyChipWidget(
                            name: 'Airbnb', 
                            color: Colors.pinkAccent,
                            logoUrl: 'https://picsum.photos/seed/airbnb/40/40.jpg',
                          ),
                          CompanyChipWidget(
                            name: 'Apple', 
                            color: Colors.grey[300]!,
                            logoUrl: 'https://picsum.photos/seed/apple/40/40.jpg',
                          ),
                          CompanyChipWidget(
                            name: 'Meta', 
                            color: Colors.grey[800]!,
                            logoUrl: 'https://picsum.photos/seed/meta/40/40.jpg',
                          ),
                          CompanyChipWidget(
                            name: 'Tata', 
                            color: Colors.blue,
                            logoUrl: 'https://picsum.photos/seed/tata/40/40.jpg',
                          ),
                          CompanyChipWidget(
                            name: 'Amazon', 
                            color: Colors.grey,
                            logoUrl: 'https://picsum.photos/seed/amazon/40/40.jpg',
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              AnimatedShineButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (context) => const ProfileSetupView(),
                  );
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
        ),
      ),
    );
  }
}

