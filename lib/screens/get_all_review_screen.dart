import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salt_cafe_app/controller/review_controller.dart';
import 'package:intl/intl.dart';

class AllReviewsPage extends StatelessWidget {
  final ReviewController controllerReview = Get.put(ReviewController());

  AllReviewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'User Reviews',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/themeimg.jpeg"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Obx(() {
            if (controllerReview.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }

            if (controllerReview.errorMessage.isNotEmpty) {
              return Center(
                child: Text(
                  controllerReview.errorMessage.value,
                  style: const TextStyle(color: Colors.red),
                ),
              );
            }

            if (controllerReview.flattenedRatings.isEmpty) {
              return const Center(
                child: Text(
                  "No reviews found!",
                  style: TextStyle(color: Colors.white),
                ),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              itemCount: controllerReview.flattenedRatings.length,
              itemBuilder: (context, index) {
                final rating = controllerReview.flattenedRatings[index];
                final user = rating.userId;
                final comment = rating.comment ?? "";
                final ratingValue = rating.rating ?? 0;
                final image = rating.image ?? "";
                final rawDate = rating.date?.toString() ?? "";

                final userName = user?.fullName ?? "Guest";
                final userImage = user?.image ?? "";

                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.95),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          radius: 22,
                          backgroundImage:
                              userImage.startsWith("http")
                                  ? NetworkImage(userImage)
                                  : null,
                          backgroundColor: Colors.grey.shade300,
                          child:
                              userImage.isEmpty
                                  ? const Icon(Icons.person, size: 20)
                                  : null,
                        ),
                        title: Text(userName),
                        subtitle: Text(
                          _timeAgo(rating.date),
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: List.generate(
                                5,
                                (i) => Icon(
                                  Icons.star,
                                  size: 18,
                                  color:
                                      i < ratingValue
                                          ? const Color(0xffFFB71A)
                                          : Colors.grey.shade300,
                                ),
                              ),
                            ),
                            if (image.isNotEmpty) ...[
                              const SizedBox(height: 8),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  image,
                                  height: 100,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  errorBuilder:
                                      (_, __, ___) =>
                                          const Icon(Icons.broken_image),
                                ),
                              ),
                            ],
                            if (comment.trim().isNotEmpty) ...[
                              const SizedBox(height: 8),
                              Text(
                                comment,
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }),
        ),
      ),
    );
  }

  String _timeAgo(DateTime utcDate) {
    final now = DateTime.now().toUtc(); // match timezone
    final diff = now.difference(utcDate);

    if (diff.isNegative) return 'Just now';

    if (diff.inDays > 365) return '${(diff.inDays / 365).floor()} years ago';
    if (diff.inDays > 30) return '${(diff.inDays / 30).floor()} months ago';
    if (diff.inDays > 0) return '${diff.inDays} days ago';
    if (diff.inHours > 0) return '${diff.inHours} hours ago';
    if (diff.inMinutes > 0) return '${diff.inMinutes} minutes ago';

    return 'Just now';
  }
}
