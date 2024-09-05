import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:social_media_app/Posts/Image/Model/image_post_model.dart';
import 'package:social_media_app/Posts/Image/Widgets/imagePostShowing.dart';

class TextPostTile extends StatefulWidget {
  final PostModel imageModel;
  const TextPostTile({super.key, required this.imageModel});

  @override
  State<TextPostTile> createState() => _TextPostTileState();
}

class _TextPostTileState extends State<TextPostTile> {
  void sharePost(String postId) {
    final link = "https://socialmediaapp-e6960.web.app/post?id=$postId";
    Share.share("Check out this  post: $link");
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
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: height * 0.03,
                  //backgroundImage: NetworkImage(widget.imageModel.content),
                ),
                Padding(padding: EdgeInsets.only(left: width * 0.03)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.imageModel.name,
                      style: TextStyle(
                          fontSize: width * 0.035, fontWeight: FontWeight.w700),
                    ),
                    Text("1 hour ago",
                        style: TextStyle(
                          fontSize: width * 0.034,
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
                            postId: widget.imageModel.id,
                          )));
            },
            child: SizedBox(
              child: Column(
                children: [
                  SizedBox(
                    width: double.maxFinite,
                    height: height * 0.4,
                    child: Text(
                      widget.imageModel.content,
                      textAlign: TextAlign.justify,
                      style: TextStyle(fontSize: width * 0.045),
                    ),
                  ),
                  // Padding(padding: EdgeInsets.only(top: height * 0.02)),

                  //Padding(padding: EdgeInsets.only(top: height * 0.02)),
                  Align(
                    widthFactor: 12,
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: const Icon(Icons.share),
                      onPressed: () {
                        sharePost(widget.imageModel.id);
                      },
                      color: Colors.black.withOpacity(0.4),
                    ),
                  ),
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
