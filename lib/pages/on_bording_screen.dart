import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shopappy/pages/login_screen.dart';

class OnBordingScreen extends StatelessWidget {
  List<PageViewModel> listPagesViewModel = [
    PageViewModel(
      title: "Title of first page",
      bodyWidget: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 450,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              // color: Colors.amber
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/onbording_1.jpg')),
            ),
            child: Center(
              child: Text(
                'Screen Title',
                // style: Theme.of(context).textTheme.headline1,
              ),
            ),
          ),
        ],
      ),
    ),
    PageViewModel(
      title: "Title of first page",
      bodyWidget: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 450,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              // color: Colors.amber
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/onbording_2.jpg')),
            ),
            child: Center(
              child: Text(
                'Screen Title',
                // style: Theme.of(context).textTheme.headline1,
              ),
            ),
          ),
        ],
      ),
    ),
    PageViewModel(
      title: "Title of first page",
      bodyWidget: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 450,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              // color: Colors.amber
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/onbording_3.jpg')),
            ),
            child: Center(
              child: Text(
                'Screen Title',
                // style: Theme.of(context).textTheme.headline1,
              ),
            ),
          ),
        ],
      ),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      body: IntroductionScreen(
        pages: listPagesViewModel,
        onDone: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => LoginScreen(),
            ),
          );
        },
        showNextButton: true,
        showBackButton: false,
        showSkipButton: true,
        next: const Text("Next"),
        skip: const Text("Skip"),
        done: const Text("Done", style: TextStyle(fontWeight: FontWeight.w600)),
        dotsDecorator: DotsDecorator(
          size: const Size.square(10.0),
          activeSize: const Size(20.0, 10.0),
          activeColor: Theme.of(context).accentColor,
          color: Colors.black26,
          spacing: const EdgeInsets.symmetric(horizontal: 3.0),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
        ),
      ),
      // body: Stack(
      //   children: [
      //     Container(
      //       width: size.width,
      //       height: size.height,
      //       decoration: BoxDecoration(
      //         // color: Colors.amber
      //         image: DecorationImage(
      //             fit: BoxFit.cover,
      //             image: AssetImage('assets/images/onbording_1.jpg')),
      //       ),
      //     ),
      //     Center(
      //         child: Text(
      //       'Screen Title',
      //       style: Theme.of(context).textTheme.headline1,
      //     ))
      //   ],
      // ),
    );
  }
}
