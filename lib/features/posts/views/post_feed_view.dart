import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/post_controller.dart';
import '../widgets/post_card.dart';
import '../widgets/post_composer.dart';
import '../widgets/post_empty_state.dart';

class PostFeedView extends StatelessWidget {
  PostFeedView({super.key});

  final PostController controller = Get.put(PostController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: const Color(0xFF1C1C1E),
        child: Obx(
          () {
            final posts = controller.posts;
            return ListView.builder(
              padding: const EdgeInsets.only(bottom: 120),
              itemCount: posts.isEmpty ? 2 : posts.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return PostComposer(controller: controller);
                }

                if (posts.isEmpty) {
                  return const PostEmptyState();
                }

                final post = posts[index - 1];
                return PostCard(post: post);
              },
            );
          },
        ),
      ),
    );
  }
}
