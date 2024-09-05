import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import 'package:social_media_app/Posts/Image/Model/image_post_model.dart';
import 'package:social_media_app/Posts/Image/Widgets/imagePostShowing.dart';
import 'package:video_player/video_player.dart';

class VideoTile extends ConsumerStatefulWidget {
  final PostModel videomodel;
  const VideoTile({super.key, required this.videomodel});

  @override
  ConsumerState<VideoTile> createState() => _VideoTileState();
}

class _VideoTileState extends ConsumerState<VideoTile> {
  void sharePost(String postId) {
    final link = "https://socialmediaapp-e6960.web.app/post?id=$postId";
    Share.share("Check out this  post: $link");
  }

  late VideoPlayerController controller;
  late Future<void> initVideoPlayer;

  final isPlaying = StateProvider((ref) => false);

  @override
  void initState() {
    controller =
        VideoPlayerController.networkUrl(Uri.parse(widget.videomodel.content));
    initVideoPlayer = controller.initialize();

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SizedBox(
      width: double.maxFinite,
      //height: height * 0.8,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: height * 0.08),
            child: Row(
              children: [
                CircleAvatar(
                  radius: height * 0.03,
                  backgroundImage: NetworkImage(widget.videomodel.content),
                ),
                Padding(padding: EdgeInsets.only(left: width * 0.03)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.videomodel.name,
                      style: TextStyle(
                          fontSize: width * 0.035, fontWeight: FontWeight.w700),
                    ),
                    Text("1 hour ago",
                        style: TextStyle(
                          fontSize: width * 0.03,
                          fontWeight: FontWeight.w600,
                          color: const Color.fromARGB(255, 168, 165, 165),
                        )),
                  ],
                )
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (ctx) => PostShowingScreen(
                            postId: widget.videomodel.id,
                          )));
            },
            child: SizedBox(
              child: Column(
                children: [
                  FutureBuilder(
                      future: initVideoPlayer,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Column(
                            children: [
                              const Center(
                                child: CircularProgressIndicator(),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text(
                                  "Please wait video was loading",
                                  style: TextStyle(
                                      fontSize: width * 0.045,
                                      fontWeight: FontWeight.w600),
                                ),
                              )
                            ],
                          );
                        }
                        return SizedBox(
                          width: double.maxFinite,
                          height: height * 0.4,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              VideoPlayer(controller),
                              ElevatedButton(
                                  onPressed: () {
                                    if (controller.value.isPlaying) {
                                      ref.read(isPlaying.notifier).state =
                                          !ref.read(isPlaying);
                                    } else {
                                      ref.read(isPlaying.notifier).state =
                                          !ref.read(isPlaying);
                                    }

                                    if (ref.watch(isPlaying)) {
                                      controller.play();
                                    } else {
                                      controller.pause();
                                    }
                                  },
                                  child: Icon(ref.watch(isPlaying)
                                      ? Icons.pause
                                      : Icons.play_arrow))
                            ],
                          ),
                        );
                      }),
                  Padding(padding: EdgeInsets.only(top: height * 0.02)),
                  Align(
                    widthFactor: 12,
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: const Icon(Icons.share),
                      onPressed: () {
                        sharePost(widget.videomodel.id);
                      },
                      color: Colors.black.withOpacity(0.4),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: height * 0.02)),
                  const Divider(
                    thickness: 0.5,
                    color: Color.fromARGB(255, 206, 205, 205),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
