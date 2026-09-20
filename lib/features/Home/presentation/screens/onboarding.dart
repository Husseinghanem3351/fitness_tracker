import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../generated/l10n.dart';
import '../../../../global/global_methods.dart';
import '../../data/cache helper.dart';
import 'info_screen.dart';

class OnBoardingModel {
  final String title;
  final String body;
  final IconData icon;

  OnBoardingModel({
    required this.title,
    required this.body,
    required this.icon,
  });
}

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();

  bool isLast = false;

  void submit() {
    CacheHelper.putData(key: 'onBoarding', value: true).then((value) {
      if (value) {
        navigateAndFinish(context, const InfoScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<OnBoardingModel> boarding = [
      OnBoardingModel(
        title: S.of(context).onboardingTitle1,
        body: S.of(context).onboardingBody1,
        icon: Icons.track_changes_rounded,
      ),
      OnBoardingModel(
        title: S.of(context).onboardingTitle2,
        body: S.of(context).onboardingBody2,
        icon: Icons.pie_chart_rounded,
      ),
      OnBoardingModel(
        title: S.of(context).onboardingTitle3,
        body: S.of(context).onboardingBody3,
        icon: Icons.water_drop_rounded,
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: submit,
            child: Text(
              S.of(context).skip,
              style: TextStyle(
                color: Colors.indigo[900],
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                controller: boardController,
                onPageChanged: (int index) {
                  if (index == boarding.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                itemBuilder: (context, index) =>
                    buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  effect: const ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    activeDotColor: Colors.indigo,
                    dotHeight: 10,
                    expansionFactor: 4,
                    dotWidth: 10,
                    spacing: 5.0,
                  ),
                  count: boarding.length,
                ),
                const Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      submit();
                    } else {
                      boardController.nextPage(
                        duration: const Duration(
                          milliseconds: 750,
                        ),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                  backgroundColor: Colors.indigo,
                  child: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(OnBoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(40),
                decoration: BoxDecoration(
                  color: Colors.indigo.withOpacity(0.05),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  model.icon,
                  size: 150,
                  color: Colors.indigo,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            model.title,
            style: const TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Colors.indigo,
            ),
          ),
          const SizedBox(
            height: 15.0,
          ),
          Text(
            model.body,
            style: const TextStyle(
              fontSize: 16.0,
              color: Colors.blueGrey,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      );
}
