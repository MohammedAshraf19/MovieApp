import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../shared/components/components.dart';
import '../../shared/style/asset_manager.dart';
import '../../shared/style/color_manager.dart';
import '../../shared/style/values_manager.dart';
import '../login_screen/login_screen.dart';

class BorderShow{
  String image;
  String title;
  String body;
  BorderShow({
    required this.image,
    required this.title,
    required this.body,
  });
}

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var pageController = PageController();
  bool isLast =false;
  List<BorderShow>border =[
    BorderShow(
        image: AssetsManager.picture1,
        title: 'Unlimited movies, TV shows & more',
        body: 'Watch anywhere. Cancel anytime.'
    ),
    BorderShow(
        image: AssetsManager.picture2,
        title: 'Download and watch offline',
        body: 'Always have something to watch offline.'
    ),
    BorderShow(
        image: AssetsManager.picture3,
        title: 'No pesky contracts',
        body: 'Join today, cancel anytime'
    ),
    BorderShow(
        image: AssetsManager.picture4,
        title: 'Watch everywhere',
        body: 'Stream on your phone, Tablet, Laptop, TV and more.'
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: AppSize.s12,top: AppSize.s12),
          child: SvgPicture.asset(AssetsManager.logo),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: PageView.builder(
                itemBuilder: (context,index){
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:   [
                      Expanded(
                        child:  Image(
                          image: AssetImage(border[index].image),
                          width: double.infinity,
                          //  height: 500,
                        ),
                      ),
                      const SizedBox(height: AppSize.s30,),
                      Text(
                        border[index].title,
                        style: Theme.of(context).textTheme.displayLarge,

                      ),
                      const SizedBox(
                        height: AppSize.s12,
                      ),
                      Text(
                        border[index].body,
                        style:Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  );
                },
                itemCount: border.length,
                controller: pageController,
                physics: const BouncingScrollPhysics(),
                onPageChanged: (int index){
                  if(index == border.length-1) {
                    isLast =true;
                  }
                },
              ),
            ),
            const SizedBox(height: AppSize.s12,),
            Center(
              child: SmoothPageIndicator(
                controller: pageController,
                count: border.length,
                effect: const ExpandingDotsEffect(
                  dotColor: Colors.grey,
                  activeDotColor: ColorManager.white,
                  dotHeight: 10,
                  expansionFactor: 4,
                  dotWidth: 10,
                  spacing: 4,
                ),
              ),
            ),
            const SizedBox(
              height: AppSize.s20,
            ),
            myButton(
                txt: 'Get Started',
                width: MediaQuery.of(context).size.width,
                onpress: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const LoginScreen()));
            },
              context: context,
            ),
          ],
        ),
      ),
    );
  }
}
