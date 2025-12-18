import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_portal/features/search/widgets/job_search_result_card.dart';
import 'package:job_portal/features/search/widgets/search_empty_state.dart';
import 'package:job_portal/features/search/widgets/search_filter_chip.dart';
import 'package:job_portal/features/search/widgets/search_recent_chip.dart';
import 'package:job_portal/features/search/widgets/search_text_field.dart';

import '../controllers/job_search_controller.dart';


class JobSearchView extends StatelessWidget {
  const JobSearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<JobSearchController>(
      init: JobSearchController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: const Color(0xFF1C1C1E),
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SearchTextField(
                    controller: controller.searchTextController,
                    onChanged: controller.onQueryChanged,
                    onSubmitted: controller.submitSearch,
                    onClear: controller.clearSearch,
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 44,
                  child: Obx(
                    () => ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final filter = JobSearchController.availableFilters[index];
                        final isActive = controller.activeFilters.contains(filter);
                        return SearchFilterChip(
                          label: filter,
                          isActive: isActive,
                          onTap: () => controller.toggleFilter(filter),
                        );
                      },
                      separatorBuilder: (_, __) => const SizedBox(width: 10),
                      itemCount: JobSearchController.availableFilters.length,
                    ),
                  ),
                ),
                Obx(
                  () {
                    if (controller.recentSearches.isEmpty) {
                      return const SizedBox.shrink();
                    }
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Recent searches',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.7),
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            height: 34,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                final keyword = controller.recentSearches[index];
                                return SearchRecentChip(
                                  label: keyword,
                                  onTap: () {
                                    controller.searchTextController.text = keyword;
                                    controller.onQueryChanged(keyword);
                                  },
                                );
                              },
                              separatorBuilder: (_, __) => const SizedBox(width: 8),
                              itemCount: controller.recentSearches.length,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: Obx(
                    () {
                      if (controller.filteredResults.isEmpty) {
                        return const SearchEmptyState();
                      }
                      return ListView.separated(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 120),
                        itemBuilder: (context, index) {
                          final result = controller.filteredResults[index];
                          return JobSearchResultCard(result: result);
                        },
                        separatorBuilder: (_, __) => const SizedBox(height: 18),
                        itemCount: controller.filteredResults.length,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
