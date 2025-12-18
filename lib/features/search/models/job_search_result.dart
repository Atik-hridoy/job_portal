import 'package:flutter/material.dart';

class JobSearchResult {
  final String id;
  final String title;
  final String company;
  final String summary;
  final String location;
  final String experience;
  final String employmentType;
  final String salaryRange;
  final String postedTime;
  final String logoText;
  final Color logoColor;

  const JobSearchResult({
    required this.id,
    required this.title,
    required this.company,
    required this.summary,
    required this.location,
    required this.experience,
    required this.employmentType,
    required this.salaryRange,
    required this.postedTime,
    required this.logoText,
    required this.logoColor,
  });
}
