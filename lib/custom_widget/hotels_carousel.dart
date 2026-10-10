import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salt_cafe_app/controller/all_city_controller.dart';

class RecentHotelsCarousel extends StatelessWidget {
  final AllCityController controller;

  const RecentHotelsCarousel({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final hotels = controller.hotelList;

      // Check if list is empty
      if (hotels.isEmpty) {
        return const Center(child: Text("No hotels found"));
      }

      // Get all images from all hotels (flatten the list)
      final allImages = hotels.expand((hotel) => hotel.hotelImages).toList();

      // Check if there are any images
      if (allImages.isEmpty) {
        return const Center(child: Text("No images available"));
      }

      return CarouselSlider(
        items: allImages
            .map(
              (imageUrl) => Container(
                margin: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.cover,
                    filterQuality: FilterQuality.low,
                  ),
                ),
              ),
            )
            .toList(),
        options: CarouselOptions(
          height: 250,
          aspectRatio: 18 / 9,
          viewportFraction: 1.1, // Changed from 1.1 to see adjacent items
          initialPage: 0,
          enableInfiniteScroll: true,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 5),
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: true,
          scrollDirection: Axis.horizontal,
        ),
      );
    });
  }
}