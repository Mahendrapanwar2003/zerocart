import 'dart:async';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ui_library/ui_library.dart';
import 'package:zerocart/app/common_methods/common_methods.dart';
import 'package:zerocart/my_theme/my_themedata.dart';
import 'app/routes/app_pages.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  CommonMethods.getNetworkConnectionType();
  StreamSubscription streamSubscription = CommonMethods.checkNetworkConnection();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
    runApp(
      DevicePreview(
        enabled: false,
        builder: (context) => ResponsiveSizer(
          builder: (
            buildContext,
            orientation,
            screenType,
          ) =>
              GetMaterialApp(
            title: "Application",
            initialRoute: AppPages.INITIAL,
            getPages: AppPages.routes,
                themeMode: ThemeMode.system,
            theme: MyThemeData.themeDataLight(
              orientation: orientation,
              fontFamily: "Nunito",
            ),
            darkTheme: MyThemeData.themeDataDark(
              orientation: orientation,
              fontFamily: "Nunito",
            ),
          ),
        ),
      ),
    );
  });
}

/*import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';*/
/*

void main(List<String> args) {
  runApp(Example());
}

class Example extends StatelessWidget {
  const Example({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      color: Colors.white,
      debugShowCheckedModeBanner: false,
      home: VideoPlayersList(),
    );
  }
}

class VideoPlayersList extends StatelessWidget {
  const VideoPlayersList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    List<String> paths = [
      'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
      'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
      'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
      'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
      'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
      'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
      'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
      'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
      'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
    ];

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          ListView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount: paths.length,
            itemBuilder: (BuildContext context, int index) {
              return SizedBox(
                height: 500,
                child: VideoPlay(
                  pathh: paths[index],
                ),
              );
            },
          ),
        ]),
      ),
    );
  }
}

class VideoPlay extends StatefulWidget {
  String? pathh;

  @override
  _VideoPlayState createState() => _VideoPlayState();

  VideoPlay({
    Key? key,
    this.pathh, // Video from assets folder
  }) : super(key: key);
}

class _VideoPlayState extends State<VideoPlay> {
  ValueNotifier<VideoPlayerValue?> currentPosition = ValueNotifier(null);
  VideoPlayerController? controller;
  late Future<void> futureController;

  initVideo() {
    controller = VideoPlayerController.network(widget.pathh??'');

    futureController = controller!.initialize();
  }

  @override
  void initState() {
    initVideo();
    controller!.addListener(() {
      if (controller!.value.isInitialized) {
        currentPosition.value = controller!.value;
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: futureController,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator.adaptive();
        } else {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: SizedBox(
              height: controller?.value.size.height,
              width: double.infinity,
              child: AspectRatio(
                  aspectRatio: controller!.value.aspectRatio,
                  child: Stack(children: [
                    Positioned.fill(
                        child: Container(
                            foregroundDecoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [
                                    Colors.black.withOpacity(.7),
                                    Colors.transparent
                                  ],
                                  stops: [
                                    0,.3
                                  ],
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter),
                            ),
                            child: VideoPlayer(controller!))),
                    Positioned.fill(
                      child: Column(
                        children: [
                          Expanded(
                            flex: 8,
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: GestureDetector(
                                    onDoubleTap: () async {
                                      Duration? position =
                                      await controller?.position;
                                      setState(() {
                                        controller!.seekTo(Duration(
                                            seconds: position!.inSeconds - 10));
                                      });
                                    },
                                    child: const Icon(
                                      Icons.fast_rewind_rounded,
                                      color: Colors.black,
                                      size: 40,
                                    ),
                                  ),
                                ),
                                Expanded(
                                    flex: 4,
                                    child: IconButton(
                                      icon: Icon(
                                        controller!.value.isPlaying
                                            ? Icons.pause
                                            : Icons.play_arrow,
                                        color: Colors.black,
                                        size: 40,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          if (controller!.value.isPlaying) {
                                            controller?.pause();
                                          } else {
                                            controller?.play();
                                          }
                                        });
                                      },
                                    )),
                                Expanded(
                                  flex: 3,
                                  child: GestureDetector(
                                    onDoubleTap: () async {
                                      Duration? position =
                                      await controller?.position;
                                      setState(() {
                                        controller?.seekTo(Duration(
                                            seconds: position!.inSeconds + 10));
                                      });
                                    },
                                    child: const Icon(
                                      Icons.fast_forward_rounded,
                                      color: Colors.black,
                                      size: 40,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                              flex: 3,
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: ValueListenableBuilder(
                                    valueListenable: currentPosition,
                                    builder: (context,
                                        VideoPlayerValue? videoPlayerValue, w) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 10),
                                        child: Row(
                                          children: [
                                            Text(
                                              videoPlayerValue!.position
                                                  .toString()
                                                  .substring(
                                                  videoPlayerValue.position
                                                      .toString()
                                                      .indexOf(':') +
                                                      1,
                                                  videoPlayerValue.position
                                                      .toString()
                                                      .indexOf('.')),
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 22),
                                            ),
                                            const Spacer(),
                                            Text(
                                              videoPlayerValue.duration
                                                  .toString()
                                                  .substring(
                                                  videoPlayerValue.duration
                                                      .toString()
                                                      .indexOf(':') +
                                                      1,
                                                  videoPlayerValue.duration
                                                      .toString()
                                                      .indexOf('.')),
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 22),
                                            ),
                                          ],
                                        ),
                                      );
                                    }),
                              ))
                        ],
                      ),
                    ),
                  ])),
            ),
          );
        }
      },
    );
  }
}*/