import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_media_app/Posts/Image/Model/image_post_model.dart';
import 'package:social_media_app/Posts/Image/Services/image_services.dart';
import 'package:video_player/video_player.dart';

class PostShowingScreen extends ConsumerStatefulWidget {
  final String postId;
  const PostShowingScreen({super.key, required this.postId});

  @override
  ConsumerState<PostShowingScreen> createState() => _PostShowingScreenState();
}

class _PostShowingScreenState extends ConsumerState<PostShowingScreen> {
  PostModel? imagePostModel;
  VideoPlayerController? controller;
  Future<void>? initVideoPlayer;
  final isPlaying = StateProvider((ref) => false);
  @override
  void initState() {
    final imageservice = ImageService();
    List<PostModel> imagePost = imageservice.imagemodel;
    setState(() {
      imagePostModel = imagePost
          .where((element) => element.id == widget.postId)
          .toList()
          .first;
    });

    print(imagePostModel?.content);
    print("-----------------");

    super.initState();
  }

  Future<void> initializevideo() async {
    controller = VideoPlayerController.networkUrl(
        Uri.parse(imagePostModel?.content ?? ""));
    initVideoPlayer = controller?.initialize();
  }

  @override
  void didChangeDependencies() {
    if (imagePostModel?.type == "video") {
      initializevideo();
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              SizedBox(
                child: Column(
                  children: [
                    imagePostModel?.type == "video"
                        ? FutureBuilder(
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
                                    VideoPlayer(controller!),
                                    ElevatedButton(
                                        onPressed: () {
                                          if (controller!.value.isPlaying) {
                                            ref.read(isPlaying.notifier).state =
                                                !ref.read(isPlaying);
                                          } else {
                                            ref.read(isPlaying.notifier).state =
                                                !ref.read(isPlaying);
                                          }

                                          if (ref.watch(isPlaying)) {
                                            controller?.play();
                                          } else {
                                            controller?.pause();
                                          }
                                        },
                                        child: Icon(ref.watch(isPlaying)
                                            ? Icons.pause
                                            : Icons.play_arrow))
                                  ],
                                ),
                              );
                            })
                        : imagePostModel?.type == "image"
                            ? Column(
                                children: [
                                  Container(
                                    width: double.maxFinite,
                                    height: height * 0.4,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                imagePostModel?.content ?? ""),
                                            fit: BoxFit.fill),
                                        borderRadius: BorderRadius.circular(8)),
                                  ),
                                  Padding(
                                      padding:
                                          EdgeInsets.only(top: height * 0.02)),
                                  ConstrainedBox(
                                    constraints: BoxConstraints(
                                        maxWidth: width * 0.8,
                                        minWidth: height * 0.03),
                                    child: Text(imagePostModel?.subtile ?? '',
                                        style: TextStyle(
                                            color: const Color.fromARGB(
                                                255, 190, 182, 182),
                                            fontSize: width * 0.04,
                                            fontWeight: FontWeight.w500)),
                                  ),
                                ],
                              )
                            : Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: SizedBox(
                                  width: double.maxFinite,
                                  height: height * 0.4,
                                  child: Text(
                                    imagePostModel?.content ?? "",
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(fontSize: width * 0.045),
                                  ),
                                ),
                              ),
                  ],
                ),
              )
            ])));
  }
}
