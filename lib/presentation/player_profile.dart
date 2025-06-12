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
        title: Text(
          "Player info",
          style: TextStyle(fontWeight: FontWeight.w300),
        ),
        backgroundColor: Colors.transparent,
        centerTitle: true,
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
                backgroundImage: photo.isNotEmpty ? NetworkImage(photo) : null,
                onBackgroundImageError: (exception, stackTrace) {},
                child: photo.isEmpty
                    ? const Icon(Icons.person, size: 100, color: Colors.grey)
                    : null,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            name.toUpperCase(),
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: const BorderSide(color: Colors.green, width: 2.0),
                  ),
                  color: Colors.green[100],
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DescCard(skill: skill, rating: ''),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: const BorderSide(color: Colors.green, width: 2.0),
                  ),
                  color: Colors.green[100],
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DescCard(skill: '', rating: rating),
                  ),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              child: Text(
                "Recent Reviews",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Pacifico",
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
