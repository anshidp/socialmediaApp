import 'package:flutter/material.dart';
import 'package:social_media_app/Posts/Image/Model/image_post_model.dart';
import 'package:social_media_app/Posts/Image/Services/image_services.dart';
import 'package:social_media_app/Posts/Video/widgets/videoPostTile.dart';

class VideoPostScreen extends StatefulWidget {
  const VideoPostScreen({super.key});

  @override
  State<VideoPostScreen> createState() => _VideoPostScreenState();
}

class _VideoPostScreenState extends State<VideoPostScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.05,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Builder(builder: (context) {
                ImageService imageService = ImageService();
                PostModel postmodel = imageService
                    .showingImagePost()
                    .where((element) => element.type == "video")
                    .toList()
                    .first;
                return SizedBox(
                  width: double.maxFinite,
                  height: height * 0.84,
                  child: VideoTile(videomodel: postmodel),
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
