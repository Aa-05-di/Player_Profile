import 'package:flutter/material.dart';

class Pic extends StatelessWidget {
  final String image;
  const Pic({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.grey,
            ),
          ),
          Image.network(
            image,
            fit: BoxFit.contain,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
                ),
              );
            },
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: Colors.red[100],
                child: const Center(
                  child: Icon(Icons.error_outline, size: 80, color: Colors.red),
                ),
              );
            },
          ),
          Expanded(
            child: Container(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}