import 'package:social_media_app/Posts/Image/Model/image_post_model.dart';

abstract class ImagePostServices {
  List<PostModel> showingImagePost();
}

class ImageService implements ImagePostServices {
  List<PostModel> imagemodel = [
    PostModel(
        content:
            "A data structure is a way of organizing and storing data in a computer so that it can be accessed and modified efficiently. Common data structures include arrays, linked lists, stacks, queues, trees, and graphs, each suited for different types of operations. They provide a foundation for designing efficient algorithms, enabling tasks like searching, sorting, and data manipulation. Understanding data structures is essential for optimizing performance in programming and solving complex problems.",
        subtile: "subtile",
        type: "text",
        name: "Anshid",
        id: "7"),
    PostModel(
        content:
            "Programming is the process of creating and implementing instructions for computers to perform specific tasks. It involves writing code in languages like Python, Java, or C++, designing algorithms, and solving problems logically. Programmers develop software, websites, apps, and other technologies by breaking down tasks into manageable steps, testing the results, and optimizing for efficiency. It plays a vital role in automation, innovation, and the development of technology-driven solutions across industries.",
        subtile: "subtile",
        type: "text",
        name: "Anshid",
        id: "6"),
    PostModel(
        content:
            "https://videos.pexels.com/video-files/5532762/5532762-uhd_2732_1440_25fps.mp4",
        subtile: "subtile",
        type: "video",
        name: "Anshid",
        id: "5"),
    PostModel(
        content:
            "https://videos.pexels.com/video-files/5532762/5532762-uhd_2732_1440_25fps.mp4",
        subtile: "subtile",
        type: "video",
        name: "Anshid",
        id: "3"),
    PostModel(
        content:
            "https://videos.pexels.com/video-files/4865386/4865386-uhd_2732_1440_25fps.mp4",
        subtile: "subtile",
        type: "video",
        name: "name",
        id: "4"),
    PostModel(
        type: "image",
        id: "1",
        name: "Jack",
        content:
            "https://www.nextdirect.com/nxtcms/resource/blob/5821518/d114a8023263017f86b11c206949508e/shackets-data.jpg",
        subtile:
            "Men are often associated with physical strength, assertiveness, and a problem-solving mindset. They tend to be more competitive and focused on achieving goals. Men also typically have a higher risk tolerance and are more likely to take on leadership roles."),
    PostModel(
        type: "image",
        id: "2",
        name: "Elezabeth",
        content:
            "https://d2csxpduxe849s.cloudfront.net/media/E32629C6-9347-4F84-81FEAEF7BFA342B3/8D7412DC-EBC0-4D6B-8FC828EA9589BEA9/2CEDB06D-597D-4203-9C16B6D7842B949F/WebsiteJpg_XL-FGWH_Main%20Visual_Red_Website.jpg",
        subtile:
            "Women participate in a wide range of sports, including team sports like basketball and soccer, individual sports like running and swimming, combat sports like boxing and taekwondo, winter sports like skiing and snowboarding, and emerging sports like surfing and skateboarding"),
  ];

  @override
  List<PostModel> showingImagePost() {
    return imagemodel;
  }

  static void sharePost() {}
}
