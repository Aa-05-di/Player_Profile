import 'package:dio_demo/core/desc_card.dart';
import 'package:dio_demo/core/pic.dart';

import 'package:flutter/material.dart';

class PlayerProfile extends StatelessWidget {
  final String photo;
  final String name;
  final String rating;
  final String skill;

  const PlayerProfile({
    super.key,
    required this.photo,
    required this.name,
    required this.rating,
    required this.skill,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0, // Good practice for transparent AppBars
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 70),
            child: GestureDetector(
              onTap: () {
                if (photo.isNotEmpty) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => Pic(image: photo)),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('No image available.')),
                  );
                }
              },
              child: CircleAvatar(
                radius: 120,
                backgroundImage: photo.isNotEmpty
                    ? NetworkImage(photo)
                    : null,
                onBackgroundImageError: (exception, stackTrace) {
                  // Optional: handle image loading errors
                },
                child: photo.isEmpty
                    ? const Icon(Icons.person, size: 100, color: Colors.grey)
                    : null,
              ),
            ),
          ),
          const SizedBox(height: 4), // Added const

          Text(
            name.toUpperCase(),
            style: const TextStyle( // Added const
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 20), // Added some vertical spacing between name and cards

          // Fix: Wrap multiple children in a Row or Column directly.
          // Each DescCard needs its own Padding if you want separate padding.
          Row(
            mainAxisAlignment: MainAxisAlignment.center, // Center the row of cards
            children: [
              // First DescCard for Skill
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0), // Horizontal spacing between cards
                child: Card( // <--- Wrap DescCard in a Card if you want it to look like your previous Card design
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: const BorderSide(
                      color: Colors.green, // Border color
                      width: 2.0,          // Border thickness
                    ),
                  ),
                  color: Colors.green[200],
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0), // Padding inside the card content
                    child: DescCard(skill: skill, rating: ''), // Pass skill, rating is not used here
                  ),
                ),
              ),

              // Second DescCard for Rating
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0), // Horizontal spacing between cards
                child: Card( // <--- Wrap DescCard in a Card
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: const BorderSide(
                      color: Colors.blue, // Different border color for distinction
                      width: 2.0,
                    ),
                  ),
                  color: Colors.blue[100], // Different background color
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0), // Padding inside the card content
                    child: DescCard(
                      skill: '', // Skill not used here
                      rating: rating,
                      // You'll need to modify DescCard to display rating if you want it to show both.
                      // For now, I'll show how DescCard can be adapted for rating.
                      // Let's adjust DescCard to intelligently show skill or rating.
                    ),
                  ),
                ),
              ),
            ],
          ),
          // If you want more profile details, add them here
        ],
      ),
    );
  }
}