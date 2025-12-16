import 'package:flutter/material.dart';
import 'dart:io';

class CVViewPopup extends StatelessWidget {
  final String cvFilePath;
  final String fileName;
  final String uploadDate;

  const CVViewPopup({
    super.key,
    required this.cvFilePath,
    required this.fileName,
    required this.uploadDate,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.85,
        margin: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFF1C1C1E),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFFE25E7C).withValues(alpha: 0.2)),
        ),
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF2C2C2E),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Resume/CV Preview',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close, color: Colors.white),
                  ),
                ],
              ),
            ),
            
            // CV Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // CV Header Info
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2C2C2E),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFFE25E7C).withValues(alpha: 0.2)),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE25E7C).withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.picture_as_pdf,
                              color: Color(0xFFE25E7C),
                              size: 32,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  fileName,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Uploaded on $uploadDate',
                                  style: TextStyle(
                                    color: Colors.white.withValues(alpha: 0.6),
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // CV Preview Area
                    Container(
                      width: double.infinity,
                      height: 400,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFFE25E7C).withValues(alpha: 0.3)),
                      ),
                      child: Column(
                        children: [
                          // PDF Viewer Toolbar
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF5F5F5),
                              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.picture_as_pdf, color: Colors.grey[600], size: 20),
                                const SizedBox(width: 8),
                                Text(
                                  'PDF Document',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const Spacer(),
                                IconButton(
                                  onPressed: () {
                                    // TODO: Zoom in functionality
                                  },
                                  icon: Icon(Icons.zoom_in, color: Colors.grey[600]),
                                ),
                                IconButton(
                                  onPressed: () {
                                    // TODO: Zoom out functionality
                                  },
                                  icon: Icon(Icons.zoom_out, color: Colors.grey[600]),
                                ),
                              ],
                            ),
                          ),
                          // Mock PDF Content
                          Expanded(
                            child: SingleChildScrollView(
                              padding: const EdgeInsets.all(32),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Name Section
                                  const Text(
                                    'LOUISE HEDIN',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const Text(
                                    'Senior Product Designer',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  
                                  // Contact Info
                                  _buildSectionTitle('CONTACT'),
                                  const SizedBox(height: 8),
                                  _buildText('Email: louise.hedin@email.com'),
                                  _buildText('Phone: +1 (555) 123-4567'),
                                  _buildText('Location: San Francisco, CA'),
                                  const SizedBox(height: 16),
                                  
                                  // Summary
                                  _buildSectionTitle('PROFESSIONAL SUMMARY'),
                                  const SizedBox(height: 8),
                                  _buildText('Passionate product designer with 8+ years of experience creating user-centered designs. Specialized in mobile app design and design systems. Love to create beautiful and functional interfaces that solve real problems.'),
                                  const SizedBox(height: 16),
                                  
                                  // Experience
                                  _buildSectionTitle('EXPERIENCE'),
                                  const SizedBox(height: 8),
                                  _buildText('Senior Product Designer - Google Inc. (2020 - Present)'),
                                  _buildText('• Led design initiatives for flagship products'),
                                  _buildText('• Managed team of 5 designers'),
                                  _buildText('• Improved user engagement by 40%'),
                                  const SizedBox(height: 12),
                                  _buildText('Product Designer - Meta (2018 - 2020)'),
                                  _buildText('• Designed mobile app interfaces'),
                                  _buildText('• Collaborated with cross-functional teams'),
                                  const SizedBox(height: 16),
                                  
                                  // Education
                                  _buildSectionTitle('EDUCATION'),
                                  const SizedBox(height: 8),
                                  _buildText('Bachelor of Design - Stanford University (2014 - 2018)'),
                                  const SizedBox(height: 16),
                                  
                                  // Skills
                                  _buildSectionTitle('SKILLS'),
                                  const SizedBox(height: 8),
                                  _buildText('• UI/UX Design • Figma • Adobe Creative Suite'),
                                  _buildText('• Prototyping • Design Systems • User Research'),
                                  _buildText('• Mobile Design • Web Design • Interaction Design'),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {
                              // TODO: Download CV functionality
                            },
                            icon: const Icon(Icons.download, color: Color(0xFFE25E7C), size: 18),
                            label: const Text(
                              'Download',
                              style: TextStyle(color: Color(0xFFE25E7C)),
                            ),
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Color(0xFFE25E7C)),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              // TODO: Share CV functionality
                            },
                            icon: const Icon(Icons.share, size: 18),
                            label: const Text('Share'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFE25E7C),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: Color(0xFFE25E7C),
      ),
    );
  }

  Widget _buildText(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 12,
          color: Colors.black87,
          height: 1.4,
        ),
      ),
    );
  }
}
