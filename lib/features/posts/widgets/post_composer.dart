import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/post_controller.dart';

class PostComposer extends StatefulWidget {
  const PostComposer({super.key, required this.controller});

  final PostController controller;

  @override
  State<PostComposer> createState() => _PostComposerState();
}

class _PostComposerState extends State<PostComposer> {
  final TextEditingController _textEditingController = TextEditingController();
  bool _isFocused = false;
  String? _imageUrl;

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    final text = _textEditingController.text.trim();
    if (text.isEmpty && (_imageUrl == null || _imageUrl!.isEmpty)) {
      Get.snackbar(
        'Nothing to share yet',
        'Write a quick update or attach an image before posting.',
        backgroundColor: Colors.redAccent.withOpacity(0.15),
        colorText: Colors.white,
      );
      return;
    }

    widget.controller.addPost(text, imageUrl: _imageUrl);
    _textEditingController.clear();
    FocusScope.of(context).unfocus();
    setState(() {
      _isFocused = false;
      _imageUrl = null;
    });

    Get.snackbar(
      'Shared!',
      'Your post has been added to the feed.',
      backgroundColor: const Color(0xFF4DB8AC).withOpacity(0.2),
      colorText: Colors.white,
    );
  }

  Future<void> _promptImageUrl() async {
    final controller = TextEditingController(text: _imageUrl ?? '');
    final result = await showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF2F3033),
          title: const Text(
            'Attach image',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
          content: TextField(
            controller: controller,
            autofocus: true,
            decoration: InputDecoration(
              hintText: 'Paste an image URL',
              hintStyle: TextStyle(color: Colors.white.withOpacity(0.4)),
              filled: true,
              fillColor: const Color(0xFF404147),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.white.withOpacity(0.08)),
              ),
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                borderSide: BorderSide(color: Color(0xFF5E7CE2), width: 1.4),
              ),
            ),
            style: const TextStyle(color: Colors.white),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            if (_imageUrl != null)
              TextButton(
                onPressed: () => Navigator.of(context).pop(''),
                child: const Text('Remove'),
              ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(controller.text.trim()),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF5E7CE2),
              ),
              child: const Text('Attach'),
            ),
          ],
        );
      },
    );

    if (result != null) {
      setState(() {
        _imageUrl = result.isEmpty ? null : result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 24, 20, 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF2F3033),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: _isFocused
              ? const Color(0xFF5E7CE2)
              : Colors.white.withOpacity(0.08),
          width: 1.4,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF5E7CE2).withOpacity(0.12),
            blurRadius: 35,
            offset: const Offset(0, 25),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Share what's inspiring you",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Focus(
            onFocusChange: (focus) => setState(() => _isFocused = focus),
            child: TextField(
              controller: _textEditingController,
              maxLines: 5,
              minLines: 3,
              style: const TextStyle(color: Colors.white, height: 1.5),
              decoration: InputDecoration(
                hintText: 'Compose your thoughts, achievements or questions...',
                hintStyle: TextStyle(
                  color: Colors.white.withOpacity(0.4),
                  fontSize: 14,
                ),
                filled: true,
                fillColor: const Color(0xFF404147),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: Colors.white.withOpacity(0.08)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: Color(0xFF5E7CE2), width: 1.6),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _ComposerActionChip(
                icon: Icons.image_outlined,
                label: 'Add image',
                onTap: _promptImageUrl,
                isActive: _imageUrl != null,
              ),
              const SizedBox(width: 12),
              _ComposerActionChip(
                icon: Icons.celebration_outlined,
                label: 'Celebrate',
                onTap: () {},
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: _handleSubmit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF5E7CE2),
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  'Post',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                ),
              ),
            ],
          ),
          if (_imageUrl != null) ...[
            const SizedBox(height: 16),
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Image.network(
                      _imageUrl!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 12,
                  right: 12,
                  child: GestureDetector(
                    onTap: () => setState(() => _imageUrl = null),
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.close_rounded,
                        size: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _ComposerActionChip extends StatelessWidget {
  const _ComposerActionChip({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isActive = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: isActive
              ? const Color(0xFF5E7CE2).withOpacity(0.22)
              : Colors.white.withOpacity(0.08),
          borderRadius: BorderRadius.circular(16),
          border: isActive
              ? Border.all(color: const Color(0xFF5E7CE2), width: 1.2)
              : null,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 18,
              color:
                  isActive ? Colors.white : Colors.white.withOpacity(0.7),
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color:
                    isActive ? Colors.white : Colors.white.withOpacity(0.7),
                fontWeight: FontWeight.w500,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
