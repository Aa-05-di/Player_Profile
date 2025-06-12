import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class FullPage extends StatefulWidget {
  final VideoPlayerController controller;

  const FullPage({super.key, required this.controller});

  @override
  State<FullPage> createState() => _FullPageState();
}

class _FullPageState extends State<FullPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: widget.controller.value.isInitialized
            ? AspectRatio(
                aspectRatio: widget.controller.value.aspectRatio,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    VideoPlayer(widget.controller),

                    /// Progress bar at bottom
                    Positioned(
                      bottom: 20,
                      left: 10,
                      right: 10,
                      child: VideoProgressIndicator(
                        widget.controller,
                        allowScrubbing: true,
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                      ),
                    ),

                    /// Close button (top right)
                    Positioned(
                      top: 5,
                      right: 2,
                      child: IconButton(
                        icon: const Icon(Icons.close, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),

                    /// Playback controls (center bottom)
                    Positioned(
                      bottom: 80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.replay_10,
                              color: Colors.white,
                              size: 30,
                            ),
                            onPressed: () {
                              final currentPosition = widget.controller.value.position;
                              widget.controller.seekTo(
                                currentPosition - const Duration(seconds: 10),
                              );
                            },
                          ),
                          IconButton(
                            icon: Icon(
                              widget.controller.value.isPlaying
                                  ? Icons.pause_circle_filled
                                  : Icons.play_circle_filled,
                              color: Colors.white,
                              size: 50,
                            ),
                            onPressed: () {
                              setState(() {
                                widget.controller.value.isPlaying
                                    ? widget.controller.pause()
                                    : widget.controller.play();
                              });
                            },
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.forward_10,
                              color: Colors.white,
                              size: 30,
                            ),
                            onPressed: () {
                              final currentPosition = widget.controller.value.position;
                              widget.controller.seekTo(
                                currentPosition + const Duration(seconds: 10),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            : const CircularProgressIndicator(),
      ),
    );
  }
}
