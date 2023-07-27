import 'package:flutter/material.dart';
import 'package:shop_pp/models/models.dart';
import 'package:shop_pp/modules/login/login_screen.dart';
import 'package:shop_pp/shared/components/components.dart';
import 'package:shop_pp/shared/components/constants.dart';
import 'package:shop_pp/shared/network/local/cacheHelper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';




class OnBoardingScreen extends StatefulWidget
{
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardcontroller = PageController();

  List<BoardingModel>boarding=[
    BoardingModel(
      image:'assets/images/shop1.jpg',
      title:' onboard 1 title',
      body:' onboard 1 body',
    ),
    BoardingModel(
      image:'assets/images/shop1.jpg',
      title:' onboard 2 title',
      body:' onboard 2 body',
    ),
    BoardingModel(
      image:'assets/images/shop1.jpg',
      title:' onboard 3 title',
      body:' onboard 3 body',
    ),
  ];

  bool is_last=false;
  void submit(){
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) => {
      if(value==true){
        navigateToAndFinish(context,LoginScreen())
      }
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      actions:
      [
        defaultTextButton(
            function: submit,
            text: 'Skip',
        ),
      ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:
          [
            Expanded(
              child: PageView.builder(
                onPageChanged: (int index)
                {
                  if (index==boarding.length-1){
                    setState(() {
                      is_last=true;

                    });
                  }
                  else{
                    is_last=false;

                  }
                },
                physics: const BouncingScrollPhysics(),
                controller: boardcontroller,
                  itemBuilder: (context,index)=>buildBoardItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            const SizedBox(height: 40.0,),
            Row(
              children:
              [
                SmoothPageIndicator(
                    controller: boardcontroller ,
                    effect: const ExpandingDotsEffect(
                      activeDotColor: default_color,
                      dotColor: Colors.grey,
                      dotHeight: 10.0,
                      dotWidth: 10.0,
                      spacing: 5.0,
                      expansionFactor: 4,
                    ),
                    count: boarding.length,
                ),
                const Spacer(),
                FloatingActionButton(
                    onPressed: (){
                      if(is_last){
                        submit();
                      }
                      boardcontroller.nextPage(
                          duration: const Duration(milliseconds: 750),
                          curve: Curves.fastLinearToSlowEaseIn,
                      );
                    },
                  child: const Icon(
                    Icons.arrow_forward_ios,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardItem(BoardingModel model)=>Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children:
    [
      Expanded(child: Image(image: AssetImage(model.image))),
      Text(
        model.title,
        style: const TextStyle(
          fontSize: 25.0,
        ),
      ),
      const SizedBox(height: 15.0,),
      Text(
        model.body,
        style: const TextStyle(
          fontSize: 15.0,
        ),
      ),
      const SizedBox(height: 15.0,),

    ],
  );
}
