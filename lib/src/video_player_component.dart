import 'dart:async';
import 'dart:developer';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

class VideoPlayerComponent extends StatefulWidget {
  final String url;
  final bool isLive;

  const VideoPlayerComponent(
      {super.key, required this.url, this.isLive = true});

  @override
  State<VideoPlayerComponent> createState() => _VideoPlayerComponentState();
}

class _VideoPlayerComponentState extends State<VideoPlayerComponent> {
  late VideoPlayerController _videoPlayerController1;
  ChewieController? _chewieController;
  bool loading = true;
  FocusNode focusNode = FocusNode();
  bool showingOverlay = false;
  bool _isButtonEnabled = true;
  Timer? overlayTimer;
  Timer? buttonTimer;

  @override
  void initState() {
    super.initState();
    WakelockPlus.enable();
    initializePlayer();
  }

  @override
  void dispose() async {
    overlayTimer?.cancel();
    buttonTimer?.cancel();
    _videoPlayerController1.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  Future<void> initializePlayer() async {
    try {
      _videoPlayerController1 =
          VideoPlayerController.contentUri(Uri.parse(widget.url));

      await Future.wait([
        _videoPlayerController1.initialize(),
      ]);
      _createChewieController();
      if (mounted) {
        setState(() {
          loading = false;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  void _createChewieController() {
    _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController1,
        aspectRatio: 16 / 9,
        showControls: true,
        autoPlay: true,
        isLive: widget.isLive,
        fullScreenByDefault: true,
        allowedScreenSleep: false,
        draggableProgressBar: true,
        autoInitialize: true,
        hideControlsTimer: const Duration(seconds: 4),
        progressIndicatorDelay: const Duration(seconds: 20),
        showControlsOnInitialize: true);
  }

  void showOverlay() {
    if (showingOverlay == false && !widget.isLive) {
      setState(() {
        showingOverlay = true;
      });
      if (mounted) {
        overlayTimer = Timer(const Duration(milliseconds: 4000), () {
          setState(() {
            showingOverlay = false;
          });
        });
      }
    }
  }

  String getDuration(Duration duration) {
    String negativeSign = duration.isNegative ? '-' : '';
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60).abs());
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60).abs());
    return "$negativeSign${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  Widget build(BuildContext context) {
    _chewieController?.videoPlayerController.addListener(() {
      log("Video player state changed");
    });
    return Scaffold(
        body: _chewieController != null &&
                _chewieController!.videoPlayerController.value.isInitialized
            ? Stack(
                children: [
                  widget.isLive
                      ? Chewie(
                          controller: _chewieController!,
                        )
                      : KeyboardListener(
                          autofocus: true,
                          focusNode: focusNode,
                          onKeyEvent: (event) async {
                            showOverlay();
                            if (event.logicalKey ==
                                LogicalKeyboardKey.arrowRight) {
                              var a = _chewieController!
                                  .videoPlayerController.value.position;
                              _videoPlayerController1
                                  .seekTo(a + const Duration(seconds: 20));
                            } else if (event.logicalKey ==
                                LogicalKeyboardKey.arrowLeft) {
                              var a = _chewieController!
                                  .videoPlayerController.value.position;
                              _videoPlayerController1
                                  .seekTo(a - const Duration(seconds: 20));
                            } else if (event.logicalKey ==
                                    LogicalKeyboardKey.select &&
                                _isButtonEnabled == true) {
                              if (_videoPlayerController1.value.isPlaying) {
                                _videoPlayerController1.pause();
                              } else {
                                _videoPlayerController1.play();
                              }
                              if (mounted) {
                                setState(() {
                                  _isButtonEnabled = false;
                                });
                                buttonTimer = Timer(
                                    const Duration(milliseconds: 700), () {
                                  setState(() {
                                    _isButtonEnabled = true;
                                  });
                                });
                              }
                            } else if (event.logicalKey ==
                                LogicalKeyboardKey.arrowUp) {}
                          },
                          child: Chewie(
                            controller: _chewieController!,
                          )),
                  Visibility(
                      visible: !widget.isLive,
                      child: Positioned(
                          top: 0,
                          left: 0,
                          child: ValueListenableBuilder(
                              valueListenable: _videoPlayerController1,
                              builder: (context, value, child) {
                                return Padding(
                                    padding: const EdgeInsetsDirectional.all(2),
                                    child: Container(
                                        color: (!widget.isLive &&
                                                    showingOverlay) ||
                                                !value.isPlaying
                                            ? Colors.black
                                            : Colors.transparent,
                                        child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 6),
                                            child: Column(
                                              children: [
                                                Visibility(
                                                  visible: showingOverlay &&
                                                      !widget.isLive,
                                                  child: Text(
                                                    getDuration(value.position),
                                                    style: const TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.white,
                                                      decoration:
                                                          TextDecoration.none,
                                                    ),
                                                  ),
                                                ),
                                                Visibility(
                                                  visible: !value.isPlaying,
                                                  child: const Text(
                                                    "PAUSED",
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.white,
                                                      decoration:
                                                          TextDecoration.none,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ))));
                              }))),
                ],
              )
            : const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                  ],
                ),
              ));
  }
}
