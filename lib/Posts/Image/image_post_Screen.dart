import 'package:flutter/material.dart';
import 'package:social_media_app/Posts/Image/Services/image_services.dart';
import 'package:social_media_app/Posts/Image/Widgets/imagePost.dart';

import 'Model/image_post_model.dart';

class ImagePostScreen extends StatefulWidget {
  const ImagePostScreen({super.key});

  @override
  State<ImagePostScreen> createState() => _ImagePostScreenState();
}

class _ImagePostScreenState extends State<ImagePostScreen> {
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
                List<PostModel> postmodel = imageService
                    .showingImagePost()
                    .where((element) => element.type == "image")
                    .toList();
                return SizedBox(
                  width: double.maxFinite,
                  height: height * 0.84,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: postmodel.length,
                      itemBuilder: (ctx, index) {
                        return ImagePostTile(imageModel: postmodel[index]);
                      }),
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
