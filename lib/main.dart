import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_media_app/Posts/Image/Widgets/imagePostShowing.dart';
import 'package:social_media_app/firebase_options.dart';
import 'package:uni_links/uni_links.dart';

import 'Navbar/navigation_bar.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    if (kIsWeb) {
      await Firebase.initializeApp(
          options: const FirebaseOptions(
              apiKey: "AIzaSyC81Da1XS6JqFk96ALKbB-RatWcwOho4Po",
              authDomain: "socialmediaapp-e6960.firebaseapp.com",
              projectId: "socialmediaapp-e6960",
              storageBucket: "socialmediaapp-e6960.appspot.com",
              messagingSenderId: "953663865599",
              appId: "1:953663865599:web:2f87dcf8a151fef97942ca"));
    } else {
      await Firebase.initializeApp(options: DefaultFirebaseOptions.android);
    }
  } catch (e) {
    print('Error Initializing Firebase: $e');
  }
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void _initDeepLinkListener() async {
    try {
      Uri? initialLink = await getInitialUri();

      print('working: $initialLink');
      if (initialLink != null) {
        print('initialLink: $initialLink');
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          if (context.mounted) {
            _handleDeepLink(initialLink);
          }
        });
      }

      linkStream.listen((String? link) {
        if (link != null) {
          Uri uri = Uri.parse(link);
          _handleDeepLink(uri);
        }
      }, onError: (err) {
        // Handle error
        print('Error occurred: $err');
      });
    } on PlatformException catch (e) {
      print(e.message);
    }
  }

  void _handleDeepLink(Uri uri) {
    String? postId = uri.queryParameters['id'];
    print('PostId====================$postId');
    if (postId != null) {
      // Navigate to the post details page based on postId

      if (context.mounted) {
        print('PostId====================$postId');
        navigatorKey.currentState!.push(
          MaterialPageRoute(
              builder: (context) => PostShowingScreen(
                    postId: postId,
                  )),
        );
      }
    }
  }

  @override
  void initState() {
    _initDeepLinkListener();
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: (RouteSettings settings) {
        final uri = Uri.parse(settings.name ?? "");

        if (uri.pathSegments.first == 'post' &&
            uri.queryParameters['id'] != null) {
          final postId = uri.queryParameters['id'];
          return MaterialPageRoute(
            builder: (context) => PostShowingScreen(postId: postId!),
          );
        }

        // Fallback to default route
        return MaterialPageRoute(builder: (context) => const NavBar());
      },
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'SocialMediaApp',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff43D663)),
        useMaterial3: true,
      ),
      home: const NavBar(),
    );
  }
}
