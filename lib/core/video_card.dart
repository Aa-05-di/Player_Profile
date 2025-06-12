import 'package:dio_demo/presentation/full_page.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:dio_demo/data/media_model.dart';
import 'package:flutter/foundation.dart';

class VideoCard extends StatefulWidget {
  final List<Videos> videos;
  final int playerId;

  const VideoCard({super.key, required this.videos, required this.playerId});

  @override
  State<VideoCard> createState() => _VideoCardState();
}

class _VideoCardState extends State<VideoCard> {
  final Map<int, VideoPlayerController> _controllers = {};

  void _initializeVideo(int videoId, String? videoUrl) {
    if (videoUrl == null || videoUrl.isEmpty) {
      if (kDebugMode) print("Skipping video ID $videoId: No valid URL");
      return;
    }
    _controllers[videoId] =
        VideoPlayerController.networkUrl(Uri.parse(videoUrl))
          ..initialize()
              .then((_) {
                if (mounted) {
                  setState(() {}); // Only update if widget is still mounted
                }
              })
              .catchError((error) {
                if (kDebugMode) {
                  print("Video initialization error for ID $videoId: $error");
                }
              });
  }

  @override
  void initState() {
    super.initState();
    widget.videos.where((video) => video.playerId == widget.playerId).forEach((
      video,
    ) {
      _initializeVideo(video.id ?? 0, video.videoUrl);
    });
  }

  @override
  void didUpdateWidget(covariant VideoCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.videos != oldWidget.videos ||
        widget.playerId != oldWidget.playerId) {
      _controllers.forEach((id, controller) => controller.dispose());
      _controllers.clear();
      widget.videos.where((video) => video.playerId == widget.playerId).forEach(
        (video) {
          _initializeVideo(video.id ?? 0, video.videoUrl);
        },
      );
    }
  }

  @override
  void dispose() {
    _controllers.forEach((id, controller) => controller.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredVideos = widget.videos
        .where((video) => video.playerId == widget.playerId)
        .toList();
    if (filteredVideos.isEmpty) {
      if (kDebugMode) print("No videos found for playerId: ${widget.playerId}");
      return Center(child: Text("No videos available for this player"));
    }

    return GridView.builder(
      shrinkWrap: true, // Allow it to fit within Column in PlayerProfile
      physics: NeverScrollableScrollPhysics(), // Prevent scrolling conflict
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: 250,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 3 / 4,
      ),
      itemCount: filteredVideos.length,
      itemBuilder: (context, index) {
        final video = filteredVideos[index];
        final controller = _controllers[video.id ?? 0];
        if (kDebugMode) {
          print(
            "Building video ID ${video.id}, Controller initialized: ${controller?.value.isInitialized ?? false}",
          );
        }
        return Card(
          shadowColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 4,
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  controller?.value.isInitialized ?? false
                      ? GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    FullPage(controller: controller),
                              ),
                            );
                          },
                          child: SizedBox(
                            height: 120,
                            width: double.infinity,
                            child: VideoPlayer(controller!),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: 120,
                            width: double.infinity,
                            child: Card(
                              shadowColor: Colors.green,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(3),
                              ),
                              child: Center(
                                child: CircularProgressIndicator(),
                              ), // Show loading
                            ),
                          ),
                        ),
                  if (controller?.value.isInitialized ?? false)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(
                            controller!.value.isPlaying
                                ? Icons.pause
                                : Icons.play_arrow,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            setState(() {
                              if (controller.value.isPlaying) {
                                controller.pause();
                              } else {
                                controller.play();
                              }
                            });
                          },
                        ),
                      ],
                    ),
                    Positioned(
                          top:80,
                          left: 130,
                          child: GestureDetector(
                            child: IconButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (_)=>FullPage(controller: controller!)));
                              },
                              icon: Icon(Icons.fullscreen, color: Colors.white),
                            ),
                          ),
                        ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(Icons.chat_bubble_outline_rounded),
                    SizedBox(width: 10),
                    Text(video.ratingCount ?? '0'),
                    Icon(Icons.star, color: Colors.yellowAccent[700]),
                    SizedBox(width: 50),
                    Icon(
                      Icons.favorite,
                      color: video.isFavourite == true
                          ? Colors.red
                          : Colors.white,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Column(
                      children: [
                        Text(
                          video.description ?? 'player video',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: 2),
                        Text(
                          video.createdAt?.split('T')[0] ?? '24 days ago',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
