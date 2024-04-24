import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kmc/components/bottomNavBar.dart';
import 'package:kmc/config/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class NewOnBoardingScreen extends StatefulWidget {
  const NewOnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<NewOnBoardingScreen> createState() => _NewOnBoardingScreenState();
}

class _NewOnBoardingScreenState extends State<NewOnBoardingScreen> {
  int currentIndex = 0;
  late PageController _pageController;
  @override
  void initState() {
    _pageController = PageController(
      initialPage: 0,
      viewportFraction: 0.999,
    );
    super.initState();
  }

  final PageController pageController = PageController();
  int currentPageNumber = 0;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              physics: AlwaysScrollableScrollPhysics(),
              itemCount: 4,
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemBuilder: (_, i) {
                return Stack(
                  children: [
                    SizedBox(
                      height: Get.height,
                      child: Image.asset(
                        'assets/images/onboarding/${i + 1}.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      bottom: 150,
                      right: Get.width / 2 - 40,
                      child: SmoothPageIndicator(
                        controller: _pageController,
                        count: 4,
                        effect: WormEffect(
                          spacing: 12,
                          dotColor: Colors.white,
                          activeDotColor: Colors.yellow,
                        ),
                        onDotClicked: (i) {
                          PageController().initialPage == 3
                              ? Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => BottomNavBar(),
                                  ),
                                )
                              : pageController.animateToPage(
                                  i,
                                  duration: const Duration(milliseconds: 1),
                                  curve: Curves.easeIn,
                                );
                        },
                      ),
                    ),
                    Positioned(
                        bottom: 80,
                        right: Get.width / 2 - 63,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            side: const BorderSide(color: Colors.white),
                            shape: StadiumBorder(),
                            backgroundColor: secondary,
                          ),
                          onPressed: () {
                            setState(
                              () async {
                                SharedPreferences pref =
                                    await SharedPreferences.getInstance();
                                pref.setBool("onBoardingCompleted", true);
                                currentIndex == 3
                                    ? Get.off(
                                        BottomNavBar(),
                                      )
                                    : _pageController.nextPage(
                                        duration: Duration(
                                          microseconds: 1,
                                        ),
                                        curve: Curves.easeIn,
                                      );
                              },
                            );
                          },
                          child: Row(
                            children: [
                              Text(
                                '    अर्को पाना    ',
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                              Icon(Icons.arrow_forward)
                            ],
                          ),
                        ))
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
