import 'package:flutter/material.dart';
import 'package:social_media_app/Posts/Image/Model/image_post_model.dart';
import 'package:social_media_app/Posts/Image/Services/image_services.dart';
import 'package:social_media_app/Posts/Text/Widgets/textPostTile.dart';

class TextPostScreen extends StatefulWidget {
  const TextPostScreen({super.key});

  @override
  State<TextPostScreen> createState() => _TextPostScreenState();
}

class _TextPostScreenState extends State<TextPostScreen> {
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
                    .where((element) => element.type == "text")
                    .toList();
                return SizedBox(
                  width: double.maxFinite,
                  height: height * 0.84,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: postmodel.length,
                      itemBuilder: (ctx, index) {
                        return TextPostTile(imageModel: postmodel[index]);
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
